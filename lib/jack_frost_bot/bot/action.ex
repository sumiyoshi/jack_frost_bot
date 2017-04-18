defmodule JackFrostBot.Action do

  @moduledoc """

    JackFrostBot.Action

  """

  @end_of_word "ぽよん"
  @memory_path "data/memory.json"

  @spec read(String.t) :: List.t
  def read(path) do
    JackFrostBot.FileRepo.read(path)
  end

  @spec respond(String.t) :: String.t
  def respond(message) do

    memory = get_memory()

    case Map.has_key?(memory, message) do
      true -> Map.get(memory, message) <> @end_of_word
      _ -> request_api(message)
    end
  end

  @spec memory(String.t | Atom.t, String.t | Atom.t) :: :ok | {:error, any}
  def memory(key, val) do
    memory = get_memory()
    JackFrostBot.FileRepo.write_json(Map.put(memory, key, val), @memory_path)
  end

  @spec respond(String.t) :: String.t
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

  @spec get_memory() :: Map.t
  defp get_memory(), do: JackFrostBot.FileRepo.read_json(@memory_path)

  @spec do_response_decode(any) :: Tuple.t
  defp do_response_decode(%HTTPoison.Response{body: body}), do: {Poison.decode!(body)}

  defp do_response_decode(response), do: response

  @spec do_reply(Tuple.t) :: String.t
  defp do_reply({%{"results" => [%{"reply" => reply}]}}), do: reply

  defp do_reply({_params}), do: ""

end
