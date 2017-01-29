defmodule ExOps.HostInfoTest do
  use ExUnit.Case, async: true
  alias ExOps.HostInfo

  describe ".hostname" do
    test "response includes hostname" do
      assert String.length(HostInfo.hostname()) > 0
    end
  end
end
