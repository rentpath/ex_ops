defmodule ExOps.Plug do
  @moduledoc """
  Retrieves deploy information
  """
  use Plug.Router

  import Plug.Conn

  plug :match
  plug :dispatch

  get "/env" do
    render(conn, %{env_info: "Env info coming soon"})
  end

  get "/heartbeat" do
    render(conn, %{status: 200, message: "Ok"})
  end

  get "/version" do
    render(conn, ExOps.Version.details)
  end

  match _, do: conn

  @spec call(Plug.Conn.t(), list()) :: Plug.Conn.t()
  def call(conn, opts) do
    conn
    |> Map.update(:path_info, "/", &Enum.take(&1, -1))
    |> plug_builder_call(opts)
  end

  defp render(conn, payload) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(payload))
  end
end
