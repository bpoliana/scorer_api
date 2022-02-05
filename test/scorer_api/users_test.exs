defmodule ScorerApi.UsersTest do
  use ScorerApi.DataCase

  import ScorerApi.Factory

  alias ScorerApi.Users
  alias ScorerApi.Users.User

  @valid_number %{points: 42}
  @invalid_number %{points: 101}
  @invalid_points_number %{points: 182}

  describe "users" do
    test "create/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create(@valid_number)
      assert user.points == 42
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create(@invalid_points_number)
    end

    test "create/1 returns error with numbers not between 0..100" do
      assert {:error, %Ecto.Changeset{}} = Users.create(@invalid_points_number)
    end

    test "get_user_by_points/1 returns a user with the given points" do
      user = insert!(:user, @valid_number)

      assert [user] == Users.get_user_by_points(@valid_number.points)
      assert @valid_number.points == user.points
    end

    test "update/2 with valid data updates the user" do
      {:ok, user} = Users.create(@valid_number)

      assert {:ok, %User{} = user} = Users.update(user, @valid_number)
      assert user.points == 42
    end

    test "update/2 with invalid data returns error changeset" do
      {:ok, user} = Users.create(@valid_number)

      assert {:error, %Ecto.Changeset{}} = Users.update(user, @invalid_number)
      assert user.points == @valid_number.points
    end


    test "list_all/0 returns all users" do
      user = insert!(:user, %{points: 42})

      assert Users.list_all() == [user]
    end
  end
end
