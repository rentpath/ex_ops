defmodule ExOps.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_ops,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      test_coverage: test_coverage(),
      preferred_cli_env: preferred_cli_env(),
   ]
  end

  def application do
    [
      extra_applications: [:logger],
      env: [
        build_info_regex: ~r/:\s([\w|-]+)/,
        deploy_info_regex: ~r/:\s\"(.+)\"\n/,
        info_files: %{
          build_info_file: "../BUILD-INFO",
          deploy_info_file: "../DEPLOY-INFO",
          previous_build_info_file: "../PREVIOUS-BUILD-INFO",
          previous_deploy_info_file: "../PREVIOUS-DEPLOY-INFO",
        }
      ],
    ]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.6.1", only: :test},
      {:credo, "~> 0.6.0", only: [:dev, :test]},
      {:plug, "~> 1.0"},
      {:poison, ">= 1.4.0"},
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
      files: ["lib", "priv", "mix.exs", "README*", "LICENSE*"],
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
      "coveralls": :test,
      "coveralls.detail": :test,
      "coveralls.post": :test,
      "coveralls.html": :test
    ]
  end
end
