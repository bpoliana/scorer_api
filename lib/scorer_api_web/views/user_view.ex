defmodule ScorerApiWeb.UserView do
  use ScorerApiWeb, :view

  def render("index.json", %{users: users, timestamp: timestamp}) do
    %{
      users: render_many(users, __MODULE__, "user.json"),
      timestamp: timestamp
    }
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, points: user.points}
  end
end
