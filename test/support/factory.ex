defmodule Score.Factory do
  @moduledoc """
  Factory for user
  """
  alias ScorerApi.Users
  alias ScorerApi.Users.User
  alias ScorerApi.Repo

  def build(factory_name, params) do
    factory_name
    |> build()
    |> struct(params)
  end

  def build(:user) do
    %User{ points: 33 }
  end

  def insert!(factory_name, params \\ []) do
    factory_name
    |> build(params)
    |> Repo.insert!()
  end

  def insert(:user) do
    build(:user, %{points: 29})
    |> Map.from_struct()
    |> Users.create()
  end
end
