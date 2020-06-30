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

  defp with_defaults(opts), do: Keyword.merge(default_opts(opts), opts)

  defp default_opts(opts) do
    prefix = opts[:path] || ""

    [
      app: guess_app_name(prefix),
      output: default_output_path(prefix),
      elixir_version: @default_elixir_version,
      phoenix_assets: has_phoenix?(prefix),
      gen_command: nil
    ]
  end

  defp guess_app_name(prefix), do: Path.expand(prefix) |> Path.basename()

  defp default_output_path(prefix), do: Path.join(prefix, @default_output)

  defp has_phoenix?("") do
    Mix.Project.deps_paths()
    |> Map.has_key?(:phoenix)
  end

  defp has_phoenix?(prefix) do
    Mix.Project.in_project(nil, prefix, fn
      nil ->
        false

      module ->
        module.project()
        |> Keyword.get(:deps, [])
        |> Keyword.has_key?(:phoenix)
    end)
  end

  defp gen_config(opts),
    do: Template.generate_from_templates(@configs, opts)

  defp gen_docker_file(opts),
    do: Template.generate_from_templates(@dockerfiles, opts)
end
