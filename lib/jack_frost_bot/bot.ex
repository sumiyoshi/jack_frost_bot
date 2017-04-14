defmodule JackFrostBot.Bot do

  @moduledoc false

  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}!!"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do

    cond do
      String.starts_with?(message.text, "<@#{slack.me.id}> #") ->
        value = trigger(message) |> String.replace("#", "") |> String.split("=")
        if (Enum.count(value) == 2) do
          JackFrostBot.Action.memory(Enum.at(value, 0), Enum.at(value, 1))
          send_message("記憶したなり！", message.channel, slack)
        end
      String.starts_with?(message.text, "<@#{slack.me.id}> ") ->
        JackFrostBot.Action.respond(trigger(message)) |> send_message(message.channel, slack)
      true -> :ok
    end

    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}

  defp trigger(message) do
    trigger = String.split(message.text, ~r{ |　})

    case trigger |> Enum.count() do
      1 -> Enum.fetch!(trigger, 0)
       _ -> Enum.fetch!(trigger, 1)
    end
  end

end
