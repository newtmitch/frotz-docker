# Overview

This is a Dockerized frotz interpreter for Infocom and other Z-Machine games.

This is built directly from the [source repo](https://gitlab.com/DavidGriffith/frotz) maintained by David Griffith. This version of frotz is built without sound in order to compile and run properly in an Alpine Linux container.

You can also visit the [Docker Hub repo](https://hub.docker.com/r/newtmitch/frotz).

# Running

```
# create a container in interactive mode, mapping your local zfiles directory into the container. Change /home/frotz
# to anything that works for you to access the zfiles
docker run -ti -v $PWD/zfiles:/home/frotz newtmitch/frotz

# start a zfile
frotz telling.z5
```

# Building

To build just for your local platform, simply run:

```bash
docker build newtmitch/frotz:latest .
```

To build a multi-platform image (ARM64 and AMD64) and push to Docker Hub, you can do that in a single step:

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t newtmitch/frotz:latest \
  --push \
  .
```

Be sure to run `docker login` before you build with `--push`.

If you push to Docker Hub, also make sure to tag it with the latest build version per the Dockerfile:

```
docker tag newtmitch/frotz:latest newtmitch/frotz:2.55
```

# Change Log

## 2026-03-18
* updated README with new build instructions - removed explicit version number
* updated Dockerfile build number with latest from source repo

## 2020-11-26
* Moved to alpine linux from ubutnu
* Building directly from source and latest mainstream release tag (instead of sourceforge binary)
* staged build for smaller final image
* Added README so people can actually use this image

## 2016 (sometime)
* Initial release
