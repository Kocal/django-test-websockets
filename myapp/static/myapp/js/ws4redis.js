/**
 * Created by hugo on 20/04/16.
 */

function WS4Redis(options) {

    this.options = $.extend({heartbeat_msg: null}, options);

    if (!(this instanceof WS4Redis)) {
        return new WS4Redis(options);
    }

    if (this.options.uri === undefined) {
        throw new Error('No Websocket URI in options');
    }

    this.ws = null;
    this.deferred = $.Deferred();
    this.attempts = 0;
    this.missed_heartbeats = 0;
    this.timer = null;

    this.connect();
}

WS4Redis.prototype.connect = function () {
    var self = this;

    try {
        console.log('Connecting to ' + this.options.uri + " . . .");
        this.ws = new WebSocket(this.options.uri);

        // When Websocket.onXXX is called, it's called like this: this.onopen.apply(this, event);
        // So it makes the WS4Redis object undefined in our callbacks.
        // The solution is to override this .apply call by passing:
        //  - `this` WebSocket object
        //  - `self` WS4Redis object
        //  - `e`    Event
        this.ws.onopen = function () {
            self.on_open.apply(this, [self]);
        };
        this.ws.onmessage = function (e) {
            self.on_message.apply(this, [self, e]);
        };
        this.ws.onerror = function (e) {
            self.on_error.apply(this, [self, e]);
        };
        this.ws.onclose = function (e) {
            self.on_close.apply(this, [self, e]);
        };
    } catch (err) {
        console.error(err);
    }
};

WS4Redis.prototype.send_message = function (message) {
    this.ws.send(message);
};

WS4Redis.prototype.send_heartbeat = function () {
    try {
        this.missed_heartbeats++;

        if (this.missed_heartbeats > 3) {
            throw new Error("Too many missed heartbeats.");
        }

        this.ws.send(this.options.heartbeat_msg);
    } catch (e) {
        console.warn("Closing connection. Reason: " + e.message);

        clearInterval(this.options.heartbeat_interval);
        this.options.heartbeat_interval = null;
        this.ws.close();
    }
};

WS4Redis.prototype.generate_interval = function (k) {
    var maxInterval = (Math.pow(2, k) - 1) * 1000;

    // If the generated interval is more than 30 seconds, truncate it down to 30 seconds.
    if (maxInterval > 30 * 1000) {
        maxInterval = 30 * 1000;
    }

    // generate the interval to a random number between 0 and the maxInterval determined from above
    return Math.random() * maxInterval;
};

WS4Redis.prototype.on_open = function (ws4redis) {
    console.info('Connection opened!');

    ws4redis.attempts = 1;

    if (ws4redis.options.heartbeat_msg && ws4redis.heartbeat_interval === null) {
        ws4redis.missed_heartbeats = 0;
        ws4redis.heartbeat_interval = setInterval(ws4redis.send_heartbeat, 5000);
    }
};

WS4Redis.prototype.on_message = function (ws4redis, event) {
    console.log(event.data);
    
    if (ws4redis.options.heartbeat_msg && event.data === ws4redis.options.heartbeat_msg) {
        ws4redis.missed_heartbeats = 0;
    } else if (typeof ws4redis.options.receive_message === 'function') {
        return ws4redis.options.receive_message(event.data);
    } else {
        console.log("There is nothing to handle this message: " + event.data);
    }
};

WS4Redis.prototype.on_error = function (ws4redis, event) {
    console.error("Websocket connection is broken!", event);
};

WS4Redis.prototype.on_close = function (ws4redis, event) {
    console.info("Connection closed!");

    if (!this.timer) {
        // try to reconnect
        var interval = ws4redis.generate_interval(ws4redis.attempts);
        this.timer = setTimeout(function () {
            ws4redis.attempts++;
            ws4redis.connect();
        }, interval);
    }
};
