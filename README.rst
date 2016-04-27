
.. _django-socketio: https://github.com/stephenmcd/django-socketio
.. _gevent-socketio: https://github.com/abourget/gevent-socketio
.. _tox.ini: tox.ini
.. _settings.py: DjangoTestWebsockets/settings.py
.. _urls.py: DjangoTestWebsockets/urls.py
.. _index.html: myapp/templates/myapp/index.html

Tests for django-socketio_
==========================

.. contents::
    :depth: 2
    :backlinks: none

Summary
-------
Compatibility with Python and Django
````````````````````````````````````
django-socketio_ **(version 0.3.9) do not works**, however the Python version or Django version.

============  ==========  ================  ====================  ========================  =============
Python        Django      More details      Django server works?  Websockets server works?  Does it work?
============  ==========  ================  ====================  ========================  =============
Python 2.7    Django 1.8  `py27-django18`_  ✓ Yes                 ✗ No                      ✗ **No**
Python 2.7    Django 1.9  `py27-django19`_  ✗ No                  ✗ No                      ✗ **No**
Python 3.2    Django 1.8  `py32-django18`_  ✗ No                  ✗ No                      ✗ **No**
Python 3.3    Django 1.8  `py33-django18`_  ✗ No                  ✗ No                      ✗ **No**
Python 3.3    Django 1.9  `py33-django19`_  ✗ No                  ✗ No                      ✗ **No**
Python 3.4    Django 1.9  `py34-django19`_  ✗ No                  ✗ No                      ✗ **No**
Python 3.5    Django 1.8  `py35-django18`_  ✗ No                  ✗ No                      ✗ **No**
Python 3.5    Django 1.9  `py35-django19`_  ✗ No                  ✗ No                      ✗ **No**
============  ==========  ================  ====================  ========================  =============

Easy to install?
````````````````
Looks easy to install, but in fact it do not works. :-)

Read more at `Installation`_.

Integration into a Django project
`````````````````````````````````
Easy, but I said django-socketio_ do not works.

Read more at `Integration`_.


Thin or heavy architecture?
```````````````````````````
Who cares? It do not works. (but it's thin!)

Read more at `Architecture`_.

Event-driven programming?
`````````````````````````
Yes, good point, but still do not works!

Read more at `Event-driven programming`_.

Has a documentation?
````````````````````
Yes, a nice written one.

Read more at `Documentation`_.

Has unit tests?
```````````````
Yes, about 6 assertions.

Read more at `Unit tests`_.

----------------------------------------------------------------------------------------------------------------------

Installation
------------
As said before, django-socketio_ only works with version 2.7 of Python.

.. code-block:: bash

    $ mkvirtualenv --python=/usr/bin/python2.7 dtws-django-socketio
    # You are now in your new virtual environment
    $ pip install django-socketio==0.3.9 tox


Integration
-----------
Add `django_socketio` to your `INSTALLED_APPS` in your settings.py_ file:

.. code-block:: python

    INSTALLED_APPS = [
        # ...
        'django_socketio',
    ]

Add `django_socketio.urls` to your urls.py_ file:

.. code-block:: python

    urlpatterns = [
        url('', include('django_socketio.urls')),
        # ...
    ]

Integration into a template:

.. code-block:: html+django

    {% load staticfiles %}

    <script src="{% static 'js/socket.io.js' %}"></script>
    <script>
        var socket = new io.Socket('localhost', {port: 9000})
        socket.connect()
    </script>

Compatibility
-------------
As said before, django-socketio_ does not work. So there is no need to run Django server, SocketIO server, or any tests.

Running SocketIO server
```````````````````````
If you are really a disgusting masochist, you can run SocketIO server with:

.. code-block:: bash

    $ workon dtws-django-socketio
    $ python manage.py runserver_socketio

Then, ``SocketIOServer running on 127.0.0.1:9000`` will appears on your screen.

If you try to connect to the SocketIO server in your browser, you will get an error about the handshake:

.. code-block::

    File "/home/hugo/Dev/DjangoTestWebsockets/.tox/py27-django18/local/lib/python2.7/site-packages/socketio/transports.py", line 19, in write_packed
      self.write(data)
    File "/home/hugo/Dev/DjangoTestWebsockets/.tox/py27-django18/local/lib/python2.7/site-packages/socketio/transports.py", line 22, in write
      if 'Content-Length' not in self.handler.response_headers_list:

    AttributeError: 'SocketIOHandler' object has no attribute 'response_headers_list'
    <Greenlet at 0xb66c57fcL: _handle_and_close_when_done(<bound method SocketIOServer.handle of <SocketIOSe, <bound method SocketIOServer.do_close of <SocketIO, (<socket at 0xb54de7acL fileno=[Errno 9] Bad file )> failed with AttributeError

I found a thread [#]_ about this error, where I tried a *working solution* [#]_:

.. code-block:: bash

    $ pip uninstall gevent-socketio gevent
    $ pip install gevent-socketio==0.2.1 gevent==0.13.6

.. [#] https://github.com/stephenmcd/django-socketio/issues/63
.. [#] https://github.com/stephenmcd/django-socketio/issues/63#issuecomment-136751471

Then re-run the SocketIO server, and immediately after, you will get an other error:

.. code-block::

    File "/home/hugo/Dev/DjangoTestWebsockets/.tox/py27-django18/local/lib/python2.7/site-packages/gevent/socket.py", line 784, in <module>
      from gevent.ssl import sslwrap_simple as ssl, SSLError as sslerror, SSLSocket as SSLType
    File "/home/hugo/Dev/DjangoTestWebsockets/.tox/py27-django18/local/lib/python2.7/site-packages/gevent/ssl.py", line 422, in <module>
      def get_server_certificate(addr, ssl_version=PROTOCOL_SSLv3, ca_certs=None):

    NameError: name 'PROTOCOL_SSLv3' is not defined

I found again a thread [#]_ about this error, and I was due to my Python version (2.7 on Debian) that was compiled with
``OPENSSL_NO_SSLv3`` flag [#]_.

.. [#] https://github.com/docker-library/python/issues/29
.. [#] https://github.com/docker-library/python/issues/29#issuecomment-69251731

Test compatibility with different version of Python and Django
``````````````````````````````````````````````````````````````
To list available tests, you can run:

.. code-block:: bash

    $ tox -l

To run a specific test, run for example:

.. code-block:: bash

    $ tox -e py27-django18

py27-django18
`````````````
Django server works?
....................


Websockets server works?
........................


py27-django19
`````````````
Django server works?
....................


Websockets server works?
........................


py32-django18
`````````````
Django server works?
....................


Websockets server works?
........................


py33-django18
`````````````
Django server works?
....................


Websockets server works?
........................


py33-django19
`````````````
Django server works?
....................


Websockets server works?
........................


py34-django19
`````````````
Django server works?
....................


Websockets server works?
........................


py35-django18
`````````````
Django server works?
....................


Websockets server works?
........................


py35-django19
`````````````
Django server works?
....................


Websockets server works?
........................




Architecture
------------
Thin architecture, django-socketio_ only uses gevent-socketio_ to work.


Event-driven programming
------------------------
Yes, django-socketio_ try to use a SocketIO approach to handle websockets events.

Here a really small example for a webchat:

.. code-block:: python

    import django_socket import events

    @events.on_connect
    def connect(request, socket, context):
        print("We got a new user on the chat")
        # ...

    @events.on_finish
    def finish(request, socket, context):
        print("An user just leave the chat")
        # ...


You can see more on the `official demo <https://github.com/stephenmcd/django-socketio/blob/master/django_socketio/example_project/chat/events.py>`_.

Documentation
-------------
Yes, the documentation is written into the `README file <https://github.com/stephenmcd/django-socketio#readme>`_
of django-socketio_ repo.

Unit tests
----------
Yes, django-socketio_ has some tests. You can see these in `this file <https://github.com/stephenmcd/django-socketio/blob/master/django_socketio/tests.py>`_.
