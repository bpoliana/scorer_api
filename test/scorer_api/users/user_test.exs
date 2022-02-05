defmodule ScorerApi.Users.UserTest do
  use ScorerApi.DataCase

  import ScorerApi.Factory

  alias ScorerApi.Users.User

  @invalid_points_number %{points: 182}

  describe "changeset/2" do
    test "validates changeset" do
      user = insert(:user)
      user_params = %{points: 13}

      assert changeset = %Ecto.Changeset{valid?: true} = User.changeset(%User{}, user_params)
      changes = changeset.changes

      assert changes.points == user_params.points
    end

    test "validates the presence of all the fields" do
      assert %Ecto.Changeset{errors: errors} = User.changeset(%User{}, %{})

      assert [points: {"can't be blank", [validation: :required]}] = errors
    end

    test "validates that points is a number between 0..100" do
      errors = User.changeset(%User{}, @invalid_points_number)

      assert {"is invalid", [validation: inclusion, enum: 0..100]} = errors.errors[:points]
    end
  end
end
