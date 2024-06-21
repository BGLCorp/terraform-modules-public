# BGL Shared Python Function Guide

## How to install
to install the package include the following line in your requirements file or run `pip install` on it-
`BGLshared @ git+https://git@github.com:BGLCorp/terraform-modules-public.git@master#subdirectory=python`

## Included packages and how to import them
### Logging
The logging package formats python logs in JSON and structures them in a standard format that can easily be parsed and searched on kibana.

To use this package you can include the following 2 lines in your main module:
```
from BGLshared.logging import logger, logHandler
logger.addHandler(logHandler)
```

If you want to redirect logs from other modules you can import just the handler and use it as the handler for those modules.
Alternatively if you've already set the logger with the handler in your main module you can import just the logger and use it without configuring an additional handler.

### Web server (Flask)
The flaskapp package contains functions that will generate and return a Flask server that can then be run with gunicorn or directly.
The server will have 2 endpoints for use in kubernetes health checks-
* /health/liveness
* /health/readiness

The currently available functions are:
* `create_health()` - basic function which only contains the 2 health check endpoints
* `create_post(func)` - can handle POST of cloudevents on the / path. This function will call the `func` module passed to it and would expect a `main()` function in that module, returning the result of the called function (should be a cloudevent & responsecode pair)

To import from this module you can include the following (or parts of it):
```
from BGLshared.flaskapp import create_health, create_post
```

## Private repo
If this package needs to be moved to a private repository, docker build processes will need to be updated as the builder does not by default have access to the SSH key.

To grant access to the host SSH key (without passing it in a layer) the --ssh flag can be used with docker buildx.
The following file should also be created as `config` to be copied into the docker container:
```
Host github.com
  StrictHostKeyChecking no
  IdentityFile /home/epalchan/.ssh/id_ed25519
```

And in the Dockerfile the following lines should be added:
```
RUN apk add --no-cache git openssh-client openssh-keyscan
RUN mkdir -p -m 0600 /root/.ssh
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
COPY config /root/.ssh
RUN --mount=type=ssh pip install -r requirements.txt
RUN apk del git openssh-client openssh-keyscan && rm -rf /root.ssh
```