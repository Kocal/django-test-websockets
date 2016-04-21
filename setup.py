import os
from setuptools import setup

setup(
    name="django-kocal-test-websockets",
    version="0.0.1",
    author="Hugo ALLIAUME",
    author_email="kocal@live.fr",
    license="MIT",
    packages=['DjangoTestWebsockets', 'chatserver'],
    classifiers=[
        "Topic :: Utilities",
    ],
    install_requires=['django-websocket-redis']
)
