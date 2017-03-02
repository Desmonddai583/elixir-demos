defmodule ListData do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], [])
  end

  def save_state(pid, state) do
    GenServer.cast pid, {:save_state, state}
  end

  def get_state(pid) do
    GenServer.call pid, :get_state
  end

  def init(list) do
    {:ok, list}
  end

  def handle_call(:get_state, _from, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_cast({:save_state, new_state}, _current_state) do
    {:noreply, new_state}
  end
end
