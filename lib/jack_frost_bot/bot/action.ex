defmodule JackFrostBot.Action do

  @moduledoc """

    JackFrostBot.Action

  """

  alias JackFrostBot.ReplyAction

  @spec respond(String.t) :: String.t
  def respond(message), do: ReplyAction.respond(message)

  @spec memory(String.t | Atom.t, String.t | Atom.t) :: :ok | {:error, any}
  def memory(key, val), do: ReplyAction.memory(key, val)

end
