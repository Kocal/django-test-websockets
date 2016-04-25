.. _gevent-socketio: https://github.com/{abourget}/{gevent-socketio}
.. _tox.ini: tox.ini

Tests for gevent-socketio_
==========================
.. contents::
    :depth: 2
    :backlinks: none

Summary
-------
Compatibility with Python and Django
````````````````````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

============  ==========  ================  ===============  ===============  =================
Python        Django      More details      Thing #1 works?  Thing #2 works?  So, does it work?
============  ==========  ================  ===============  ===============  =================
Python 2.7    Django 1.8  `py27-django18`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 2.7    Django 1.9  `py27-django19`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.2    Django 1.8  `py32-django18`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.3    Django 1.8  `py33-django18`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.4    Django 1.8  `py34-django18`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.4    Django 1.9  `py34-django19`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.5    Django 1.8  `py35-django18`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
Python 3.5    Django 1.9  `py35-django19`_   ✓ Yes or ✗ No   ✓ Yes or ✗ No    **✓ Yes/✗ No**
============  ==========  ================  ===============  ===============  =================

Easy to install?
````````````````
Not easy, no documentation about it and need to fix an error in *socketio package*.

Read more at `Installation`_.

Integration into a Django project
`````````````````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

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
No.

Read more at `Documentation`_.

Has unit tests?
```````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Read more at `Unit tests`_.

----------------------------------------------------------------------------------------------------------------------

Installation
------------

.. code-block:: bash

    $ mkvirtualenv --python=/usr/bin/python2.7 dtws-gevent-socketio
    # You are now in your new virtual environment
    $ pip install Django tox gevent-socketio==0.3.6

You should modify the file `<your_virtual_env>/local/lib/pythonX.X/site-packages/socketio/handler.py` at line ~77,
and change:

.. code-block:: python

    ("Access-Control-Max-Age", 3600),

by:

.. code-block:: python

    ("Access-Control-Max-Age", "3600"),

Otherwise, you will have an exception about this *3600*::

    File "/path/to/DjangoTestWebsockets/.tox/py27-django18/local/lib/python2.7/site-packages/gevent/pywsgi.py", line 778, in start_response
      raise UnicodeError("The value must be a native string", header, value)
    UnicodeError: ('The value must be a native string', 'Access-Control-Max-Age', 3600)
      <Greenlet at 0xb6797accL: _handle_and_close_when_done(<bound method SocketIOServer.handle of <SocketIOSe, <bound method SocketIOServer.do_close of <SocketIO, (<socket at 0xb5f4fb0cL fileno=[Errno 9] Bad file )> failed with UnicodeError


Then, you can start your new Django project and app:

.. code-block:: bash

    $ django-admin startproject DjangoTestWebsockets .
    $ django-admin startapp myapp

Integration
-----------

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

No, you need to read the API and check out example applications [#]_::

> Until we have a fully-fledged tutorial, please check out our example applications and the API documentation.

.. [#] https://gevent-socketio.readthedocs.org/en/latest/#getting-started

Unit tests
----------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.
