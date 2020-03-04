Dockerize is an Elixir package that helps you create [Docker] images from Elixir projects.

## Install

```sh
mix archive.install hex dockerize
```
## Getting Started

#### Generate configurations from template

Run this command in your project directory:

```sh
mix dockerize.init
```

#### Build your docker image

just run `docker build`, for example

```sh
docker build .
```

Then you are free to do anything with the built docker image, either run it locally or distribute it to your infrastructures, e.g a Kubernete cluster.

For more information of `docker build`, please refer to the [official document](https://docs.docker.com/engine/reference/builder/).

## Customizing

### For Phoenix Projects

Modify the generated `Dockerfile`. Follow the instructions in it.


### use different app name other the directory name

By default, it speculates guess app_name from the directory name. You can change it by:

```sh
mix dockerize.init --app my_app
```

### use MIX_ENV other than `prod`

By default, it build the image with `MIX_ENV=prod`. You can change `MIX_ENV` value by providing it as an build argument:

```sh
docker build --build-arg mix_env=dev .
```

### use HEX_MIRROR other than default (https://repo.hex.pm)

If you are in China, you may want to use some hex mirror:

```sh
docker build --build-arg hex_mirror_url=https://hexpm.upyun.com .
```

## Docker images underhood

There are two base docker used:

* [elixir-runner](https://hub.docker.com/r/qhwa/elixir-runner) provide a final environment for running your release. This image is based on [Alpine] which is a very minimum Linux distribution.
* [elixir-builder](https://hub.docker.com/r/qhwa/elixir-builder) is used for building the final minimum docker image to distribute.

[Docker]: https://www.docker.com
[Alpine]: https://alpinelinux.org
