defmodule ScorerApi.ScorerWorkerTest do
  use ScorerApi.DataCase, async: false

  import ScorerApi.Factory

  alias ScorerApi.Workers.ScorerWorker

  setup_all do
    start_supervised(ScorerWorker)

    :ok
  end

  describe "start_link/0" do
    test "returns :already_started when initialized again" do
      assert {:error, {:already_started, pid}} = ScorerWorker.start_link(nil)
      assert is_pid(pid)
    end
  end

  describe "get_users/0" do
    test "returns a list with no user and nil timestamp in first call and at most 2 users with 100 points call timestamp on second call" do
      assert %{timestamp: nil, users: []} == ScorerWorker.get_users()

      user1 = insert!(:user, points: 100)
      user2 = insert!(:user, points: 100)
      user3 = insert!(:user, points: 100)
      call_timestamp = now()

      assert %{timestamp: call_timestamp, users: [user1, user2]} ==
               ScorerWorker.get_users()
    end
  end

  defp now() do
    NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()
  end
end
