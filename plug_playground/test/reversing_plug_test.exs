defmodule ReversingPlug do
  use Plug.Builder
  import Plug.Conn

  plug :hello
  plug :reverse
  plug :sender

  def hello(conn, _opts) do
    %Plug.Conn{conn | resp_body: "Hello world"}
  end

  def reverse(conn, _opts) do
    %Plug.Conn{conn | resp_body: String.reverse(conn.resp_body)}
  end

  def sender(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, conn.resp_body)
  end
end

defmodule ReversingPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts ReversingPlug.init([])

  test "returns Hello world reversed" do
    # Create a test connection
    conn = conn(:get, "/")

    # Invoke the plug
    conn = ReversingPlug.call(conn, @opts)

    # Test the output
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "dlrow olleH"
  end
end
