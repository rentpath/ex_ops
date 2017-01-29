defmodule ExOps.BuildDetailsTest do
  use ExUnit.Case, async: true
  alias ExOps.BuildDetails

  describe ".full/1" do

    test "default response when files do not exist" do
      info_files = %{
        build_info_file: "foo",
        deploy_info_file: "bar",
        previous_build_info_file: "baz",
        previous_deploy_info_file: nil,
      }

      build_defaults = %BuildDetails{}
      detail_info = Map.merge(%BuildDetails{}, %{previous: build_defaults})

      assert BuildDetails.full(info_files) == detail_info
    end

    test "response when files exist" do
      info_files = %{
        build_info_file: "test/support/fixtures/BUILD-INFO-TEST",
        deploy_info_file: "test/support/fixtures/DEPLOY-INFO-TEST",
        previous_build_info_file: "test/support/fixtures/PREVIOUS-BUILD-INFO-TEST",
        previous_deploy_info_file: "test/support/fixtures/PREVIOUS-DEPLOY-INFO-TEST"
      }
      detail_info = Map.merge(build_details(), previous_details())

      assert BuildDetails.full(info_files) == detail_info
    end

    test "response when some file format does not match" do
      info_files = %{
        build_info_file: "test/support/fixtures/BUILD-INFO-BAD-FORMAT",
        deploy_info_file: "test/support/fixtures/DEPLOY-INFO-TEST",
        previous_build_info_file: "test/support/fixtures/PREVIOUS-BUILD-INFO-TEST",
        previous_deploy_info_file: "test/support/fixtures/PREVIOUS-DEPLOY-INFO-TEST"
      }
      detail_info = Map.merge(%BuildDetails{}, previous_details())

      assert BuildDetails.full(info_files) == detail_info
    end

    test "response when previus build info does not exist" do
      info_files = %{
        build_info_file: "test/support/fixtures/BUILD-INFO-TEST",
        deploy_info_file: "test/support/fixtures/DEPLOY-INFO-TEST",
        previous_build_info_file: "foo",
        previous_deploy_info_file: nil
      }

      detail_info = Map.merge(%{previous: %BuildDetails{}}, build_details())

      assert BuildDetails.full(info_files) == detail_info
    end

    test "response when previus build info exist but no current details" do
      info_files = %{
        build_info_file: "foo",
        deploy_info_file: nil,
        previous_build_info_file: "test/support/fixtures/PREVIOUS-BUILD-INFO-TEST",
        previous_deploy_info_file: "test/support/fixtures/PREVIOUS-DEPLOY-INFO-TEST"
      }
      detail_info = Map.merge(%BuildDetails{}, previous_details())

      assert BuildDetails.full(info_files) == detail_info
    end

    defp previous_details do
      %{
        previous: %BuildDetails{
          tag: "20161129-22-d7d5369",
          short_commit_sha: "d7d5369",
          date: "2016-12-06 17:59:15",
          commit_sha: "d7d5369a24870ac807da79d4e67a78c8e0ff25b",
          build_number: "22"
        }
      }
    end

    defp build_details do
      %BuildDetails{
        tag: "20161129-23-c736197",
        short_commit_sha: "c736197",
        date: "2016-12-06 18:04:27",
        commit_sha: "c7361976bdcb5bdf2cf4fd31b027ddc8dc5e598b",
        build_number: "23"
      }
    end
  end
end
