.. _django-websocket-redis: https://github.com/jrief/django-websocket-redis
.. _redis: http://redis.io
.. _tox.ini: tox.ini
.. _settings.py: DjangoTestWebsockets/settings.py
.. _chatserver.settings: chatserver/settings.py
.. _urls.py: DjangoTestWebsockets/urls.py

Tests for django-websocket-redis_
=================================

- GitHub repo: https://github.com/jrief/django-websocket-redis
- Documentation: http://django-websocket-redis.readthedocs.org/en/latest/

.. contents::
    :depth: 2
    :backlinks: none

Summary
-------
Compatibility with Python and Django
````````````````````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

============  ==========  ================  =================  ==============  ==============
Python        Django      More details      Web server works?  Channels work?  Does it work?
============  ==========  ================  =================  ==============  ==============
Python 2.7    Django 1.8  `py27-django18`_  ✓ Yes              ✓ Yes           **✓ Yes**
Python 2.7    Django 1.9  `py27-django19`_  ✓ Yes              ✓ Yes           **✓ Yes**
Python 3.3    Django 1.8  `py33-django18`_  ✗ No               ─ Not tested    **✗ No**
Python 3.3    Django 1.9  `py33-django19`_  ✓ Yes or ✗ No      ✓ Yes or ✗ No   **✓ Yes/✗ No**
Python 3.4    Django 1.8  `py34-django18`_  ✓ Yes or ✗ No      ✓ Yes or ✗ No   **✓ Yes/✗ No**
Python 3.4    Django 1.9  `py34-django19`_  ✓ Yes or ✗ No      ✓ Yes or ✗ No   **✓ Yes/✗ No**
Python 3.5    Django 1.9  `py35-django19`_  ✓ Yes or ✗ No      ✓ Yes or ✗ No   **✓ Yes/✗ No**
============  ==========  ================  =================  ==============  ==============

Easy to install?
````````````````
Yes, but dependant of Redis_.

Read more at `Installation`_.

Integration into a Django project
`````````````````````````````````
Easy, but need some investment to integrate django-websocket-redis_ to an existing Django project.

Read more at `Integration`_.

Thin or heavy architecture?
```````````````````````````
Thin, even if django-websocket-redis_ depends of Redis_, it's really easy to install it and Redis_ is lite as f***.

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
*For more information, you can take a look to the* `Configuration section <http://django-websocket-redis.readthedocs.org/en/latest/
installation.html#configuration>`_ *from the official documentation.*

Instead of configure my own Django project, I will use the official demo (`chatserver <https://github.com/jrief/django-
websocket-redis/tree/master/examples/chatserver>`_) during my tests with Tox to test django-websocket-redis_, because I'm lazy.

If you really want to configure for your project, here are some settings below:

1. Add *ws4redis* to your *INSTALLED_APPS* in your settings.py_ file:

.. code-block:: python

    INSTALLED_APPS = [
        # ...
        'ws4redis',
    ]

2. Always in your settings.py_ file, specify the URL that distinguishes websocket connections from normal requests:

.. code-block:: python

    WEBSOCKET_URL = '/ws/'

3. If your Redis_ settings are different than the defaults, use this dictionary in your settings.py_ to override these values:

.. code-block:: python

    WS4REDIS_CONNECTION = {
        'host': 'redis.example.com',
        'port': 16379,
        'db': 17,
        'password': 'verysecret',
    }

4. Then, you need to add *ws4redis* context_processors to your Django application:

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

5. During your development, you will need to change your *WSGI_APPLICATION* value from your settings.py file.
I assure you, it will not be used in production while you will use *uwsgi*, *gunicorn* or something else to run your Django
server:

.. code-block:: python

    WSGI_APPLICATION = 'ws4redis.django_runserver.application'

6. And then you need to add *WS4REDIS_HEARTBEAT* to your settings.py_ file to keep Websockets alive.
*See* `official documentation <http://django-websocket-redis.readthedocs.org/en/latest/heartbeats.html#sending-and-
receiving-heartbeat-messages>`_.

.. code-block:: python

    WS4REDIS_HEARTBEAT = '--my-heartbeat--'

Compatibility
-------------
Running web server
``````````````````
Due to ``WSGI_APPLICATION = 'ws4redis.django_runserver.application'`` in the chatserver.settings_ file, there will be
only one server to run. But of course, it will not works in production while you will use *uwsgi* or *gunicorn* for your
deployment.

*Read more at* http://django-websocket-redis.readthedocs.org/en/latest/running.html.

Before running the web server to test the chatserver application, you need to migrate and load fixtures (but Tox will
do that for you):

.. code-block:: bash

    $ workon dtws-django-websocket-redis
    $ python manage.py migrate
    $ python manage.py loaddata chatserver/fixtures/data.json
    $ python manage.py runserver --settings=chatserver.settings

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
Web server works?
'''''''''''''''''
    **✓ Passed!**

Output
......
.. code-block::

    py27-django18 runtests: commands[2] | python manage.py runserver --settings=chatserver.settings
    Performing system checks...

    System check identified no issues (0 silenced).
    [2016-04-21 10:26:48,021 utils] DEBUG: (0.002) QUERY = "\n            SELECT name, type FROM sqlite_master\n            WHERE type in ('table', 'view') AND NOT name='sqlite_sequence'\n            ORDER BY name" - PARAMS = (); args=None
    [2016-04-21 10:26:48,027 utils] DEBUG: (0.001) QUERY = u'SELECT "django_migrations"."app", "django_migrations"."name" FROM "django_migrations"' - PARAMS = (); args=()
    April 21, 2016 - 10:26:48
    Django version 1.8.12, using settings 'chatserver.settings'
    Starting development server at http://127.0.0.1:8000/
    Quit the server with CONTROL-C.
    [2016-04-21 10:26:48,155 django_runserver] INFO: Websocket support is enabled

Channels
''''''''
    **✓ Passed!**

*Note: Maybe write real unit tests?*

*Note: the group chatuser is composed of John and Mary.*

==========  =======  =========  ====================  ===============
Channel     From     To         Recipients             Good behavior?
==========  =======  =========  ====================  ===============
Broadcast   Admin    Everybody  Admin, John and Mary  **✓ Yes**
Broadcast   John     Everybody  Admin, John and Mary  **✓ Yes**
Broadcast   Mary     Everybody  Admin, John and Mary  **✓ Yes**
User chat   Admin    Admin      Admin                 **✓ Yes**
User chat   Admin    John       John                  **✓ Yes**
User chat   Admin    Mary       Mary                  **✓ Yes**
User chat   John     Admin      Admin                 **✓ Yes**
User chat   John     John       John                  **✓ Yes**
User chat   John     Mary       Mary                  **✓ Yes**
User chat   Mary     Admin      Admin                 **✓ Yes**
User chat   Mary     John       John                  **✓ Yes**
User chat   Mary     Mary       Mary                  **✓ Yes**
Group user  Admin    chatusers  chatusers             **✓ Yes**
Group user  John     chatusers  chatusers             **✓ Yes**
Group user  Mary     chatusers  chatusers             **✓ Yes**
==========  =======  =========  ====================  ===============

py27-django19
`````````````
Web server works?
'''''''''''''''''
    **✓ Passed!**

Note: we have some ``RemovedInDjango110Warning``:

- ``You haven't defined a TEMPLATES setting. You must do so before upgrading to Django 1.10. Otherwise Django will be unable to load templates.``
- ``django.conf.urls.patterns() is deprecated and will be removed in Django 1.10. Update your urlpatterns to be a list of django.conf.urls.url() instances instead.``

Output
......
.. code-block::

    py27-django19 runtests: commands[2] | python manage.py runserver --settings=chatserver.settings
    Performing system checks...

    /home/hugo/Dev/DjangoTestWebsockets/.tox/py27-django19/local/lib/python2.7/site-packages/django/template/utils.py:37: RemovedInDjango110Warning: You haven't defined a TEMPLATES setting. You must do so before upgrading to Django 1.10. Otherwise Django will be unable to load templates.
      "unable to load templates.", RemovedInDjango110Warning)

    /home/hugo/Dev/DjangoTestWebsockets/chatserver/urls.py:17: RemovedInDjango110Warning: django.conf.urls.patterns() is deprecated and will be removed in Django 1.10. Update your urlpatterns to be a list of django.conf.urls.url() instances instead.
      url(r'^$', RedirectView.as_view(url=reverse_lazy('broadcast_chat'))),

    System check identified no issues (0 silenced).
    [2016-04-21 11:22:15,836 utils] DEBUG: (0.001)
                SELECT name, type FROM sqlite_master
                WHERE type in ('table', 'view') AND NOT name='sqlite_sequence'
                ORDER BY name; args=None
    [2016-04-21 11:22:15,839 utils] DEBUG: (0.000) SELECT "django_migrations"."app", "django_migrations"."name" FROM "django_migrations"; args=()
    April 21, 2016 - 11:22:15
    Django version 1.9.5, using settings 'chatserver.settings'
    Starting development server at http://127.0.0.1:8000/
    Quit the server with CONTROL-C.
    [2016-04-21 11:22:15,860 django_runserver] INFO: Websocket support is enabled


Channels
''''''''
    **✓ Passed!**

*Note: Maybe write real unit tests?*

*Note: the group chatuser is composed of John and Mary.*

==========  =======  =========  ====================  ===============
Channel     From     To         Recipients             Good behavior?
==========  =======  =========  ====================  ===============
Broadcast   Admin    Everybody  Admin, John and Mary  **✓ Yes**
Broadcast   John     Everybody  Admin, John and Mary  **✓ Yes**
Broadcast   Mary     Everybody  Admin, John and Mary  **✓ Yes**
User chat   Admin    Admin      Admin                 **✓ Yes**
User chat   Admin    John       John                  **✓ Yes**
User chat   Admin    Mary       Mary                  **✓ Yes**
User chat   John     Admin      Admin                 **✓ Yes**
User chat   John     John       John                  **✓ Yes**
User chat   John     Mary       Mary                  **✓ Yes**
User chat   Mary     Admin      Admin                 **✓ Yes**
User chat   Mary     John       John                  **✓ Yes**
User chat   Mary     Mary       Mary                  **✓ Yes**
Group user  Admin    chatusers  chatusers             **✓ Yes**
Group user  John     chatusers  chatusers             **✓ Yes**
Group user  Mary     chatusers  chatusers             **✓ Yes**
==========  =======  =========  ====================  ===============

py33-django18
`````````````
Web server works?
'''''''''''''''''
    **✗ Failed.**

Django is not able to find ``pysqlite2`` nor ``sqlite3``. To resolve this problem, you should compile yourself Python 3.3
with support of SQLite3 (``libsqlite3-dev``).

Output
......
.. code-block::

    py33-django18 runtests: commands[0] | python manage.py migrate
    Traceback (most recent call last):
      File "/home/hugo/Dev/DjangoTestWebsockets/.tox/py33-django18/lib/python3.3/site-packages/django/db/backends/sqlite3/base.py", line 31, in <module>
        from pysqlite2 import dbapi2 as Database
    ImportError: No module named 'pysqlite2'

    During handling of the above exception, another exception occurred:

    Traceback (most recent call last):
      File "/home/hugo/Dev/DjangoTestWebsockets/.tox/py33-django18/lib/python3.3/site-packages/django/db/backends/sqlite3/base.py", line 33, in <module>
        from sqlite3 import dbapi2 as Database
      File "/usr/local/lib/python3.3/sqlite3/__init__.py", line 23, in <module>
        from sqlite3.dbapi2 import *
      File "/usr/local/lib/python3.3/sqlite3/dbapi2.py", line 26, in <module>
        from _sqlite3 import *
    ImportError: No module named '_sqlite3'

    [...]

      File "/home/hugo/Dev/DjangoTestWebsockets/.tox/py33-django18/lib/python3.3/site-packages/django/db/backends/sqlite3/base.py", line 36, in <module>
        raise ImproperlyConfigured("Error loading either pysqlite2 or sqlite3 modules (tried in that order): %s" % exc)
    django.core.exceptions.ImproperlyConfigured: Error loading either pysqlite2 or sqlite3 modules (tried in that order): No module named '_sqlite3'

Channels
''''''''
    **─ Not tested**

As long the web server do not works, I can not test channels.

py34-django18
`````````````
Web server works?
'''''''''''''''''
    **✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py34-django18 runtests: commands[1] | python manage.py runserver
    #...

py33-django19
`````````````
Web server works?
'''''''''''''''''
    **✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py33-django19 runtests: commands[1] | python manage.py runserver
    #...

py34-django19
`````````````
Web server works?
'''''''''''''''''
    **✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py34-django19 runtests: commands[1] | python manage.py runserver
    #...

py35-django19
`````````````
Web server works?
'''''''''''''''''
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
