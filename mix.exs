defmodule JackFrostBot.Mixfile do
  use Mix.Project

  def project do
    [app: :jack_frost_bot,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :slack],
     mod: {JackFrostBot, []}]
  end

  defp deps do
    [
      {:websocket_client, github: "jeremyong/websocket_client"},
      {:slack, "~> 0.2.0"},
      {:httpoison, "~> 0.7.2"},
      {:poison, "~> 1.5"}
    ]
  end
end
