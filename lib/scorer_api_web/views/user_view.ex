defmodule ScorerApiWeb.UserView do
  use ScorerApiWeb, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, points: user.points}
  end
end
