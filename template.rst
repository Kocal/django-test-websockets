.. _SOLUTION: https://github.com/{user}/{repo}
.. _tox.ini: tox.ini
.. _settings.py: DjangoTestWebsockets/settings.py
.. _urls.py: DjangoTestWebsockets/urls.py
.. _index.html: myapp/templates/myapp/index.html

Tests for SOLUTION_
===================
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
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

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
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Read more at `Documentation`_.

Has unit tests?
```````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Read more at `Unit tests`_.

----------------------------------------------------------------------------------------------------------------------

Installation
------------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

.. code-block:: bash

    $ mkvirtualenv --python=/usr/bin/pythonX.X dtws-SOLUTION
    # You are now in your new virtual environment
    $ pip install SOLUTION==0.3.9 tox


Integration
-----------
Add `SOLUTION_snake_case` to your `INSTALLED_APPS` in your settings.py_ file:

.. code-block:: python

    INSTALLED_APPS = [
        # ...
        'SOLUTION_snake_case',
    ]

Add `SOLUTION_snake_case.urls` to your urls.py_ file:

.. code-block:: python

    urlpatterns = [
        url('', include('SOLUTION_snake_case.urls')),
        # ...
    ]

Integration into a template:

.. code-block:: html+django

   {# Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus. #}

Compatibility
-------------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Running websockets server
`````````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

.. code-block:: bash

    $ workon dtws-SOLUTION
    $ COMMAND TO RUN

Running Django server
`````````````````````
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

.. code-block:: bash

    $ workon dtws-SOLUTION
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
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py27-django18 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py27-django18 runtests: commands[1] | python manage.py runserver
    #...

py27-django19
`````````````
Websockets server works?
''''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py27-django19 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py27-django19 runtests: commands[1] | python manage.py runserver
    #...

py33-django18
`````````````
Websockets server works?
''''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py33-django18 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py33-django18 runtests: commands[1] | python manage.py runserver
    #...

py34-django18
`````````````
Websockets server works?
''''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py34-django18 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py34-django18 runtests: commands[1] | python manage.py runserver
    #...

py33-django19
`````````````
Websockets server works?
''''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

Output
......
.. code-block::

    py33-django19 runtests: commands[0] | COMMAND TO RUN
    # ...

Django webserver works?
'''''''''''''''''''''''
**✓ Passed!** or **✗ Failed.**

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
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.

Unit tests
----------
Numquam honeste facimus causa facimus ab non honestissime se insectarique sit detrahunt nostra causa quibus.
