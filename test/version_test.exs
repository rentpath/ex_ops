defmodule ExOps.VersionTest do
  use ExUnit.Case, async: true
  alias ExOps.{Version, HostInfo}

  describe ".details" do
    test "response includes deployment" do
      assert Version.details.deployment |> Map.has_key?(:__struct__)
    end

    test "response includes host" do
      assert Version.details.host == HostInfo.hostname()
    end
  end
end
