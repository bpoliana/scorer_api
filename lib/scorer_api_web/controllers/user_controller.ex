defmodule ScorerApiWeb.UserController do
  use ScorerApiWeb, :controller

  alias ScorerApi.Api

  action_fallback ScorerApiWeb.FallbackController

  def index(conn, _params) do
    {:ok, %{users: users, timestamp: timestamp}} = Api.get_users()

    render(conn, "index.json", %{users: users, timestamp: timestamp})
  end
end
