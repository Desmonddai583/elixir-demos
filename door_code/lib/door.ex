defmodule Door do
  use GenStateMachine

  def start_link({code, remaining, unlock_time}) do
    GenStateMachine.start_link(Door, {:locked, {code, remaining, unlock_time}})
  end

  def get_state(pid) do
    {state, _data} = :sys.get_state(pid)
    state
  end

  def press(pid, digit) do
    GenStateMachine.cast(pid, {:press, digit})
  end

  def handle_event({:call, from}, :get_state, state, data) do
    {:next_state, state, data, [{:reply, from, state}]}
  end

  def handle_event(:cast, {:press, digit}, :locked, {code, remaining, unlock_time}) do
    case remaining do
      [digit] ->
        IO.puts "[#{digit}] Correct code.  Unlocked for #{unlock_time}"
        {:next_state, :open, {code, code, unlock_time}, unlock_time}
      [digit|rest] ->
        IO.puts "[#{digit}] Correct digit but not yet complete."
        {:next_state, :locked, {code, rest, unlock_time}}
      _ ->
        IO.puts "[#{digit}] Wrong digit, locking."
        {:next_state, :locked, {code, code, unlock_time}}
    end
  end

  def handle_event(:timeout, _, _, data) do
    IO.puts "timeout expired, locking door"
    {:next_state, :locked, data}
  end
end
