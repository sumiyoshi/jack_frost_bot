use Mix.Config

config :quantum, :jack_frost_bot,
cron: [
    "0 12 * * 1-5": {JackFrostBot.ScheduleAction, :lunch},
    "0 15 * * 1-5": {JackFrostBot.ScheduleAction, :pickup}
]

config :quantum,
  timezone: "Asia/Tokyo"

import_config "#{Mix.env}.exs"
