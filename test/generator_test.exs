defmodule DockerizeTest.GeneratorTest do
  use ExUnit.Case

  describe "for a simple Mix project" do
    test "genereating with --app" do
      {:ok, [dockerfile | _]} = generate("simple_app", ["--app", "my_simple_app"])

      expect =
        "# with `mix dockerize.init --force --path test_projects/simple_app --app my_simple_app"

      assert dockerfile =~ expect
    end
  end

  describe "for a phoenix project" do
    test "it works" do
      {:ok, [dockerfile, release_cfg]} = generate("phoenix_app", ["--app", "my_phx_app"])

      assert dockerfile =~ "--app my_phx_app"

      assert dockerfile =~ """
             # ## -- BEGIN assets building with Node.js, NPM and webpack
             # # -----------------------------------
             # # - stage: build with NPM
             # # - job: assets
             # # - uncomment if you're using Nodejs,
             # #   NPM and webpack
             # # -----------------------------------
             """

      assert dockerfile =~ """
             ## -- BEGIN building assets with esbuild
             FROM compile_deps AS digest
             WORKDIR /src
             COPY assets/ ./assets
             ENV MIX_ENV=prod
             RUN mix assets.deploy
             ## -- END building assets with esbuild
             """

      assert release_cfg =~ ":my_phx_app"
    end
  end

  defp generate(project_name, opts) do
    path = Path.join("test_projects", project_name)

    ["--force", "--path", path | opts]
    |> Mix.Tasks.Dockerize.Init.run()

    files =
      ~w[Dockerfile config/releases.exs]
      |> Enum.map(&(Path.join(path, &1) |> File.read!()))

    {:ok, files}
  end
end
