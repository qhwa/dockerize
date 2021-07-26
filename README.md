Dockerize is an Elixir package that helps you create [Docker] images from [Elixir] projects.

## Motivation

This package is a workout of my blog post: [Build Docker Images From An Elixir Project, Why and How](https://qhwa-85848.medium.com/build-docker-images-from-an-elixir-project-why-and-how-78e19468210). Of course one can write his/her own `Dockerfile` and play with mix release and other stuff. However, although it is fun to me, not everyone likes this job or wants to do the same setup over and over again. So I created this project and try to make a template of my Docker-related files. I hope this package will be helpful to you too.

- **fast** - Most of the tutorials about writing a Dockerfile for an Elixir project on the internet come out with a pretty simple configuration. They work but can be faster. This project leverages the docker layer caching to save building time by carefully dividing the whole process into small stages which can be run parallel:

    ![run parallel](https://user-images.githubusercontent.com/43009/126917677-21f42cf4-9a54-41f5-8003-feacb9dc999e.jpeg)

- **best practices** - Some practices such as hex organization authentication, hex mirror setting, and docker ignoring, are included. So if you're not an expert on Docker, you still can set up a Docker mechanism quickly.
- **flexible** - The generated files, including `Dockerfile`, have guidance in comments so that you can alter them to fit your needs. Hopefully, you just need to uncomment them.

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

#### 2. Build your Docker image

just run `docker build`, for example

```sh
DOCKER_BUILDKIT=1 docker build .
```

Done!

Now you are free to do anything with the docker image built, either run it locally or host it on your infrastructures, e.g a Kubernetes cluster.

For more information on `docker build`, please refer to the [official document](https://docs.docker.com/engine/reference/builder/).

## Customizing

[Full command arguments](https://hexdocs.pm/dockerize/Mix.Tasks.Dockerize.Init.html)

#### Phoenix projects without assets

By default, it speculates if it's running in a phoenix project or not, by information from `Mix.Project.config()`. So basically you have to do nothing special. But if your phoenix project doesn't have assets, you could use the `--no-phoenix-assets` parameter on generating the `Dockerfile`.

#### Use different app name other than directory name

By default, it speculates app_name from the directory name. You can change it by:

```sh
mix dockerize.init --app my_app
```

#### use MIX_ENV other than `prod`

By default, it builds the image with `MIX_ENV=prod`. You can change `MIX_ENV` value by providing it as a build argument:

```sh
docker build --build-arg mix_env=dev .
```

#### use HEX_MIRROR other than the default (https://repo.hex.pm)

In some cases, you may want to use some hex mirror, with the following command:

```sh
docker build --build-arg hex_mirror_url=https://hexpm.upyun.com .
```

## License

MIT

[Docker]: https://www.docker.com
[Elixir]: https://elixir-lang.org
[Alpine]: https://alpinelinux.org


