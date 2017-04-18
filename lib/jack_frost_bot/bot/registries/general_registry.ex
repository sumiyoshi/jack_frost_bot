defmodule JackFrostBot.GeneralRegistry do
  @moduledoc false

  @key :general

  @spec opts() :: List.t
  def opts(), do: [:unique, @key]

  @spec set_general_id(any) :: any
  def set_general_id(slack) do
    channel_id = Enum.reduce(slack.channels, "", fn({id, channel}, acc) ->
      case channel.name == "velvet_room" do
        true -> id
        _ -> acc
      end
    end)

    Registry.register(@key, :id, channel_id)
  end

  @spec get_id() :: String.t | nil
  def get_id() do
    case Registry.lookup(@key, :id) do
      [{_pid, channel_id}] -> channel_id
      _ -> nil
    end
  end
end
