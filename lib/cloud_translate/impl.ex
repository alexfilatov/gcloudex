defmodule GCloudex.CloudTranslate.Impl do

  @moduledoc """
  Wrapper for Google Cloud Translate API.
  """
  defmacro __using__(:cloud_translate) do
    quote do
      use GCloudex.CloudTranslate.Request
      alias HTTPoison.Response, as: HTTPResponse

      @doc"""
      Performs Translate
      Translates input text, returning translated text.
      body = %{
        q: binary (required, input text to translate)
        target: binary (required,  language to use for translation of the input text)
        format: binary (optional, "html" or "text",  format of the source text, in either HTML (default) or plain-text)
        source: binary (optional, language of the source text, autodetect if not specified)
        model: binary (optional, "base" or "nmt", "base" - Phrase-Based Machine Translation, "nmp" - Neural Machine Translation. "nmt" by default)
      }
      """
      @spec translate(body :: any()) :: HTTPResponse.t
      def translate(body) when is_binary(body) do
        request(:post, "language/translate/v2", body)
      end

      @spec translate(map :: map()) :: HTTPResponse.t
      def translate(map) when is_map(map) do
        request(:post, "language/translate/v2", Jason.encode!(map))
      end

      @doc"""
      Performs Detect Language
      Detects the language of text within a request.
      body = %{
        q: binary (required, the input text upon which to perform language detection)
      }
      """
      @spec detect(map :: map()) :: HTTPResponse.t
      def detect(map) when is_map(map) do
        request(:post, "language/translate/v2/detect", Jason.encode!(map))
      end

      @spec detect(body :: any()) :: HTTPResponse.t
      def detect(body) when is_binary(body) do
        request(:post, "language/translate/v2/detect", body)
      end


      @doc"""
      Performs Detect Language
      Detects the language of text within a request.
      body = %{
        target: binary (optional, the target language code for the results)
      }
      """

      @spec languages(map :: map()) :: HTTPResponse.t
      def languages(map) when is_map(map) do
        map
        |> URI.encode_query()
        |> languages()
      end

      @spec languages(body :: any()) :: HTTPResponse.t
      def languages(body) do
        request(:get, "language/translate/v2/languages", body)
      end

      @spec languages() :: HTTPResponse.t
      def languages() do
        languages("")
      end

    end
  end
end
