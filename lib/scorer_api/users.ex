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

  def update_user(%User{} = user, params) do
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

    {:ok, Repo.all(query)}
  end

  def update_all do
    update(User,
      set: [
        points: fragment("floor(random()*100)"),
        updated_at: fragment("now()")
      ]
    )
    |> Repo.update_all([])
  end
end
