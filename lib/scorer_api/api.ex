defmodule ScorerApi.Api do
  alias ScorerApi.Servers.ScorerServer

  def get_users() do
    server_impl().get_users()
  end

  defp server_impl() do
    Application.get_env(:api, :scorer_server, ScorerServer)
  end
end
