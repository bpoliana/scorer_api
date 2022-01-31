defmodule ScorerApiWeb.PageController do
  use ScorerApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
