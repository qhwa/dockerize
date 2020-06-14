Dockerize is an Elixir package that helps you create [Docker] images from [Elixir] projects.

## Prerequirements

* Elixir >= 1.9

## Install

```sh
mix archive.install hex dockerize
```
## Getting Started

#### 1. Generate configurations from template

Run this command in your project directory:

```sh
mix dockerize.init
```

#### 2. Build your docker image

just run `docker build`, for example

```sh
docker build .
```

Done!

Now you are free to do anything with the docker image built, either run it locally or host it on your infrastructures, e.g a Kubernete cluster.

For more information of `docker build`, please refer to the [official document](https://docs.docker.com/engine/reference/builder/).

Optionally, you can use [docker buildkit](https://docs.docker.com/develop/develop-images/build_enhancements/) for better performance:

```sh
DOCKER_BUILDKIT=1 docker build .
```

## Customizing

#### For Phoenix projects

By default, it guess if in a phoenix project from the `mix.exs` configuration. So you don't do anything specially.

#### Use different app name other than directory name

By default, it speculates app_name from the directory name. You can change it by:

```sh
mix dockerize.init --app my_app
```

#### use MIX_ENV other than `prod`

By default, it build the image with `MIX_ENV=prod`. You can change `MIX_ENV` value by providing it as an build argument:

```sh
docker build --build-arg mix_env=dev .
```

#### use HEX_MIRROR other than default (https://repo.hex.pm)

If you are in China, you may want to use some hex mirror:

```sh
docker build --build-arg hex_mirror_url=https://hexpm.upyun.com .
```

## Docker images underhood

There are two base docker images used:

* [elixir-runner](https://hub.docker.com/r/qhwa/elixir-runner)
  * A final runtime environment for running your release.
  * This image is based on [Alpine] which is very small.
  * There are [some useful utility tools](https://github.com/qhwa/docker-elixir-runner#features) installed out of the box.

* [elixir-builder](https://hub.docker.com/r/qhwa/elixir-builder)
  * A build-time environment
  * Used for building the final minimum docker image to distribute.
  * Suitable for CI/CD uses.

[Docker]: https://www.docker.com
[Elixir]: https://elixir-lang.org
[Alpine]: https://alpinelinux.org
