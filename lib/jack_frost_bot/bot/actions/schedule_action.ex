defmodule JackFrostBot.ScheduleAction do
  @moduledoc false

  alias JackFrostBot.SlackRegistry
  alias Slack.Sends

  @spec lunch() :: String.t
  def lunch() do
    send_message("ジャックフロストが午前12時をお知らせ中")
  end

  def send_message(message) do
    Sends.send_message(message, SlackRegistry.get_id(), SlackRegistry.get_slack())
  end

end
