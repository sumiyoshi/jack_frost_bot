defmodule JackFrostBot.ScheduleAction do
  @moduledoc false

  @spec time_report() :: String.t
  def time_report() do
    {{y, m, d}, {h, i, s}} = :calendar.local_time()
    "#{y}年#{m}月#{d}日 #{h}時#{i}分#{s}秒"
  end

end
