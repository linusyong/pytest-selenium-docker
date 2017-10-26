# Introduction
This is using pytest, selenium and docker to achive some automated testing.  A lot of time, developer need to test their html pages, css, javascripts using Selenium.  To allow for that, these codes (html, css, javascripts) need to be hosted on some Web servers to allow Selenium drivers to test them.

To make the environment easier, this example using an Nginx Docker Container and run Pytest to drive the Selenium testing.

## Virtualenv
The Makefile first create a Python 3 Virtualenv and install tox.  Tox is used for easy management if in the future, more environment (e.g. dev, test, pre-prod, prod) is used.

## Setup
Setup creates a Nginx Docker Container with the html, css, javascript files mounted in Nginx html directory.

Docker runs the Nginx Container with `-P` option which allows the port to be allocated dynamically, avoiding port conflict.

A Selenium (standalone Chrome) Container is also created to allow Pytest to use the Selenium `Remote` webdriver.  This will make it easier to be enhanced for the multi browser, platform testing.

## Test
Once the Virtualenv is installed, Nginx Docker Container and Selenium Docker Container is running, test is performed by using tox which in turns call pytest.

## Teardown
Once the test completed, the Nginx and Selenium Docker Container is removed.

# Prerequisites
Tested using:
*  Docker engine 17.09.0-ce
*  Python 3.5.2
*  GNU Make 4.1
*  mawk 1.3.3
*  Virtualenv 15.1.0

# Testing
To run the test use the command:
```
$ make -k
```

# Future
This can be enhanced by integrating with Selenium Docker either as Selenium Hub or Standalone to provide for multi browser, platform testing.
