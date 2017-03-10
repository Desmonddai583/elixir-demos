defmodule ExactorTestTest do
  use ExUnit.Case
  doctest ExactorTest

  test "a basic actor" do
    { :ok, list } = ListActor.start_link
    assert ListActor.get(list) == []
    :ok = ListActor.put list, :banana
    assert ListActor.get(list) == [:banana]
    :ok = ListActor.put list, :apple
    assert ListActor.get(list) == [:banana, :apple]
    :ok = ListActor.take list, :banana
    assert ListActor.get(list) == [:apple]
  end

  test "a singleton" do
    CountActor.start_link 1
    assert CountActor.get == 1
    CountActor.inc
    assert CountActor.get == :two
    CountActor.inc
    CountActor.inc
    CountActor.inc
    assert CountActor.get == 5
    CountActor.dec
    assert CountActor.get == 4
  end
end
