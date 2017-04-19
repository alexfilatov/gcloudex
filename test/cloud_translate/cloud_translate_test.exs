defmodule Test.Dummy.CloudTranslate do
  use ExUnit.Case
  use GCloudex.CloudTranslate.Impl, :cloud_translate


  @endpoint "translation.googleapis.com"
  @project_id GCloudex.get_project_id

  def request(verb, path, body, headers \\ []) do
    %{
      verb: verb,
      host: Path.join(@endpoint, path),
      body: body,
      headers:
        headers ++
        [
          {"Authorization", "Bearer Dummy Token"},
          {"x-goog-project-id", @project_id},
        ],
      opts: []
    }
  end
end

defmodule CloudTranslateTest do
  use ExUnit.Case, async: true
  alias Test.Dummy.CloudTranslate, as: API

  @endpoint "translation.googleapis.com"
  @project_id GCloudex.get_project_id

  #########################
  ### POST Speech Tests ###
  #########################

  test "list_languages" do
    assert true == API.languages()
  end

  ###############
  ### Helpers ###
  ###############

  defp build_expected(verb, path, headers, body) do
    %{
      verb: verb,
      host: Path.join(@endpoint, path),
      headers:
        headers ++
        [{"Authorization", "Bearer Dummy Token"},
         {"x-goog-project-id", @project_id}],
      body: body,
      opts: []
    }
  end
end
