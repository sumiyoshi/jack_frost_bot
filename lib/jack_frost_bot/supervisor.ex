defmodule JackFrostBot.Supervisor do

  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @bot_name JackFrostBot.Bot
  @action_sup_name BotAction.Supervisor

  def init(:ok) do
    api_key = Application.get_env(:jack_frost_bot, :slack_api_key)
    table = :ets.new(:work_bot, [:set, :public])

    children = [
      supervisor(@action_sup_name, [[name: @action_sup_name]]),
      worker(@bot_name, [api_key, [name: @bot_name, sup_action: @action_sup_name, ets: table]])
    ]

    supervise(children, strategy: :one_for_one)
  end

end