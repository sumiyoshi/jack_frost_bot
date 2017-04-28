defmodule JackFrostBot.ScheduleAction do
  @moduledoc false

  alias JackFrostBot.SlackRegistry
  alias Slack.Sends

  @spec lunch() :: String.t
  def lunch() do
    send_message("ジャックフロストが12時ぐらいをお知らせぽよん")
  end

  @spec pickup() :: String.t
  def pickup() do
    JackFrostBot.PickupFunction.call()
    |> send_message()
  end

  def send_message(message) do
    Sends.send_message(message, SlackRegistry.get_id(), SlackRegistry.get_slack())
  end

end
