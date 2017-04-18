defmodule JackFrostBot do
  @moduledoc """

    JackFrostBot

  """

  use Application

  def start(_type, _args) do
    JackFrostBot.Supervisor.start_link
  end

end
