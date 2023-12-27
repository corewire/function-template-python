# function-template-python
[![CI](https://github.com/crossplane/function-template-python/actions/workflows/ci.yml/badge.svg)](https://github.com/crossplane/function-template-go/actions/workflows/ci.yml)

A template for writing a [composition function][functions] in [Python][python].

To learn how to use this template:

* [Learn about how composition functions work][functions]

If you just want to jump in and get started:

1. Replace `function-template-python` with your function's name in
   `pyproject.toml` and `package/crossplane.yaml`.
1. Add your logic to `RunFunction` in `function/fn.py`
1. Add tests for your logic in `test/test_fn.py`
1. Update this file, `README.md`, to be about your function!

This template uses [Python][python], [Docker][docker], and the [Crossplane
CLI][cli] to build functions.

```shell
# Lint the code - see pyproject.toml
hatch run lint:check

# Run unit tests - see tests/test_fn.py
hatch run test:unit

# Build the function's runtime image - see Dockerfile
$ docker build . --tag=runtime

# Build a function package - see package/crossplane.yaml
$ crossplane xpkg build -f package --embed-runtime-image=runtime
```

[functions]: https://docs.crossplane.io/latest/concepts/composition-functions
[python]: https://python.org
[docker]: https://www.docker.com
[cli]: https://docs.crossplane.io/latest/cli


## Containerized Development

If you prefer to develop in a containerized environment, you can use the provided Dockerfile and docker-compose.yml files located in `development` to do so.
You can either use devcontainers, docker or compose to develop in a containerized environment that reloads itself on changes.

### VsCode: Devcontainers
- You can develop inside a [devcontainer](https://code.visualstudio.com/docs/devcontainers/containers#_create-a-devcontainerjson-file) using the definition in `.devcontainer.json`.

### Hot reload 
- In the  `development` folder you can find a docker-compose file that will mount the current folder into the container and reload the container on changes using its entrypoint. 
- The entrypoint watches the `function` and `test` directories and the pyproject.toml file for changes and reloads the container on changes.
- By default it will run: 
  - `hatch run lint:check`
  - `hatch run test:unit`
  - `hatch run function --insecure --debug`
- That enables you to quickly iterate on your function and test it locally using the crossplane cli.

#### Docker (Compose)
- In one terminal Build + run the dev container image:
   ``` 
   $ docker build -f development/Dockerfile -t crossplane-function-python-dev .
   $ docker run -p 9443:9443 -v .:/build --rm -it crossplane-function-python-dev
   ```
   
   or
   
   ``` 
   $ docker run -p 9443:9443 -v .:/build --rm -it $(docker build -f development/Dockerfile -q .)
   ```
   
   or
   
   ``` 
   $ cd development
   $ docker compose up --build
   ```

- In another terminal run the render command:
``` 
$ crossplane beta render xr.yaml composition.yaml functions.yaml 
```

