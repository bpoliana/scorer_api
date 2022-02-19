defmodule ScorerApi.Workers.UsersWorker do
  @moduledoc """
    This module defines the Users Worker behaviour with the get_users/0 function
  """

  @callback get_users() :: {:reply, map()} | {:error, binary()}
end
