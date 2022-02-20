defmodule ScorerApiWeb.UserControllerTest do
  use ExUnit.Case, async: false
  use ScorerApiWeb.ConnCase

  import Mox
  import ScorerApi.Factory

  setup :verify_on_exit!

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2" do
    test "returns an empty list of users and timestamp nil in first call", %{conn: conn} do
      expect(ScorerWorkerMock, :get_users, fn ->
        %{users: [], timestamp: nil}
      end)

      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert %{"users" => [], "timestamp" => nil} = response
    end

    test "returns a list with of users and the previous timestamp", %{conn: conn} do
      user_1 = insert!(:user, points: 100)

      expect(ScorerWorkerMock, :get_users, fn ->
        %{users: [user_1], timestamp: "2022-02-18 04:01:08"}
      end)

      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert is_list(response["users"])
      assert is_binary(response["timestamp"])
    end

    test "returns a list with at most 2 users and the previous timestamp", %{conn: conn} do
      user_1 = insert!(:user, points: 100)
      user_2 = insert!(:user, points: 100)
      user_3 = insert!(:user, points: 100)

      expect(ScorerWorkerMock, :get_users, fn ->
        %{users: [user_1, user_2], timestamp: "2022-02-18 04:01:08"}
      end)

      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert is_list(response["users"])
      assert is_binary(response["timestamp"])
    end
  end
end
