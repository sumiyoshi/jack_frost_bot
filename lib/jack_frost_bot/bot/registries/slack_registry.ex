defmodule JackFrostBot.SlackRegistry do
  @moduledoc false

  @key :slack_registry

  @spec opts() :: List.t
  def opts(), do: [:unique, @key]

  @spec set_channel_id(any) :: any
  def set_channel_id(channel_id), do: Registry.register(@key, :id, channel_id)

  @spec set_slack(any) :: any
  def set_slack(slack), do: Registry.register(@key, :slack, slack)

  @spec update_slack(any) :: any
  def update_slack(slack), do: Registry.update_value(@key, :slack, fn(_) -> slack end)

  @spec get_id() :: String.t | nil
  def get_id() do
    case Registry.lookup(@key, :id) do
      [{_pid, channel_id}] -> channel_id
      _ -> nil
    end
  end

  @spec get_slack() :: any
  def get_slack() do
    case Registry.lookup(@key, :slack) do
      [{_pid, slack}] -> slack
      _ -> nil
    end
  end
end
