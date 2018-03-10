defmodule GCloudex.CloudSpeech.Impl do

  @moduledoc """
  Wrapper for Google Cloud Speech API.
  """
  defmacro __using__(:cloud_speech) do
    quote do
      use GCloudex.CloudSpeech.Request

      ###################
      ### POST Speech ###
      ###################

      @doc"""
      Performs asynchronous speech recognition: receive results via the
      google.longrunning.Operations interface.
      """
      @spec longrunningrecognize(body :: binary) :: HTTPResponse.t
      def longrunningrecognize(body) do
        request(:post, "v1/speech:longrunningrecognize", body)
      end

      ##################
      ### GET Speech ###
      ##################

      @doc"""
      Gets the latest state of a long-running operation. Clients can use this
      method to poll the operation result at intervals as recommended by the
      API service.
      """
      @spec get(name :: binary) :: HTTPResponse.t
      def get(name) do
        request(:get, "v1/operations/#{name}")
      end
    end
  end
end
