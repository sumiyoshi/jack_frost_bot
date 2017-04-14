defmodule BotAction.Supervisor do

  @moduledoc false

  def start_link(opts \\ []) do
    Task.Supervisor.start_link(opts)
  end

  @doc false
  def start_action(state, command, message, slack) do
    Task.Supervisor.start_child(state[:sup_action], fn ->

      trigger = String.split(message.text, ~r{ |　})

      trigger = case trigger |> Enum.count() do
        1 -> Enum.fetch!(trigger, 0)
         _ -> Enum.fetch!(trigger, 1)
      end

      case command do
        :respond -> BotAction.Action.respond(trigger, message.channel, slack)
        _ -> :ok
      end
    end)
  end

end
