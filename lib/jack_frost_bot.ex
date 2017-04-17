defmodule JackFrostBot do
  @moduledoc false

  use Application

  def start(_type, _args) do
    JackFrostBot.Supervisor.start_link
  end

end
