defmodule ScorerApi.ScorerServerTest do
  use ScorerApi.DataCase, async: false

  import Mox

  alias ScorerApi.Servers.ScorerServer

  describe "start_link/0" do
    setup do
      start_supervised(ScorerServer)

      :ok
    end

    test "returns :already_started when initialized again" do
      assert {:error, {:already_started, pid}} = ScorerServer.start_link(nil)
      assert is_pid(pid)
    end
  end

  describe "get_users/0" do
    test "returns a list of users and nil timestamp with first call" do
      assert %{timestamp: nil, users: []} == ScorerServer.get_users()
    end
  end

  defp now() do
    NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()
  end
end
