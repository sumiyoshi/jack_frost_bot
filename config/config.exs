# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config  :jack_frost_bot,
  api_key: System.get_env("API_KEY")
