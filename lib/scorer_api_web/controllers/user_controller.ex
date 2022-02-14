defmodule ScorerApiWeb.UserController do
  use ScorerApiWeb, :controller

  alias ScorerApi.{Users, ScorerServer}

  action_fallback ScorerApiWeb.FallbackController

  def index(conn, _params) do
    %{users: users, timestamp: timestamp} = ScorerServer.get_users()

    render(conn, "index.json", %{users: users, timestamp: timestamp})
  end
end
