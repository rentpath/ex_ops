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
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
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
end
