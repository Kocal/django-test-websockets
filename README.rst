
.. _Django-socketio: https://github.com/stephenmcd/django-socketio
.. _tox.ini: tox.ini


Tests for django-socketio_
==========================

.. contents::
    :depth: 2


tl;dr
-----

django-socketio_ only works with `Python 2.7` and `Django 1.8`. :^)

==============  ==============  ================  ================  =========  =========
Python version  Django version  More details      Coverage          Runserver  Works?
==============  ==============  ================  ================  =========  =========
Python 2.7      Django 1.8      `py27-django18`_  Yes!              Yes!       Yes!
Python 2.7      Django 1.9      `py27-django19`_  Yes!              Nope.      Partially
Python 3.3      Django 1.8      `py33-django18`_  Nope.             Nope.      Nope.
Python 3.3      Django 1.9      `py33-django19`_  Nope.             Nope.      Nope.
Python 3.4      Django 1.8      `py34-django18`_  Nope.             Nope.      Nope.
Python 3.4      Django 1.9      `py34-django19`_  Nope.             Nope.      Nope.
Python 3.5      Django 1.9      `py35-django19`_  Nope.             Nope.      Nope.
==============  ==============  ================  ================  =========  =========


----------------------------------------------------------------------------------------------------------------------


Before running tests
--------------------

As said before, django-socketio_ only works with version 2.7 of Python.
Make sure to run those commands before running tests:

.. code-block:: bash

    $ mkvirtualenv --python=/usr/bin/python2.7 dtws-django-socketio
    # You are now in your new virtual environment
    $ pip install django-socketio tox


If you want to skip one of Tox tests, you should comment one command from `commands`  property of tox.ini_ file:

.. code-block:: ini

    [testenv]
    commands =
        coverage run --source=DjangoTestWebsockets,django-socketio,myapp manage.py test
    ;    python manage.py runserver


----------------------------------------------------------------------------------------------------------------------


Tests
-----

To list available tests, you can run ``tox -l``.

To run a specific test, run for example ``tox -e py27-django19``.

py27-django18
`````````````

Coverage test
'''''''''''''

Passed.

Output
......

.. code-block::

    py27-django18 runtests: commands[0] | coverage run --source=DjangoTestWebsockets,myapp manage.py test
    Creating test database for alias 'default'...

    ----------------------------------------------------------------------
    Ran 0 tests in 0.000s

    OK
    Destroying test database for alias 'default'...


Runserver test
''''''''''''''

Passed.

Output
......

.. code-block::

    py27-django18 runtests: commands[1] | python manage.py runserver
    Performing system checks...

    System check identified no issues (0 silenced).
    April 19, 2016 - 14:06:58
    Django version 1.8.12, using settings 'DjangoTestWebsockets.settings'
    Starting development server at http://127.0.0.1:8000/
    Quit the server with CONTROL-C.


py33-django18
`````````````

Failed.

For as long as ``Python 2.7`` and ``Python 3.x`` are incompatible, django-socketio_ will not be able to works with
``Python 3.x``.
Thus, a ``SyntaxError`` exception is raised and its cancel Tox tests.

Output
''''''

.. code-block::

    Collecting django-socketio
      Using cached django-socketio-0.3.9.tar.gz
        Complete output from command python setup.py egg_info:
        Traceback (most recent call last):
          File "<string>", line 1, in <module>
          File "/tmp/pip-build-i2wuah/django-socketio/setup.py", line 7, in <module>
            version = __import__("django_socketio").__version__,
          File "/tmp/pip-build-i2wuah/django-socketio/django_socketio/__init__.py", line 2, in <module>
            from django_socketio.utils import NoSocket, send, broadcast, broadcast_channel
          File "/tmp/pip-build-i2wuah/django-socketio/django_socketio/utils.py", line 44
            except IndexError, KeyError:
                             ^
        SyntaxError: invalid syntax

py34-django18
`````````````
See py33-django18_.

py27-django19
`````````````

Coverage test
'''''''''''''

Passed.
Only works because tests are empty, but it will fails when tests will be wrote.

Output
......

.. code-block::

    py27-django19 runtests: commands[0] | coverage run --source=DjangoTestWebsockets,myapp manage.py test
    Creating test database for alias 'default'...

    ----------------------------------------------------------------------
    Ran 0 tests in 0.000s

    OK
    Destroying test database for alias 'default'...



Runserver test
''''''''''''''

Failed, because ``django.utils.importlib`` was marked as deprecated in ``Django 1.7b1`` [#]_, then it was removed in
``Django 1.9`` [#]_.

.. [#] https://github.com/django/django/commit/210d0489c5daad56b806f8165f9fe09fb3c2a019#diff-9046c2a231d3133a3dd89934a3b8b17eL7
.. [#] https://docs.djangoproject.com/en/1.8/internals/deprecation/#deprecation-removed-in-1-9

Output
......

.. code-block::

    py27-django19 runtests: commands[1] | python manage.py runserver
    Performing system checks...

    Unhandled exception in thread started by <function wrapper at 0xb675c25c>
    Traceback (most recent call last):
      [...]
      File "/home/hugo/Dev/DjangoTestWebsockets/DjangoTestWebsockets/urls.py", line 20, in <module>
        url('', include('django_socketio.urls')),
      File "/home/hugo/Dev/DjangoTestWebsockets/.tox/py27-django19/local/lib/python2.7/site-packages/django/conf/urls/__init__.py", line 52, in include
        urlconf_module = import_module(urlconf_module)
      File "/usr/lib/python2.7/importlib/__init__.py", line 37, in import_module
        __import__(name)
      File "/home/hugo/Dev/DjangoTestWebsockets/.tox/py27-django19/local/lib/python2.7/site-packages/django_socketio/urls.py", line 4, in <module>
        from django.utils.importlib import import_module
    ImportError: No module named importlib



py33-django19
`````````````

See py33-django18_.

py34-django19
`````````````

See py33-django18_.


py35-django19
`````````````

See py33-django18_.
