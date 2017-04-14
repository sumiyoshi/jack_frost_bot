defmodule JackFrostBot.Action do

  @moduledoc false

  @end_of_word "ぽよん"

  def respond(message) do
    case Application.get_env(:jack_frost_bot, :talk_endpoint)
         |> HTTPoison.post({:form, [{:apikey, Application.get_env(:jack_frost_bot, :talk_api_key)}, {:query, message}]}, [], [])
    do
      {:ok, response} ->
        reply = response |> do_response_decode() |> do_reply()
        reply <> @end_of_word
      _ -> @end_of_word
    end
  end

  defp do_response_decode(%HTTPoison.Response{body: body}), do: {Poison.decode!(body)}

  defp do_response_decode(response), do: response

  defp do_reply({%{"results" => [%{"reply" => reply}]}}), do: reply

  defp do_reply({_params}), do: ""

end
