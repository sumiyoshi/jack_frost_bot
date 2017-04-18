defmodule JackFrostBot.Bot do

  @moduledoc false

  use Slack

  alias JackFrostBot.GeneralRegistry

  def handle_connect(slack, state) do
    GeneralRegistry.set_general_id(slack)
    reply("ようこそ…我がベルベットルームへ", GeneralRegistry.get_id(), slack)

    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    cond do
      String.starts_with?(message.text, "<@#{slack.me.id}> #") ->
        value = String.split(String.replace(trigger(message), "#", ""), "=")
        if (Enum.count(value) == 2) do
          reply(JackFrostBot.Action.memory(Enum.at(value, 0), Enum.at(value, 1)), message.channel, slack)
        end
      String.starts_with?(message.text, "<@#{slack.me.id}> ") ->
        reply(JackFrostBot.Action.respond(trigger(message)), message.channel, slack)
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

end
