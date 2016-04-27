Django: Tests for websockets (DTWS)
===================================

During my internship, I had to work on an easy way to implement websockets on an existing Django project.

The task was not really easy because there is a lot of way to implement websockets with Django, but all those
solutions didn't meet the following critera:

- It should be easy to install,
- It should be easy to integrate into an already existing Django project,
- It should works with *Django 1.8* and *Django 1.9*,
- It should works with *Python 2.7*, *Python 3.2*, *Python 3.3*, *Python 3.4* and , *Python 3.5*,
- It should use a lite architecture (external dependencies, no NodeJS server aside Django for example, ...),
- It should be based on the event-driven programming concept,
- It should has a documentation,
- It should be tested.

As a lazy developper, I made this git repo where *a branch = a websockets solution*. All those branches are composed by:

#. A README file, used as review of a solution:

   - A summary/short review (`tl;dr`),
   - Is this solution easy to install?
   - Is this solution easy to integrate into a Django project?
   - Compatibility tests with Tox for supported version of Django and Python,
   - Is this solution using a lite architecture or not?
   - Is this solution based on event-driven programming concept?
   - Is this solution has a documentation?
   - Is this solution has unit tests?

#. A simple Django app (``django-admin startproject foo && django-admin startapp myapp``), configured to work with the current websocket solution

#. A ``tox.ini`` file to run compatibility tests with Tox + benchmarks for each testing environments

#. And maybe a ``.travis.yml`` file
