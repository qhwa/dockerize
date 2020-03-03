Dockerize is an Elixir hex package that helps you create [Docker] images from an Elixir project.

## Install

```sh
mix archive.install hex dockerize
```
## Getting Started

#### Initialize configurations

Configurations can be generated by the `dockerize.init` task.

Run in your project directory:

```sh
mix dockerize.init
```

This command generates configurations for your project, including the `Dockerfile`.

#### Build your docker image

just run `docker build`, for example

```sh
docker build .
```

##### use MIX_ENV other than `prod`

By default, it build the image with `MIX_ENV=prod`. You can change `MIX_ENV` value by providing it as an build argument:

```sh
docker build --build-arg mix_env=dev .
```

#### use HEX_MIRROR other than default (https://repo.hex.pm)

If you are in China, you may want to use some hex mirror:

```sh
docker build --build-arg hex_mirror_url=https://hexpm.upyun.com .
```

For more information of `docker build`, please refer to the [official document](https://docs.docker.com/engine/reference/builder/).


[Docker]: https://www.docker.com
