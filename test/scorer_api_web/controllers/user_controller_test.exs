defmodule ScorerApiWeb.UserControllerTest do
  use ExUnit.Case
  use ScorerApiWeb.ConnCase

  import ScorerApi.Factory

  describe "index/2" do
    test "returns an empty list of users", %{conn: conn} do
      user = insert!(:user, %{points: 99})

      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert response == %{"data" => [%{"id" => user.id, "points" => user.points}]}
    end

    test "returns a list with one user", %{conn: conn} do
      user = insert!(:user, %{points: 99})

      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert response == %{"data" => [%{"id" => user.id, "points" => user.points}]}
    end
  end
end
