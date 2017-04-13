defmodule BotAction.Action do

  @moduledoc false

  use Slack

  def hear("hear?", message, slack), do: send_message("I can hear", message.channel, slack)

  def hear(_, message, slack), do: send_message("僕のこと呼んでよ！！", message.channel, slack)

  def respond("respond?", message, slack), do: send_message("I can respond", message.channel, slack)

  def respond(_, _, _), do: send_message("はーーーーーーい！！", message.channel, slack)

end
