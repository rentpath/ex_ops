defmodule ExOps.Version do
  @moduledoc"""
  Provides information about curent and previous deployments
  """
  defstruct [:deployment, :host]
  @type t :: %__MODULE__{deployment: Map, host: String.t}

  alias ExOps.{BuildDetails, HostInfo}

  def details do
    %__MODULE__{
      deployment: BuildDetails.full(),
      host: HostInfo.hostname(),
    }
  end
end
