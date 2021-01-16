defmodule ExOps.HostInfo do
  @moduledoc """
  Provides information about current host
  """

  @spec hostname() :: String.t()
  def hostname, do: host_name()

  defp host_name do
    to_string(:net_adm.localhost)
  end
end
