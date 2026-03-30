from setuptools import setup

setup(
    name='BGLshared',
    packages=['BGLshared'],
    version='0.0.8',
    description='BGL shared functions and configuration.',
    install_requires=['python-json-logger'],
    extras_require={
        'flask': ['flask', 'cloudevents'],
    }
)