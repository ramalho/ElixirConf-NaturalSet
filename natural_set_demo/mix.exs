defmodule NaturalSetDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :natural_set_demo,
      version: "2020.8.31",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "NaturalSetDemo",
      source_url: "https://github.com/ramalho/ElixirConf-NaturalSet/natural_set_demo",
      homepage_url: "https://hexdocs.pm/natural_set/api-reference.html",
      docs: [
        logo: "img/N0.png",
        extras: ["README.md"]
      ]
  ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:natural_set, "~> 0.2.1"},
    ]
  end
end
