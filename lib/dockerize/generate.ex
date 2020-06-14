defmodule Dockerize.Generate do
  alias Dockerize.Template

  @moduledoc """
  Generate docker configurations from command line.

  Usage:

  ```sh
  mix dockerize.init
  ```
  """

  @default_output ""
  @default_elixir_version "latest"

  @configs ~w[config/releases.exs]
  @dockerfiles ~w[Dockerfile .dockerignore]

  def gen(opts) do
    opts = with_defaults(opts)

    gen_config(opts)
    gen_docker_file(opts)
  end

  defp with_defaults(opts) do
    opts
    |> Keyword.put_new(:app, guess_app_name())
    |> Keyword.put_new(:output, @default_output)
    |> Keyword.put_new(:elixir_version, @default_elixir_version)
    |> Keyword.put_new(:phoenix_assets, has_phoenix?())
  end

  defp guess_app_name, do: File.cwd!() |> Path.basename()

  defp has_phoenix? do
    Mix.Project.config()
    |> Kernel.||([])
    |> Keyword.get(:deps, [])
    |> Enum.any?(&(elem(&1, 0) == :phoenix))
  end

  defp gen_config(opts),
    do: Template.generate_from_templates(@configs, opts)

  defp gen_docker_file(opts),
    do: Template.generate_from_templates(@dockerfiles, opts)
end
