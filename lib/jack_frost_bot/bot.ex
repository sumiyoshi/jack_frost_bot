defmodule JackFrostBot.Bot do

  @moduledoc false

  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}!!"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    case String.starts_with?(message.text, "<@#{slack.me.id}> ") do
      true -> JackFrostBot.Action.respond(trigger(message)) |> send_message(message.channel, slack)
      _ -> :ok
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
