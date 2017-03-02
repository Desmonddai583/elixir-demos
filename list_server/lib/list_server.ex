defmodule ListServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :list)
  end

  def clear do
    GenServer.cast :list, :clear
  end

  def add(item) do
    GenServer.cast :list, {:add, item}
  end

  def remove(item) do
    GenServer.cast :list, {:remove, item}
  end

  def items do
    GenServer.call :list, :items
  end

  def crash do
    GenServer.cast :list, :crash
  end


  def init(list) do
    {:ok, list}
  end

  def handle_cast(:clear, list) do
    {:noreply, []}
  end

  def handle_cast({:add, item}, list) do
    {:noreply, list ++ [item]}
  end

  def handle_cast({:remove, item}, list) do
    {:noreply, List.delete(list, item)}
  end

  def handle_cast(:crash, list) do
    1 = 2
  end

  def handle_call(:items, _from, list) do
    {:reply, list, list}
  end

end
