defmodule Dockerize.MixProject do
  use Mix.Project

  def project do
    [
      app: :dockerize,
      description: "A tool for creating docker image from an Elixir project.",
      license: "",
      version: "0.2.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :mix, :eex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, ">= 0.0.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:git_hooks, "~> 0.4", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: [
        "qhwa <qhwa@pnq.cc>"
      ],
      source_url: "https://github.com/qhwa/dockerize",
      links: %{
        home: "https://github.com/qhwa/dockerize"
      },
      files: ~w[
        lib mix.exs priv
      ]
    ]
  end
end
