defmodule ScorerApi.ApiTest do
  use ExUnit.Case

  import Mox

  alias ScorerApi.Api

  setup :verify_on_exit!

  describe "get_users/0" do
    test "returns an empty list of users and timestamp nil in first call" do
      expect(ScorerWorkerMock, :get_users, fn ->
        {:reply, %{timestamp: nil, users: []}}
      end)

      assert {:reply, %{timestamp: nil, users: []}} = Api.get_users()
    end

    test "returns a list with of users and the previous timestamp" do
      user_1 = %{id: 1, points: 100}

      expect(ScorerWorkerMock, :get_users, fn ->
        {:reply, %{timestamp: "2022-02-18 04:01:08", users: [user_1]}}
      end)

      assert {:reply, %{timestamp: "2022-02-18 04:01:08", users: [user_1]}} = Api.get_users()
    end

    test "returns a list with of at most 2 users and the previous timestamp" do
      user_1 = %{id: 1, points: 100}
      user_2 = %{id: 2, points: 100}
      user_3 = %{id: 3, points: 100}

      expect(ScorerWorkerMock, :get_users, fn ->
        {:reply, %{timestamp: "2022-02-18 04:01:08", users: [user_1, user_2]}}
      end)

      assert {:reply, %{timestamp: "2022-02-18 04:01:08", users: [user_1, user_2]}} =
               Api.get_users()
    end
  end
end
