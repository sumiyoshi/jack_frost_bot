use Mix.Config
#config  :jack_frost_bot,
#  slack_api_key: "",
#  talk_endpoint: "",
#  talk_api_key: ""


config :quantum, :jack_frost_bot,
cron: [
    "0 12 * * 1-5": {JackFrostBot.ScheduleAction, :lunch}
]

config :quantum,
  timezone: "Asia/Tokyo"

import_config "prod.secret.exs"