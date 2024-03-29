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
  @default_elixir_version "1.14.0-erlang-25.1-debian-buster-20220801"

  @config_files ~w[config/runtime.exs]
  @docker_files ~w[Dockerfile .dockerignore]

  def gen(opts) do
    opts = with_defaults(opts)

    do_gen(@config_files ++ @docker_files, opts)
  end

  defp with_defaults(opts),
    do: Keyword.merge(default_opts(opts), opts)

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

  defp guess_app_name(prefix),
    do: Path.expand(prefix) |> Path.basename() |> underscore()

  defp underscore(path),
    do: String.replace(path, "-", "_")

  defp default_output_path(prefix), do: Path.join(prefix, @default_output)

  defp has_phoenix?("") do
    Mix.Project.deps_paths()
    |> Map.has_key?(:phoenix)
  end

  defp has_phoenix?(prefix) do
    Mix.Project.in_project(String.to_atom(prefix), prefix, fn
      nil ->
        false

      module ->
        module.project()
        |> Keyword.get(:deps, [])
        |> Keyword.has_key?(:phoenix)
    end)
  end

  defp do_gen(templates, opts) do
    {gen_opts, values} = Keyword.split(opts, [:force, :base, :output])
    Enum.each(templates, &Template.generate_from_template(&1, values, gen_opts))
  end
end
