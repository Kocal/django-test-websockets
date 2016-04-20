.. _django-websocket-redis: https://github.com/jrief/django-websocket-redis
.. _redis: http://redis.io
.. _tox.ini: tox.ini
.. _settings.py: DjangoTestWebsockets/settings.py
.. _urls.py: DjangoTestWebsockets/urls.py
.. _index.html: myapp/templates/myapp/index.html

Tests for django-websocket-redis_
=================================
.. contents::
    :depth: 2
    :backlinks: none

Summary
-------
Compatibility with Python and Django
````````````````````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

============  ==========  ================  ====================  ========================  =============
Python        Django      More details      Django server works?  Websockets server works?  Does it work?
============  ==========  ================  ====================  ========================  =============
Python 2.7    Django 1.8  `py27-django18`_  ✓ Yes or ✗ No         ✓ Yes or ✗ No             **✓ Yes/✗ No**
Python 2.7    Django 1.9  `py27-django19`_  ✓ Yes or ✗ No         ✓ Yes or ✗ No             **✓ Yes/✗ No**
Python 3.3    Django 1.8  `py33-django18`_  ✓ Yes or ✗ No         ✓ Yes or ✗ No             **✓ Yes/✗ No**
Python 3.3    Django 1.9  `py33-django19`_  ✓ Yes or ✗ No         ✓ Yes or ✗ No             **✓ Yes/✗ No**
Python 3.4    Django 1.8  `py34-django18`_  ✓ Yes or ✗ No         ✓ Yes or ✗ No             **✓ Yes/✗ No**
Python 3.4    Django 1.9  `py34-django19`_  ✓ Yes or ✗ No         ✓ Yes or ✗ No             **✓ Yes/✗ No**
Python 3.5    Django 1.9  `py35-django19`_  ✓ Yes or ✗ No         ✓ Yes or ✗ No             **✓ Yes/✗ No**
============  ==========  ================  ====================  ========================  =============

Easy to install?
````````````````
Yes, but dependant of Redis_.

Read more at `Installation`_.

Integration into a Django project
`````````````````````````````````
Hard, I need to rewrite the *ws4redis.js* file.

Read more at `Integration`_.

Thin or heavy architecture?
```````````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Read more at `Architecture`_.

Event-driven programming?
`````````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Read more at `Event-driven programming`_.

Has a documentation?
````````````````````
Yes.

Read more at `Documentation`_.

Has unit tests?
```````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Read more at `Unit tests`_.

----------------------------------------------------------------------------------------------------------------------

Installation
------------
*For more information, you can see the* `Installation section <http://django-websocket-redis.readthedocs.org/en/latest/
installation.html#installation>`_ *from the official documentation.*

To use django-websocket-redis_, you need to install `Redis`_.

Please, make sure to be into a virtual environment before running Tox:

.. code-block:: bash

    $ mkvirtualenv --python=/usr/local/bin/python3.4 dtws-django-websocket-redis
    # You are now in your new virtual environment
    $ pip install tox

To check if Redis is up and accepting connections, run:

.. code-block:: bash

    $ redis-cli ping
    PONG

Integration
-----------
*For more information, you can see the* `Configuration section <http://django-websocket-redis.readthedocs.org/en/latest/
installation.html#configuration>`_ *from the official documentation.*

Add *ws4redis* to your *INSTALLED_APPS* in your settings.py_ file:

.. code-block:: python

    INSTALLED_APPS = [
        # ...
        'ws4redis',
    ]

Always in your settings.py_ file, specify the URL that distinguishes websocket connections from normal requests:

.. code-block:: python

    WEBSOCKET_URL = '/ws/'

If your Redis_ settings are different than the defaults, use this dictionary in your settings.py_ to override these values:

.. code-block:: python

    WS4REDIS_CONNECTION = {
        'host': 'redis.example.com',
        'port': 16379,
        'db': 17,
        'password': 'verysecret',
    }

Then, you need to add *ws4redis* context_processors to your Django application:

.. code-block:: python

    TEMPLATES = [
        {
            'OPTIONS': {
                'context_processors': [
                    #...
                    'django.contrib.auth.context_processors.auth',
                    'django.template.context_processors.static'
                    'ws4redis.context_processors.default',
                    #...
                ]
            }
        }

During your development, you will need to change your *WSGI_APPLICATION* value from your settings.py file.
I assure you, it will not be used in production while you will use *uwsgi*, *gunicorn* or something else to run your Django
server:

.. code-block:: python

    WSGI_APPLICATION = 'ws4redis.django_runserver.application'

And then you need to add *WS4REDIS_HEARTBEAT* to your settings.py_ file to keep Websockets alive.
*See* `official documentation <http://django-websocket-redis.readthedocs.org/en/latest/heartbeats.html#sending-and-
receiving-heartbeat-messages>`_.

.. code-block:: python

    WS4REDIS_HEARTBEAT = '--my-heartbeat--'

Compatibility
-------------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Running websockets server
`````````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

.. code-block:: bash

    $ workon dtws-django-websocket-redis
    $ COMMAND TO RUN

Running Django server
`````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

.. code-block:: bash

    $ workon dtws-django-websocket-redis
    $ python manage.py migrate
    $ python manage.py runserver


Test compatibility with different version of Python and Django
``````````````````````````````````````````````````````````````
To list available tests, you can run:

.. code-block:: bash

    $ tox -l

To run a specific test, run for example:

.. code-block:: bash

    $ tox -e py27-django19

py27-django18
`````````````
Websockets server works?
''''''''''''''''''''''''
**✓ Passed!**

NEED TO REWRITE THE JS LIBRARY

Output
......
.. code-block::

    py27-django18 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!**

Output
......
.. code-block::

    py27-django18 runtests: commands[1] | python manage.py runserver
    #...

py27-django19
`````````````
Websockets server works?
''''''''''''''''''''''''
**✓ Passed!**

Output
......
.. code-block::

    py27-django19 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!**

Output
......
.. code-block::

    py27-django19 runtests: commands[1] | python manage.py runserver
    #...

py33-django18
`````````````
Websockets server works?
''''''''''''''''''''''''
**✗ Failed.**

File "<frozen importlib._bootstrap>", line 868, in _load_module
File "<frozen importlib._bootstrap>", line 313, in _call_with_frames_removed
File "/home/hugo/Dev/DjangoTestWebsockets/.tox/py33-django18/lib/python3.3/site-packages/django/db/backends/sqlite3/base.py", line 36, in <module>
raise ImproperlyConfigured("Error loading either pysqlite2 or sqlite3 modules (tried in that order): %s" % exc)
django.core.exceptions.ImproperlyConfigured: Error loading either pysqlite2 or sqlite3 modules (tried in that order): No module named '_sqlite3'
ERROR: InvocationError: '/home/hugo/Dev/DjangoTestWebsockets/.tox/py33-django18/bin/python manage.py migrate'


Output
......
.. code-block::

    py33-django18 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
 **✗ Failed.**

Output
......
.. code-block::

    py33-django18 runtests: commands[1] | python manage.py runserver
    #...

py34-django18
`````````````
Websockets server works?
''''''''''''''''''''''''
**✓ Passed!**

Output
......
.. code-block::

    py34-django18 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!**

Output
......
.. code-block::

    py34-django18 runtests: commands[1] | python manage.py runserver
    #...

py33-django19
`````````````
Websockets server works?
''''''''''''''''''''''''
**✓ Passed!**

Output
......
.. code-block::

    py33-django19 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!**

Output
......
.. code-block::

    py33-django19 runtests: commands[1] | python manage.py runserver
    #...

py34-django19
`````````````
Websockets server works?
''''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py34-django19 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py34-django19 runtests: commands[1] | python manage.py runserver
    #...

py35-django19
`````````````
Websockets server works?
''''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py35-django19 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py35-django19 runtests: commands[1] | python manage.py runserver
    #...

Architecture
------------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Event-driven programming
------------------------
Here a really small example for a webchat:

.. code-block:: python

    # example

Documentation
-------------
Yes, a documentation is available for django-websocket-redis_ at `this address <http://django-websocket-redis.readthedocs.org/en/latest/index.html>`_.

Unit tests
----------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.
