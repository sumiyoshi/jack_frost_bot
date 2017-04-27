defmodule JackFrostBot.ReplyAction do

  @moduledoc false

  @end_of_word "ぽよん"
  @memory_path "data/memory.json"

  @spec respond(String.t) :: String.t
  def respond("元気のでる言葉") do
    reply = JackFrostBot.FileRepo.read("data/quotation.txt")
              |> Enum.shuffle()
              |> Enum.at(1)
              |> String.replace("END_OF_LINE", "\r")
    reply <> @end_of_word
  end

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

    "記憶したなり！"
  end

  @spec respond(String.t) :: String.t
  defp request_api(message) do
    case HTTPoison.post(
      Application.get_env(:jack_frost_bot, :talk_endpoint),
      {:form, [
        {:key, Application.get_env(:jack_frost_bot, :talk_api_key)},
        {:message, message}
      ]},
      [],
      [hackney: [:insecure]])
    do
      {:ok, response} ->
        reply =  do_response_decode(response) |> do_reply()
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
  defp do_reply({%{"result" => reply}}), do: reply

  defp do_reply({_params}), do: "わからんちん"

end
