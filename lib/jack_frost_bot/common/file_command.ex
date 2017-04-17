defmodule JackFrostBot.FileCommand do

  @moduledoc false

  def read(input) do
    case File.read(input) do
      {:ok, body} -> body |> String.split("\n")
      _ -> []
    end
  end

  def read(), do: []

  def read_json(input) do
    JackFrostBot.FileCommand.read(input)
    |> Enum.map(fn(line) ->
       case Poison.decode line do
         {:ok, body} -> body
         _ -> %{}
       end
    end)
    |> Enum.at(0)
  end

  def write(content, path) do
    File.write(path, content)
  end

  def write_json(content, path) do
    case Poison.encode content do
      {:ok, body} -> body
      _ -> %{}
    end
    |> JackFrostBot.FileCommand.write(path)
  end

end