defmodule ScorerApiWeb.UserController do
  use ScorerApiWeb, :controller

  alias ScorerApi.Users

  action_fallback ScorerApiWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_all()
    render(conn, "index.json", users: users)
  end
end
