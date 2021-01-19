defmodule ExOps.PlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias ExOps.Plug

  describe "/ops/version" do
    test "returns versioning information" do
      conn =
        :get
        |> conn("/version")
        |> Plug.call([])

      data = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 200
      assert Map.keys(data["deployment"]) ==
        ~w(build_number commit_sha date previous short_commit_sha tag)
    end
  end

  describe "/ops/env" do
    test "returns env information" do
      conn =
        :get
        |> conn("/env")
        |> Plug.call([])

      data = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 200
      assert data["env_info"] == "Env info coming soon"
    end
  end

  describe "/ops/heartbeat" do
    test "returns heartbeat data" do
      conn =
        :get
        |> conn("/heartbeat")
        |> Plug.call([])

      data = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 200
      assert data["status"] == 200
      assert data["message"] == "Ok"
    end
  end

  test "pass through connection" do
    conn =
      :get
      |> conn("/ver")
      |> Plug.call([])

    assert is_nil(conn.status)
  end
end
