defmodule JackFrostBot.Bot do

  @moduledoc false

  use Slack

  alias JackFrostBot.SlackRegistry
  alias JackFrostBot.ReplyAction

  def handle_connect(slack, state) do
    SlackRegistry.set_channel_id(get_main_channel(slack))
    SlackRegistry.set_slack(slack)
    reply("参上！", SlackRegistry.get_id(), slack)

    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do

    SlackRegistry.update_slack(slack)

    cond do
      String.starts_with?(message.text, "<@#{slack.me.id}> #") ->
        value = String.split(String.replace(trigger(message), "#", ""), "=")
        if (Enum.count(value) == 2) do
          reply(ReplyAction.memory(Enum.at(value, 0), Enum.at(value, 1)), message.channel, slack)
        end
      String.starts_with?(message.text, "<@#{slack.me.id}> ") ->
        reply(ReplyAction.respond(trigger(message)), message.channel, slack)
      true -> :ok
    end

    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}

  defp reply(response, channel, slack), do: send_message(response, channel, slack)

  defp trigger(message) do
    trigger = String.split(message.text, ~r{ |　})

    case Enum.count(trigger) do
      1 -> Enum.fetch!(trigger, 0)
       _ ->
         [_|tail] = trigger
         Enum.join(tail, " ")
    end
  end

  defp get_main_channel(slack) do
    Enum.reduce(slack.channels, "", fn({id, channel}, acc) ->

#      case channel.is_general do
      case channel.name == "velvet_room" do
        true -> id
        _ -> acc
      end
    end)
  end

end
