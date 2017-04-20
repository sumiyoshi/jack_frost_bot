use Mix.Config
#config  :jack_frost_bot,
#  slack_api_key: "",
#  talk_endpoint: "",
#  talk_api_key: ""


config :quantum, :jack_frost_bot,
timezone: :local,
cron: [
    "0 12 * * 1-5": {JackFrostBot.ScheduleAction, :lunch}
]

import_config "prod.secret.exs"