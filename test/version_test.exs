defmodule ExOps.VersionTest do
  use ExUnit.Case, async: true
  alias ExOps.{HostInfo, Version}

  describe ".details" do
    test "response includes deployment" do
      deployment_details = Version.details().deployment
      assert Map.has_key?(deployment_details, :__struct__)
    end

    test "response includes host" do
      assert Version.details.host == HostInfo.hostname()
    end
  end
end
