defmodule Mix.Tasks.Dockerize.Init do
  @moduledoc """
  Usage: `mix dockerize.init --app my_app`

  Initialize Docker related files. When running in an Elixir project,
  it will read the current project structure, and generate some files
  under the working directory.

  Supported arguments are:

  * `--path` - The path pointing to the project directory,
    e.g. `/home/projects/my_proj`.  Default to empty string which means
    the current working directory.
  * `--app` - The name of the OTP application.
    The app name of the target Elixir project. If not specified, it
    will guess the app name according to the current working directly.
    For example, if you run the command under
      `/home/my_user/project/my-app`
    by default the app name will be `my_app`
  * `--force`
    Indicating if existing files will be overwritten. Default to `false`.
    If not specified, a question will prompt if there's any conflict.
  * `--phoenix-assets` or `--no-phoenix-assets`
    Indicating if phoenix assets should be compiled and digested during
    the docker build process.
    If not specified, it will guess by reading the project dependency settings
    inside the `mix.exs` file and set it to `true` when there's a dependency 
    of `:phoenix`.
  * `--elixir-version` - The Elixir version to have in the Dockerfile.
    Default to `1.12` at this moment of writing this document.
  """

  @doc """
  Initialize the docker file setup.
  See also the module doc.
  """
  def run(opts) do
    parse_args(opts)
    |> Keyword.put(:gen_command, Enum.join(["mix dockerize.init" | opts], " "))
    |> Dockerize.Generate.gen()
  end

  defp parse_args(args) do
    OptionParser.parse(args,
      strict: [
        app: :string,
        force: :boolean,
        phoenix_assets: :boolean,
        elixir_version: :string,
        path: :string
      ]
    )
    |> case do
      {options, [], []} ->
        options

      {_, args, []} ->
        puts([
          "Unrecognized arguments: ",
          :red,
          Enum.map_join(args, " ", &inspect/1)
        ])

        print_usage()
        System.halt(1)

      {_, _, invalid} ->
        puts([
          "Unrecognized options: ",
          :red,
          inspect(invalid)
        ])

        print_usage()
        System.halt(1)
    end
  end

  defp puts(iodata) do
    [IO.ANSI.format(iodata) | [:reset, "\n"]] |> IO.puts()
  end

  defp print_usage, do: Mix.Tasks.Help.run(["dockerize.init"])
end
