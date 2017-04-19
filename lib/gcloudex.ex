defmodule GCloudex do

  @moduledoc """
  Set of wrappers for Google Cloud Platform's services API's.
  """

  @doc """
  Returns the Google Project ID specified in the creds.json file in the configs.
  """
  @spec get_project_id :: binary
  def get_project_id do
    :goth
    |> Application.get_env(:json)
    |> (fn(env_var) ->
      case env_var do
        {:system, "GOOGLE_APPLICATION_CREDENTIALS"} -> System.get_env("GOOGLE_APPLICATION_CREDENTIALS") |> File.read!()
        {:system, var} -> System.get_env(var) # when we have JSON credentials contents in the var
        json -> json
      end
    end).()
    |> Poison.decode!
    |> Map.get("project_id")
  end
end
