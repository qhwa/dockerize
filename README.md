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

# or optionally run with buildkit:
# DOCKER_BUILDKIT=1 docker build .
```

Done!

Now you are free to do anything with the docker image built, either run it locally or host it on your infrastructures, e.g a Kubernete cluster.

For more information of `docker build`, please refer to the [official document](https://docs.docker.com/engine/reference/builder/).

## Customizing

#### Phoenix projects without assets

By default, it speculates if it's running in a phoenix project or not, by information from `Mix.Project.config()`. So basically you have to do nothing specially. But if your phoenix project doesn't have assets, you could use the `--no-phoenix-assets` parameter on generating the `Dockerfile`.

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

[Docker]: https://www.docker.com
[Elixir]: https://elixir-lang.org
[Alpine]: https://alpinelinux.org
