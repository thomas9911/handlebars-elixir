defmodule HandlebarsRs.MixProject do
  use Mix.Project

  def project do
    [
      app: :handlebars_rs,
      version: "0.1.0",
      elixir: "~> 1.14-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :eex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:zappa, github: "fireproofsocks/zappa"},
      {:rustler, "~> 0.26"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:benchee, "~> 1.0", only: [:dev, :prod]}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
