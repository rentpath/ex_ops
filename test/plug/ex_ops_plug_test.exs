defmodule ExOps.PlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias ExOps.Plug

  describe "/ops/version" do
    test "returns versioning information" do
      conn = conn(:get, "/version")
      conn = Plug.call(conn, [])
      data = Poison.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 200
      assert Map.keys(data["deployment"]) ==
        ~w(build_number commit_sha date previous short_commit_sha tag)
    end
  end

  describe "/ops/env" do
    test "returns env information" do
      conn = conn(:get, "/env")
      conn = Plug.call(conn, [])
      data = Poison.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 200
      assert data["env_info"] == "Env info coming soon"
    end
  end

  describe "/ops/heartbeat" do
    test "returns heartbeat data" do
      conn = conn(:get, "/heartbeat")
      conn = Plug.call(conn, [])
      data = Poison.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 200
      assert data["status"] == 200
      assert data["message"] == "Ok"
    end
  end

  test "pass through connection" do
    conn = conn(:get, "/ver")
    conn = Plug.call(conn, [])

    assert is_nil(conn.status)
  end
end
