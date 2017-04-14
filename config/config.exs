# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config  :jack_frost_bot,
  slack_api_key: System.get_env("SLACK_API_KEY"),
  talk_endpoint: System.get_env("TALK_ENDPOINT"),
  talk_api_key: System.get_env("TALK_API_KEY")
