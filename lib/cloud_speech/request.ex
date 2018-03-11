defmodule GCloudex.CloudSpeech.Request do
  @moduledoc """
  Offers HTTP requests to be used by the Google Cloud Speech wrapper.
  """

  defmacro __using__(_opts) do
    quote do
      alias HTTPoison, as: HTTP
      alias GCloudex.Auth, as: Auth
      alias HTTPoison.Response, as: HTTPResponse

      @endpoint "speech.googleapis.com"
      @project  GCloudex.get_project_id

      @doc"""
      Sends an HTTP request without any query parameters.
      """
      @spec request(atom, binary, binary, list(tuple)) :: HTTPResponse.t
      def request(verb, path, body \\ "", headers \\ []) do
        HTTP.request(
          verb,
          "https://" <> Path.join(@endpoint, path),
          body,
          headers ++ [{"Authorization", "Bearer #{Auth.get_token_storage(:cs)}"},
                      {"x-goog-project-id", @project}],
          [timeout: 50_000, recv_timeout: 50_000]
        )
      end

      defoverridable [
        request: 4,
      ]
    end
  end
end
