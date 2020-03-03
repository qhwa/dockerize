defmodule Mix.Tasks.Dockerize.Init do
  alias IO.ANSI
  require Logger

  @moduledoc """
  Initialize Dockerize configurations

  Usage: `mix dockerize.init --app my_app`

  Supported arguments:

  * `--app`
  * `--force`
  """

  def run(opts) do
    parse_args(opts) |> Dockerize.Generate.gen()
  end

  defp parse_args(args) do
    OptionParser.parse(args,
      strict: [
        app: :string,
        force: :boolean,
        elixir_version: :string
      ]
    )
    |> case do
      {options, [], []} ->
        options

      {_, args, []} ->
        IO.puts(["Unrecognized arguments: ", ANSI.red(), Enum.join(args, " "), ANSI.reset(), "\n"])
        print_usage()
        System.halt(1)

      {_, _, invalid} ->
        IO.puts(["Unrecognized options: ", ANSI.red(), inspect(invalid), ANSI.reset(), "\n"])
        print_usage()
        System.halt(1)
    end
  end

  defp print_usage, do: Mix.Tasks.Help.run(["dockerize.init"]) 
end
