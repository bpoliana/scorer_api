defmodule ScorerApi.Users do
  @moduledoc """
  The Users context
  """

  import Ecto.Query, warn: false
  alias ScorerApi.{Repo, Users.User}

  @spec create_user()
  def create_user(params \\ %{}) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def update_user(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.update()
  end

  def list_users do
    Repo.all(User)
  end
end
