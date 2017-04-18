defmodule JackFrostBot.FileRepo do

  @moduledoc  """

    JackFrostBot.FileRepo

  """

  @spec read(String.t) :: List.t
  def read(input) do
    case File.read(input) do
      {:ok, body} -> String.split(body, "\n")
      _ -> []
    end
  end

  @spec read_json(String.t) :: Map.t
  def read_json(input) do
    JackFrostBot.FileRepo.read(input)
    |> Enum.map(fn(line) ->
       case Poison.decode line do
         {:ok, body} -> body
         _ -> %{}
       end
    end)
    |> Enum.at(0)
  end

  @spec write(any, String.t) :: :ok | {:error, any}
  def write(content, path) do
    File.write(path, content)
  end

  @spec write_json(any, String.t) :: :ok | {:error, any}
  def write_json(content, path) do
    body = case Poison.encode content do
      {:ok, body} -> body
      _ -> %{}
    end

    JackFrostBot.FileRepo.write(body, path)
  end

end
