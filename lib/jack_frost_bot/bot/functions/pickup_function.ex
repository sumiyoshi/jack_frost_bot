defmodule JackFrostBot.PickupFunction do
  @moduledoc false


  @spec call() :: String.t
  def call() do
    pickup_url = Application.get_env(:jack_frost_bot, :pickup_url)

    case pickup_response(HTTPoison.get(pickup_url)) do
      nil -> "今日のオススメはないぽよん"
      link -> "今日の夕飯にいかがぽよん?\r" <> link
    end
  end

  @spec pickup_response(Map.t) :: String.t | nil
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

end
