## Build image

In this directory, run `build.sh` to build `cgrg/mkdocs:0.1.0` image.

## Run container

In the root directory of this repository, run the following command to start the container

```shell
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs cgrg/mkdocs
```

> :warning: If you use Windows, copy/clone this repository to WSL and run the command in WSL. Under the windows file system, the problem of mkdocs not reloading may be related to the `inotify events` mentioned [here](https://docs.docker.com/docker-for-windows/wsl/#best-practices) \
> :information_source: [WSL](https://docs.microsoft.com/en-us/windows/wsl/): Windows Subsystem for Linux Documentation