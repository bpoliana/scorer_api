defmodule ScorerApiWeb.UserControllerTest do
  use ExUnit.Case
  use ScorerApiWeb.ConnCase

  import ScorerApi.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2" do
    test "returns an empty list of users", %{conn: conn} do
      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert response == %{
               "users" => [],
               "timestamp" => nil
             }
    end

    test "returns a list with one user", %{conn: conn} do
      user = insert!(:user, %{points: 42})

      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert response["users"] == [%{"id" => user.id, "points" => user.points}]
      assert is_binary(response["timestamp"])
    end
  end
end
