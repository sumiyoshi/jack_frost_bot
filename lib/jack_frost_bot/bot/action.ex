defmodule JackFrostBot.Action do

  @moduledoc false

  @end_of_word "ぽよん"
  @memory_path "data/memory.json"

  def respond("歌って") do
    JackFrostBot.FileCommand.read("data/sing.txt")
  end

  def respond(message) do

    memory = get_memory()

    case Map.has_key?(memory, message) do
      true -> Map.get(memory, message) <> @end_of_word
      _ -> request_api(message)
    end
  end

  def memory(key, val) do
    memory = get_memory()
    JackFrostBot.FileCommand.write_json(Map.put(memory, key, val), @memory_path)
  end

  defp request_api(message) do
    case Application.get_env(:jack_frost_bot, :talk_endpoint)
         |> HTTPoison.post({:form, [{:apikey, Application.get_env(:jack_frost_bot, :talk_api_key)}, {:query, message}]}, [], [])
    do
      {:ok, response} ->
        reply = response |> do_response_decode() |> do_reply()
        reply <> @end_of_word
      _ -> @end_of_word
    end
  end

  defp get_memory(), do: JackFrostBot.FileCommand.read_json(@memory_path)

  defp do_response_decode(%HTTPoison.Response{body: body}), do: {Poison.decode!(body)}

  defp do_response_decode(response), do: response

  defp do_reply({%{"results" => [%{"reply" => reply}]}}), do: reply

  defp do_reply({_params}), do: ""

end
