defmodule JackFrostBot.Supervisor do

  @moduledoc false

  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    api_key = Application.get_env(:slack, :api_token)

    children = [
      worker(Slack.Bot, [JackFrostBot.Bot, [], api_key]),
      supervisor(Registry, JackFrostBot.SlackRegistry.opts())
    ]

    supervise(children, strategy: :one_for_one)
  end

end
