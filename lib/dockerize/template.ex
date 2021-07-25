defmodule Dockerize.Template do
  @moduledoc false

  @type option :: {:base, Path.t()} | {:output, Path.t()} | {:force, boolean()}
  @type options :: [option]

  @spec generate_from_template(
          template :: Path.t(),
          values :: keyword(),
          options
        ) :: {:ok, Path.t()} | false
  def generate_from_template(template, values, opts) do
    template_file_path = input_path(template, opts)
    output_file_path = output_path(template, opts)

    prepair_dir(output_file_path)

    if maybe_confirm_overwrite(output_file_path, opts) do
      IO.puts(["generating ", output_file_path])

      output_content = EEx.eval_file(template_file_path, values)
      File.write!(output_file_path, output_content)
      {:ok, output_file_path}
    end
  end

  defp input_path("." <> file, opts),
    do: input_path("_." <> file, opts)

  defp input_path(file, opts),
    do: Path.join([input_base_path(opts), "template", file <> ".eex"])

  defp output_path(file, opts),
    do:
      Path.join(
        output_base_path(opts),
        file
      )

  defp input_base_path(opts) do
    opts
    |> Keyword.get(:base, Application.app_dir(:dockerize))
    |> Path.join("priv")
  end

  defp output_base_path(opts),
    do: Keyword.get(opts, :output, "")

  defp prepair_dir(file) do
    file
    |> Path.dirname()
    |> File.mkdir_p()
  end

  defp maybe_confirm_overwrite(output, opts) do
    cond do
      Keyword.get(opts, :force, false) ->
        true

      File.exists?(output) ->
        yes?("Overwrite #{output}?")

      true ->
        true
    end
  end

  defp yes?(question) do
    IO.gets([question, " (Y/n)"])
    |> String.trim()
    |> String.downcase()
    |> case do
      "" ->
        true

      "y" ->
        true

      _ ->
        false
    end
  end
end
