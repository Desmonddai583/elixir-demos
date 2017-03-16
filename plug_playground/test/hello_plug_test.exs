defmodule HelloPlug do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    conn
      |> put_resp_content_type("text/plain")
      |> send_resp(200, "Hello world")
  end
end

defmodule HelloPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts HelloPlug.init([])

  test "returns hello world" do
    conn = conn(:get, "/")

    conn = HelloPlug.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Hello world"
  end
end
