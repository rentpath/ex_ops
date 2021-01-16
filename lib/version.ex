defmodule ExOps.Version do
  @moduledoc """
  Provides information about current and previous deployments
  """

  alias ExOps.{BuildDetails, HostInfo}

  @derive Jason.Encoder
  defstruct [:deployment, :host]

  @type t :: %__MODULE__{deployment: map(), host: String.t()}

  @spec details() :: __MODULE__.t()
  def details do
    %__MODULE__{
      deployment: BuildDetails.full(),
      host: HostInfo.hostname(),
    }
  end
end
