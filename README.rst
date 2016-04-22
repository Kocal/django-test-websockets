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
============  ==========  ================  =================  ==============  ==============
Python        Django      More details      Web server works?  Channels work?  Does it work?
============  ==========  ================  =================  ==============  ==============
Python 2.7    Django 1.8  `py27-django18`_  ✓ Yes              ✓ Yes           **✓ Yes**
Python 2.7    Django 1.9  `py27-django19`_  ✓ Yes              ✓ Yes           **✓ Yes**
Python 3.2    Django 1.8  `py32-django18`_  ─ Maybe yes        ─ Not tested    **─ It can**
Python 3.3    Django 1.8  `py33-django18`_  ✓ Yes              ✓ Yes           **✓ Yes**
Python 3.4    Django 1.8  `py34-django18`_  ✓ Yes              ✓ Yes           **✓ Yes**
Python 3.4    Django 1.9  `py34-django19`_  ✓ Yes              ✓ Yes           **✓ Yes**
Python 3.5    Django 1.8  `py35-django18`_  ✓ Yes              ✓ Yes           **✓ Yes**
Python 3.5    Django 1.9  `py35-django19`_  ✓ Yes              ✓ Yes           **✓ Yes**
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
Thin, even if django-websocket-redis_ depends of Redis_.

Read more at `Architecture`_.

Event-driven programming?
`````````````````````````
No, but it can make it like event-driven I guess.

Read more at `Event-driven programming`_.

Has a documentation?
````````````````````
Yes.

Read more at `Documentation`_.

Has unit tests?
```````````````
Yes.

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
*For more information, you can take a look to the* `Configuration section <http://django-websocket-redis.readthedocs.
org/en/latest/installation.html#configuration>`_ *from the official documentation.*

Instead of configure my own Django project, I will use the official demo (`chatserver <https://github.com/jrief/django-
websocket-redis/tree/master/examples/chatserver>`_) during my tests with Tox to test django-websocket-redis_, because
I'm lazy.

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

py32-django18
`````````````
    **✗ Failed.**

Failed because ``pip`` for *Python 3.2* is broken.

.. code-block::

    New python executable in /home/hugo/Dev/DjangoTestWebsockets/.tox/py32-django18/bin/python3.2
    Also creating executable in /home/hugo/Dev/DjangoTestWebsockets/.tox/py32-django18/bin/python
    Installing setuptools, pip, wheel...
      Complete output from command /home/hugo/Dev/Djang...ango18/bin/python3.2 - setuptools pip wheel:
      /home/hugo/.virtualenvs/dtws-django-webksocket-redis/lib/python3.3/site-packages/virtualenv_support/pip-8.1.1-py2.py3-none-any.whl/pip/_vendor/pkg_resources/__init__.py:87: UserWarning: Support for Python 3.0-3.2 has been dropped. Future versions will fail here.
    Traceback (most recent call last):
      File "<stdin>", line 7, in <module>
      File "/home/hugo/.virtualenvs/dtws-django-webksocket-redis/lib/python3.3/site-packages/virtualenv_support/pip-8.1.1-py2.py3-none-any.whl/pip/__init__.py", line 16, in <module>
      File "/home/hugo/.virtualenvs/dtws-django-webksocket-redis/lib/python3.3/site-packages/virtualenv_support/pip-8.1.1-py2.py3-none-any.whl/pip/vcs/mercurial.py", line 9, in <module>
      File "/home/hugo/.virtualenvs/dtws-django-webksocket-redis/lib/python3.3/site-packages/virtualenv_support/pip-8.1.1-py2.py3-none-any.whl/pip/download.py", line 36, in <module>
      File "/home/hugo/.virtualenvs/dtws-django-webksocket-redis/lib/python3.3/site-packages/virtualenv_support/pip-8.1.1-py2.py3-none-any.whl/pip/utils/ui.py", line 15, in <module>
      File "/home/hugo/.virtualenvs/dtws-django-webksocket-redis/lib/python3.3/site-packages/virtualenv_support/pip-8.1.1-py2.py3-none-any.whl/pip/_vendor/progress/bar.py", line 48
        empty_fill = u'∙'
                          ^
    SyntaxError: invalid syntax

py33-django18
`````````````
Web server works?
'''''''''''''''''
    **✓ Passed!**

Output
......
.. code-block::

    py33-django18 runtests: commands[2] | python manage.py runserver --settings=chatserver.settings
    Performing system checks...

    System check identified no issues (0 silenced).
    [2016-04-21 15:18:45,594 utils] DEBUG: (0.008) QUERY = "\n            SELECT name, type FROM sqlite_master\n            WHERE type in ('table', 'view') AND NOT name='sqlite_sequence'\n            ORDER BY name" - PARAMS = (); args=None
    [2016-04-21 15:18:45,610 utils] DEBUG: (0.011) QUERY = 'SELECT "django_migrations"."app", "django_migrations"."name" FROM "django_migrations"' - PARAMS = (); args=()
    April 21, 2016 - 15:18:45
    Django version 1.8.12, using settings 'chatserver.settings'
    Starting development server at http://127.0.0.1:8000/
    Quit the server with CONTROL-C.
    [2016-04-21 15:18:45,724 django_runserver] INFO: Websocket support is enabled

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

py34-django18
`````````````
Web server works?
'''''''''''''''''
    **✓ Passed!**

Output
......
.. code-block::

    py34-django18 runtests: commands[2] | python manage.py runserver --settings=chatserver.settings
    Performing system checks...

    System check identified no issues (0 silenced).
    [2016-04-21 14:37:46,295 utils] DEBUG: (0.001) QUERY = "\n            SELECT name, type FROM sqlite_master\n            WHERE type in ('table', 'view') AND NOT name='sqlite_sequence'\n            ORDER BY name" - PARAMS = (); args=None
    [2016-04-21 14:37:46,299 utils] DEBUG: (0.000) QUERY = 'SELECT "django_migrations"."app", "django_migrations"."name" FROM "django_migrations"' - PARAMS = (); args=()
    April 21, 2016 - 14:37:46
    Django version 1.8.12, using settings 'chatserver.settings'
    Starting development server at http://127.0.0.1:8000/
    Quit the server with CONTROL-C.
    [2016-04-21 14:37:46,377 django_runserver] INFO: Websocket support is enabled

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

py34-django19
`````````````
Web server works?
'''''''''''''''''
    **✓ Passed!**

Note: Again, we have some ``RemovedInDjango110Warning`` because of *Django 1.9*:

- ``You haven't defined a TEMPLATES setting. You must do so before upgrading to Django 1.10. Otherwise Django will be unable to load templates.``
- ``django.conf.urls.patterns() is deprecated and will be removed in Django 1.10. Update your urlpatterns to be a list of django.conf.urls.url() instances instead.``

Output
......
.. code-block::

    py34-django19 runtests: commands[2] | python manage.py runserver --settings=chatserver.settings
    Performing system checks...

    /home/hugo/Dev/DjangoTestWebsockets/.tox/py34-django19/lib/python3.4/site-packages/django/template/utils.py:37: RemovedInDjango110Warning: You haven't defined a TEMPLATES setting. You must do so before upgrading to Django 1.10. Otherwise Django will be unable to load templates.
      "unable to load templates.", RemovedInDjango110Warning)

    /home/hugo/Dev/DjangoTestWebsockets/chatserver/urls.py:17: RemovedInDjango110Warning: django.conf.urls.patterns() is deprecated and will be removed in Django 1.10. Update your urlpatterns to be a list of django.conf.urls.url() instances instead.
      url(r'^$', RedirectView.as_view(url=reverse_lazy('broadcast_chat'))),

    System check identified no issues (0 silenced).
    [2016-04-21 14:48:25,705 utils] DEBUG: (0.001)
                SELECT name, type FROM sqlite_master
                WHERE type in ('table', 'view') AND NOT name='sqlite_sequence'
                ORDER BY name; args=None
    [2016-04-21 14:48:25,709 utils] DEBUG: (0.000) SELECT "django_migrations"."app", "django_migrations"."name" FROM "django_migrations"; args=()
    April 21, 2016 - 14:48:25
    Django version 1.9.5, using settings 'chatserver.settings'
    Starting development server at http://127.0.0.1:8000/

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

py35-django18
`````````````
Web server works?
'''''''''''''''''
    **✓ Passed!**

Output
......
.. code-block::

    py35-django18 runtests: commands[2] | python manage.py runserver --settings=chatserver.settings
    Performing system checks...

    System check identified no issues (0 silenced).
    [2016-04-21 15:32:32,003 utils] DEBUG: (0.001) QUERY = "\n            SELECT name, type FROM sqlite_master\n            WHERE type in ('table', 'view') AND NOT name='sqlite_sequence'\n            ORDER BY name" - PARAMS = (); args=None
    [2016-04-21 15:32:32,008 utils] DEBUG: (0.000) QUERY = 'SELECT "django_migrations"."app", "django_migrations"."name" FROM "django_migrations"' - PARAMS = (); args=()
    April 21, 2016 - 15:32:32
    Django version 1.8.12, using settings 'chatserver.settings'
    Starting development server at http://127.0.0.1:8000/
    Quit the server with CONTROL-C.
    [2016-04-21 15:32:32,764 django_runserver] INFO: Websocket support is enabled

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

py35-django19
`````````````
Web server works?
'''''''''''''''''
    **✓ Passed!**

Note: Again, we have some ``RemovedInDjango110Warning`` because of *Django 1.9*:

- ``You haven't defined a TEMPLATES setting. You must do so before upgrading to Django 1.10. Otherwise Django will be unable to load templates.``
- ``django.conf.urls.patterns() is deprecated and will be removed in Django 1.10. Update your urlpatterns to be a list of django.conf.urls.url() instances instead.``

Output
......
.. code-block::

    py35-django19 runtests: commands[2] | python manage.py runserver --settings=chatserver.settings
    Performing system checks...

    /home/hugo/Dev/DjangoTestWebsockets/.tox/py35-django19/lib/python3.5/site-packages/django/template/utils.py:37: RemovedInDjango110Warning: You haven't defined a TEMPLATES setting. You must do so before upgrading to Django 1.10. Otherwise Django will be unable to load templates.
      "unable to load templates.", RemovedInDjango110Warning)

    /home/hugo/Dev/DjangoTestWebsockets/chatserver/urls.py:17: RemovedInDjango110Warning: django.conf.urls.patterns() is deprecated and will be removed in Django 1.10. Update your urlpatterns to be a list of django.conf.urls.url() instances instead.
      url(r'^$', RedirectView.as_view(url=reverse_lazy('broadcast_chat'))),

    System check identified no issues (0 silenced).
    [2016-04-21 15:35:47,474 utils] DEBUG: (0.001)
                SELECT name, type FROM sqlite_master
                WHERE type in ('table', 'view') AND NOT name='sqlite_sequence'
                ORDER BY name; args=None
    [2016-04-21 15:35:47,479 utils] DEBUG: (0.000) SELECT "django_migrations"."app", "django_migrations"."name" FROM "django_migrations"; args=()
    April 21, 2016 - 15:35:47
    Django version 1.9.5, using settings 'chatserver.settings'
    Starting development server at http://127.0.0.1:8000/
    Quit the server with CONTROL-C.
    [2016-04-21 15:35:47,706 django_runserver] INFO: Websocket support is enabled

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

Architecture
------------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Event-driven programming
------------------------
django-websocket-redis_ does not provide an event-driven programming like SocketIO, because it's using Redis_.

Client side
```````````
For example, take a look to the `user_chat.html <chatserver/templates/user_chat.html>`_ file from the official demo:

.. code-block:: javascript

    var ws4redis = WS4Redis({
        uri: '{{ WEBSOCKET_URI }}foobar?subscribe-user',
        receive_message: receiveMessage,
        heartbeat_msg: {{ WS4REDIS_HEARTBEAT }}
    });

    function sendMessage() {
        $.post('{% url "user_chat" %}', {
            user: 'john',
            message: 'My message'
        });
    }

    function receiveMessage(msg) {
        console.log('Got a message:', msg);
    }

    // ...

For me it's really a barbarian way to use a two different communication ways with the server. At least, it was
probably a better idea to make an abstraction of those communication ways like this:

.. code-block:: javascript

    var ws4redis = WS4Redis({
        uri: '{{ WEBSOCKET_URI }}foobar?subscribe-user',
        heartbeat_msg: {{ WS4REDIS_HEARTBEAT }}
    });

    function sendMessage() {
        ws4redis.emit('chat', {
            user: 'john',
            message: 'Hi Paul'
        });
    }

    ws4redis.on('message', function(data) {
        // data.user == 'paul'
        // data.message == 'Hey John'
    });

For an obscure reason, I had to rewrite the `WS4Redis javascript library <https://github.com/jrief/django-websocket-
redis/blob/master/ws4redis/static/js/ws4redis.js>`_ for a `cleaner and functional version <https://github.com/Kocal/
django-test-websockets/blob/5ac7a150dad75330d33e496c9e6d239ef143f111/myapp/static/myapp/js/ws4redis.js>`_,
so implement an abstraction to have a beautiful thing should not be too hard I guess.

Server side
```````````
Always with our example of chat, the server side implementation is in the `views.py <chatserver/views.py>`_ file, and
it looks like this:

.. code-block:: python

    class UserChatView(TemplateView):

        # ...

        #1: This method is called when sendMessage() function from client side is called
        def post(self, request, *args, **kwargs):
            #2: Create a RedisPublisher for the bucket "foobar", and only for the user passed in POST datas
            redis_publisher = RedisPublisher(facility='foobar', users=[request.POST.get('user')])
            #3: We make a RedisMessage (wrapping class), which contains the message passed in POST datas
            message = RedisMessage(request.POST.get('message'))
            #4: It publish the message to the bucket "foobar" and to the user
            redis_publisher.publish_message(message)
            #5: Everything is fine ;-)
            return HttpResponse('OK')

Same problem than `Client side`_, here we do not write events to read and write from and to the web socket.
We read data from the ``POST request``, and send data with a ``RedisPublisher``.

A better way is to make again an abstraction to hide those parts and to looks like SocketIO.
I don't know if the following code works, but it's an approximate idea of what I want to do:

.. code-block:: python

    # General websocket class which extends from Thread
    class WebSocket(Thread, request):

        def __init__(self):
            # ...
            self.broadcast = #...
            self.events = {}

        def on(self, event, cb):
            self.events[event] = cb

        # ...

    # Specific websocket class for a chat
    class WebSocketForChat(WebSocket, request):

        def __init__(self):
            # ...

            # Python anonymous function and multi-lines ;-)
            self.on('connect', self.on_connect)
            self.on('close', self.on_close)
            self.on('chat', self.on_chat)

        def on_connect(self):
            print('Got a new connection')

        def on_close(self):
            print('Closed connection')

        def on_chat(self, data):
            self.broadcast.emit('message', {
                user: data.user,
                message: data.message
            })

    class UserChatView(TemplateView):

        # Always called with Ajax...
        def post(self, request, *args, **kwargs):
                WebSocketForChat(request).run()



Documentation
-------------
Yes, a documentation is available for django-websocket-redis_ at `this address <http://django-websocket-redis.readthedocs.org/en/latest/index.html>`_.

Unit tests
----------
Yes, there are unit tests but also stress tests for `a simple chat server <http://django-websocket-redis.readthedocs.org/en/latest/testing.html
#a-simple-chat-server>`_.
