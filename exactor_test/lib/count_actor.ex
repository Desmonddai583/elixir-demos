defmodule CountActor do
  use ExActor.GenServer, export: :counter

  defstart start_link(state), do: initial_state(state)
  defcall get, state: 2, do: reply(:two)
  defcall get, state: state, do: reply(state)
  defcast inc, state: state, do: new_state(state + 1)
  defcast dec, state: state, do: new_state(state - 1)
end
