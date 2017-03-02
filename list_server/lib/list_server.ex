defmodule ListServer do
  use GenServer

  def start_link(list_data_pid) do
    GenServer.start_link(__MODULE__, list_data_pid, name: :list)
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


  def init(list_data_pid) do
    list = ListData.get_state(list_data_pid)
    {:ok, {list,list_data_pid}}
  end

  def handle_cast(:clear, {_list, list_data_pid}) do
    {:noreply, {[], list_data_pid}}
  end

  def handle_cast({:add, item}, {list, list_data_pid}) do
    {:noreply, {list ++ [item], list_data_pid}}
  end

  def handle_cast({:remove, item}, {list, list_data_pid}) do
    {:noreply, {List.delete(list, item),list_data_pid}}
  end

  def handle_cast(:crash, _state) do
    1 = 2
  end

  def handle_call(:items, _from, {list, list_data_pid}) do
    {:reply, list, {list, list_data_pid}}
  end

  def terminate(_reason, {list, list_data_pid}) do
    ListData.save_state list_data_pid, list
  end

end
