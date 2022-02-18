defmodule ScorerApi.Servers.UsersServer do
  @moduledoc """
    This module defines the Users Server behaviour with the get_users/0 function
  """

  @callback get_users() :: {:reply, map()} | {:error, binary()}
end
