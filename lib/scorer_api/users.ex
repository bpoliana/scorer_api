defmodule ScorerApi.Users do
  @moduledoc """
  The Users context
  """

  import Ecto.Query, warn: false
  alias ScorerApi.{Repo, Users.User}

  def create(params \\ %{}) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def update(%User{} = user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end

  def list_all do
    Repo.all(User)
  end

  def list_by_punctuation(points, limit) do
    query =
      from(
        user in User,
        where: user.points >= ^points,
        order_by: [:points],
        limit: ^limit
      )

    Repo.all(query)
  end
end
