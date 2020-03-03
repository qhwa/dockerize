defmodule DockerizeTest do
  use ExUnit.Case
  doctest Dockerize

  test "greets the world" do
    assert Dockerize.hello() == :world
  end
end
