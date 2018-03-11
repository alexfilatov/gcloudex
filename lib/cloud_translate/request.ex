defmodule GCloudex.CloudTranslate.Request do
  @moduledoc """
  Offers HTTP requests to be used by the Google Cloud Translate wrapper.
  """

  defmacro __using__(_opts) do
    quote do
      alias HTTPoison, as: HTTP
      alias GCloudex.Auth, as: Auth
      alias HTTPoison.HTTPResponse

      @endpoint "translation.googleapis.com"
      @project  GCloudex.get_project_id

      def request(atom, path, body \\"", headers \\ [])

      @doc"""
      Sends an HTTP request with query parameters.
      """
      @spec request(atom, binary, binary, list(tuple)) :: HTTPResponse.t
      def request(:get, path, _body, headers) do
        HTTP.request(
          :get,
          "https://" <> Path.join(@endpoint, path),
          "",
          headers ++ [{"Authorization", "Bearer #{Auth.get_token_storage(:cs)}"},
                      {"x-goog-project-id", @project}],
          []
        )
      end

      @doc"""
      Sends POST HTTP request.
      """
      @spec request(atom, binary, binary, list(tuple)) :: HTTPResponse.t
      def request(:post, path, body, headers) do
        HTTP.request(
          :post,
          "https://" <> Path.join(@endpoint, path),
          body,
          headers ++ [{"Authorization", "Bearer #{Auth.get_token_storage(:cs)}"},
                      {"x-goog-project-id", @project}],
          []
        )
      end

      defoverridable [
        request: 4,
      ]
    end
  end
end
