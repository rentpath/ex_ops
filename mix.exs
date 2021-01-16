defmodule ExOps.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_ops,
      version: "2.2.0",
      elixir: "~> 1.10",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      test_coverage: test_coverage(),
      preferred_cli_env: preferred_cli_env(),
      name: "ex_ops",
      source_url: "https://github.com/rentpath/ex_ops",
      elixirc_options: [warnings_as_errors: true]
   ]
  end

  def application do
    [
      extra_applications: [:logger],
      env: [
        build_info_regex: ~r/:\s([\w|-]+)/,
        deploy_info_regex: ~r/:\s\"(.+)\"\n/,
        info_files: %{
          build_info_file: %{
            type: :path,
            path: "../BUILD-INFO"
          },
          deploy_info_file: %{
            type: :path,
            path: "../DEPLOY-INFO",
          },
          previous_build_info_file: %{
            type: :path,
            path: "../PREVIOUS-BUILD-INFO"
          },
          previous_deploy_info_file: %{
            type: :path,
            path: "../PREVIOUS-DEPLOY-INFO"
          }
        }
      ],
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.5.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:excoveralls, "~> 0.12", only: :test},
      {:jason, "~> 1.2"},
      {:plug, "~> 1.0"}
    ]
  end

  defp description do
    """
    Provides standardized support for obtaining environment, version, and heartbeat information in JSON format
    """
  end

  defp package do
    [
      name: :ex_ops,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["devadmin@rentpath.com", "Pasha Lifshiz <plifshiz@gmail.com>"],
      links: %{"GitHub" => "https://github.com/rentpath/ex_ops"},
      licenses: ["The MIT License"]
    ]
  end

  defp test_coverage do
    [tool: ExCoveralls]
  end

  defp preferred_cli_env do
    [
      coveralls: :test,
      "coveralls.detail": :test,
      "coveralls.post": :test,
      "coveralls.html": :test
    ]
  end
end
