defmodule ScorerApi.Users.User do
  @moduledoc """
  The Users schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :points, :integer

    timestamps()
  end

  @doc false
  def changeset(user, params) do
    user
    |> cast(params, [:points])
    |> validate_required([:points])
    |> validate_inclusion(:points, 0..100)
  end
end
