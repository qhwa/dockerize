use Mix.Config

if Mix.env() != :prod do
  config :git_hooks,
    auto_install: true,
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          "mix format --check-formatted"
        ]
      ],
      pre_push: [
        verbose: false,
        tasks: [
          "mix credo",
          "mix dialyzer",
          "mix test",
          "echo 'success!'"
        ]
      ]
    ]
end
