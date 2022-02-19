defmodule ScorerApi.Api do
  @moduledoc """
    This module implements the call to ScorerWorker.get_users()
  """
  alias ScorerApi.Workers.ScorerWorker

  def get_users() do
    server_impl().get_users()
  end

  defp server_impl() do
    Application.get_env(:api, :scorer_server, ScorerWorker)
  end
end
