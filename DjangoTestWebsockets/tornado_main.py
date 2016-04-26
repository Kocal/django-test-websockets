#!/usr/bin/env python

# Run this with
# PYTHONPATH=. DJANGO_SETTINGS_MODULE=testsite.settings testsite/tornado_main.py
# Serves by default at
# http://localhost:8080/hello-tornado and
# http://localhost:8080/hello-django


import django.core.handlers.wsgi
import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.websocket
import tornado.wsgi
from tornado.options import options, define, parse_command_line

from myapp import hellowebsocket

if django.VERSION[1] > 5:
    django.setup()

define('port', type=int, default=8080)


class HelloHandler(tornado.web.RequestHandler):
    def get(self):

        self.write(
            """
            <!DOCTYPE html><html><body>
            <h1>Hello from tornado!</h1>
            <form name="send">
                <input id="msg">
                <input type="submit" value="Send">
            </form>

            <script>
               var ws = new WebSocket("ws://127.0.0.1:8080/ws/hello-tornado");
               var $form = document.querySelector('form[name="send"]');
               var $msg = document.querySelector('input#msg');

               ws.onopen = function() {
                  ws.send("Hello, world");

                  $form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    ws.send($msg.value);
                  }, false);
               };

               ws.onmessage = function (evt) {
                  alert("Response from server: " + evt.data);
               };
            </script>
            </body></html>
            """
        )


def main():
    parse_command_line()
    wsgi_app = tornado.wsgi.WSGIContainer(django.core.handlers.wsgi.WSGIHandler())

    tornado_app = tornado.web.Application([
        ('/hello-tornado', HelloHandler),
        ('/ws/hello-tornado', hellowebsocket.HelloWebSocket),
        (r'/static/(.*)', tornado.web.StaticFileHandler, {'path': 'static'}),
        ('.*', tornado.web.FallbackHandler, dict(fallback=wsgi_app)),
    ])

    server = tornado.httpserver.HTTPServer(tornado_app)
    server.listen(options.port)

    print("Tornado server started on port %s" % options.port)

    tornado.ioloop.IOLoop.instance().start()

if __name__ == '__main__':
    main()
