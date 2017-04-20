defmodule JackFrostBotTest do
  use ExUnit.Case

  test "the truth" do


    JackFrostBot.FileRepo.read("data/quotation.txt")
    |> Enum.shuffle()
    |> Enum.at(1)
    |> String.replace("END_OF_LINE", "\r")
    |> IO.inspect()


    assert 1 + 1 == 2
  end

end
