defmodule ScorerApi.UsersTest do
  use ScorerApi.DataCase

  import ScorerApi.Factory

  alias ScorerApi.Users
  alias ScorerApi.Users.User

  @valid_params %{points: 42}
  @invalid_params %{points: 101}

  describe "users" do
    test "create/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create(@valid_params)
      assert user.points == 42
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create(@invalid_params)
    end

    test "create/1 returns error with numbers not between 0..100" do
      assert {:error, %Ecto.Changeset{}} = Users.create(@invalid_params)
    end

    test "list_by_punctuation/1 returns a user with the given points" do
      user = insert!(:user, @valid_params)

      assert {:ok, [user]} == Users.list_by_punctuation(@valid_params.points, 1)
      assert @valid_params.points == user.points
    end

    test "update/2 with valid data updates the user" do
      {:ok, user} = Users.create(@valid_params)

      assert {:ok, %User{} = user} = Users.update(user, @valid_params)
      assert user.points == 42
    end

    test "update/2 with invalid data returns error changeset" do
      {:ok, user} = Users.create(@valid_params)

      assert {:error, %Ecto.Changeset{}} = Users.update(user, @invalid_params)
      assert user.points == @valid_params.points
    end

    test "list_all/0 returns all users" do
      user = insert!(:user, %{points: 42})

      assert Users.list_all() == [user]
    end
  end
end
