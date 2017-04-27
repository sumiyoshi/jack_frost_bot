defmodule JackFrostBot.ScheduleAction do
  @moduledoc false

  alias JackFrostBot.SlackRegistry
  alias Slack.Sends

  @spec lunch() :: String.t
  def lunch() do
    send_message("ジャックフロストが12時ぐらいをお知らせぽよん")
  end

  @spec pickup() :: String.t
  def pickup() do

    pickup_url = Application.get_env(:jack_frost_bot, :pickup_url)

    case pickup_response(HTTPoison.get(pickup_url)) do
      nil -> send_message("今日のオススメはぽよん")
      link -> send_message("今日の夕飯にいかがぽよん?\r" <> link)
    end
  end

  defp pickup_response({:ok, %HTTPoison.Response{body: body}}) do
    pickup_url = Application.get_env(:jack_frost_bot, :pickup_url)
    pickup_regex = Application.get_env(:jack_frost_bot, :pickup_regex)

    case Enum.at(Regex.scan(pickup_regex, body), 0) do
      nil -> nil
      link ->
        case Enum.count(link) == 2 do
          true -> pickup_url <> Enum.at(link, 1)
          _ -> nil
        end
    end
  end

  defp pickup_response(_), do: nil

  def send_message(message) do
    Sends.send_message(message, SlackRegistry.get_id(), SlackRegistry.get_slack())
  end

end
