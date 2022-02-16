defmodule ScorerApiWeb.UserControllerTest do
  use ExUnit.Case
  use ScorerApiWeb.ConnCase

  import ScorerApi.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2" do
    test "returns an empty list of users and timestamp nil in first call", %{conn: conn} do
      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert response == %{
               "users" => [],
               "timestamp" => nil
             }
    end

    test "returns a list with of users and the previous timestamp", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))

      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert is_list(response["users"])
      assert is_binary(response["timestamp"])
    end
  end
end
