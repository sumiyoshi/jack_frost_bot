defmodule BotAction.Action do

  @moduledoc false

  use Slack

  def hear("hear?", message, slack), do: send_message("I can hear", message.channel, slack)

  def hear(_, _, _), do: :ok

  def respond("respond?", message, slack), do: send_message("I can respond", message.channel, slack)

  def respond(_, _, _), do: :ok

end
