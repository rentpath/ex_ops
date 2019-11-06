defmodule ExOps.BuildDetails do
  @moduledoc """
  Build details
  nil will be returned as defaults
  """

  defstruct [:build_number, :commit_sha, :date, :short_commit_sha, :tag]
  @spec full(map()) :: map()
  def full(info_files \\ default_info_files()) do
    Map.merge(
      build_info(info_files.build_info_file, info_files.deploy_info_file),
      %{previous: build_info(info_files.previous_build_info_file, info_files.previous_deploy_info_file)}
    )
  end

  defp default_info_files, do: Application.get_env(:ex_ops, :info_files)
  defp build_info_regex, do: Application.get_env(:ex_ops, :build_info_regex)
  defp deploy_info_regex, do: Application.get_env(:ex_ops, :deploy_info_regex)

  defp build_info(build_info_file, deploy_info_file) do
    case read_and_parse(build_info_file, build_info_regex()) do
      {:ok, details} -> build_details(details, deploy_info_file)
      _ -> build_details(nil, nil)
    end
  end

  defp deploy_info_date(file_name) do
    case read_and_parse(file_name, deploy_info_regex()) do
      {:ok, [deploy_date]} -> deploy_date
      _ -> ""
    end
  end

  defp build_details([tag, build_number, commit_sha], deploy_info_file) do
    %__MODULE__{
      build_number: build_number,
      commit_sha: commit_sha,
      short_commit_sha: String.slice(commit_sha, 0..6),
      date: deploy_info_date(deploy_info_file),
      tag: tag,
    }
  end
  defp build_details(_, _) do
    %__MODULE__{}
  end

  defp read_and_parse(file_name, pattern) do
    case File.read(file_name) do
      {:ok, file} -> {:ok, parse_file(file, pattern)}
      _ -> :error
    end
  end

  defp parse_file(file, pattern) do
    pattern
    |> Regex.scan(file, capture: :all_but_first)
    |> Enum.map(&List.first/1)
  end
end
