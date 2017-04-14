defmodule BotAction.Action do

  @moduledoc false

  use Slack

  def respond("hi!", channel, slack), do: send_message("hi！", channel, slack)

  def respond("われは汝", channel, slack), do: send_message("汝はわれ", channel, slack)

  def respond(message, channel, slack) do
    case Application.get_env(:jack_frost_bot, :talk_endpoint)
         |> HTTPoison.post({:form, [{:apikey, Application.get_env(:jack_frost_bot, :talk_api_key)}, {:query, message}]}, [], [])
    do
      {:ok, response} ->
        reply = response |> do_response_decode() |> do_reply()
        send_message(reply <> "ぽよん", channel, slack)
      _ -> :ok
    end
  end

  def respond(_, _, _), do: :ok

  defp do_response_decode(%HTTPoison.Response{body: body}), do: {Poison.decode!(body)}

  defp do_response_decode(response), do: response

  defp do_reply({%{"results" => [%{"reply" => reply}]}}), do: reply

  defp do_reply({_params}), do: ""

end
