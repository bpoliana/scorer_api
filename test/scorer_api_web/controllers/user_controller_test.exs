defmodule ScorerApiWeb.UserControllerTest do
  use ExUnit.Case
  use ScorerApiWeb.ConnCase

  import ScorerApi.Factory

  # setup :set_user

  describe "index" do
    test "should list an empty list of users", %{conn: conn} do
      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert response == %{"data" => []}
    end

    test "should list users and timestamp", %{conn: conn} do
      %{conn: assign(conn, :user, build(:user))}

      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert response == %{"data" => [], "timestamp" => nil}
    end
  end
end
