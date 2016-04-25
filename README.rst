.. _Tornado: https://github.com/tornadoweb/tornado
.. _tornado_main.py: https://github.com/bdarnell/django-tornado-demo/blob/master/testsite/tornado_main.py

Tests for Tornado_
==================

- GitHub repo: https://github.com/tornadoweb/tornado
- ReadTheDoc: http://www.tornadoweb.org/en/stable

.. contents::
    :depth: 2
    :backlinks: none

Summary
-------
Compatibility with Python and Django
````````````````````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

============  ==========  ================  ===============  ===============  ================
Python        Django      More details      Thing #1 works?  Thing #2 works?  So, does it work?
============  ==========  ================  ===============  ===============  ================
Python 2.7    Django 1.8  `py27-django18`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 2.7    Django 1.9  `py27-django19`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.2    Django 1.8  `py32-django18`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.3    Django 1.8  `py33-django18`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.4    Django 1.8  `py34-django18`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.4    Django 1.9  `py34-django19`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.5    Django 1.8  `py35-django18`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.5    Django 1.9  `py35-django19`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
============  ==========  ================  ===============  ===============  ================

Easy to install?
````````````````
Easy.

Read more at `Installation`_.

Integration into a Django project
`````````````````````````````````
Easy, we just need to wrap Django `WSGIHandler` into a Tornado `WSGIContainer`, make a route for it and it works fine.

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
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Read more at `Documentation`_.

Has unit tests?
```````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Read more at `Unit tests`_.

----------------------------------------------------------------------------------------------------------------------

Installation
------------
You can read the `official documentation <http://www.tornadoweb.org/en/stable/index.html#installation>`_ too.

.. code-block:: bash

    $ mkvirtualenv --python=/usr/bin/pythonX.X dtws-tornado
    # You are now in your new virtual environment
    $ pip install tornado Django tox
    $ django-admin startproject DjangoTestWebsockets
    $ django-admin startapp myapp

Integration
-----------
To use *Django* with *Tornado*, you can download and modify the file tornado_main.py_ (thanks to Ben Darnell <3)
depending on your use.

The most important parts of this file are:

- We have two routes: ``/hello-tornado`` and ``.*``,
- We have two handlers: ``HelloHandler`` (for *Tornado*) and ``django.core.handlers.wsgi.WSGIHandler`` (for *Django*),
- Our two routes are respectively binded to our two handlers:

    - When a client make a request for ``^/hello-tornado$``, ``HelloHandler`` will pick up the burden,
    - Otherwise, as long as ``^.*$`` matches all requests, it's used as a fallback for all other requests that will be passed to *Django*.

To run the server, run:

.. code-block:: bash

    $ # Always in your virtual environment at your project root
    $ PYTHONPATH=. DJANGO_SETTINGS_MODULE=DjangoTestWebsockets.settings DjangoTestWebsockets/tornado_main.py

Compatibility
-------------

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

py27-django19
`````````````

py32-django18
`````````````

py33-django18
`````````````

py34-django18
`````````````

py33-django19
`````````````

py34-django19
`````````````

py35-django18
`````````````

py35-django19
`````````````

Architecture
------------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Event-driven programming
------------------------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Documentation
-------------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Unit tests
----------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.
