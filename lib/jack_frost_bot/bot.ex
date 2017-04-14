defmodule JackFrostBot.Bot do

  @moduledoc false

  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}!!"
    {:ok, state}
  end

  def handle_message(message = %{type: "message", text: _}, slack, state) do
    case String.starts_with?(message.text, "<@#{slack.me.id}> ") do
      true -> BotAction.Supervisor.start_action(state, :respond, message, slack)
      _ -> :ok
    end
    {:ok, state}
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end
end
