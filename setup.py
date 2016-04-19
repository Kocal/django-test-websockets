import os
from setuptools import setup

setup(
    name="django-kocal-test-websockets",
    version="0.0.1",
    author="Hugo ALLIAUME",
    author_email="kocal@live.fr",
    license="MIT",
    packages=['DjangoTestWebsockets', 'myapp'],
    classifiers=[
        "Topic :: Utilities",
    ],
    install_requires=['django-socketio']
)
