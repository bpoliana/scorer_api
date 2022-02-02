defmodule ScorerApi.Users do
  @moduledoc """
  The Users context
  """

  import Ecto.Query, warn: false
  alias ScorerApi.{Repo, Users.User}

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

  def get_user_by_points(points) do
    query =
      from(
        user in User,
        where: user.points >= ^points,
        order_by: [:points],
        limit: 1
      )

    Repo.one(query)
  end
end
