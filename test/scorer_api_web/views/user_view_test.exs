defmodule ScorerApiWeb.UserViewTest do
  use ScorerApiWeb.ConnCase

  import ScorerApi.Factory

  alias ScorerApiWeb.UserView

  test "render/2 index.json" do
    user = insert!(:user, %{points: 33})

    assert %{
             data: [%{id: user.id, points: user.points}]
           } ==
             UserView.render(
               "index.json",
               %{users: [user]}
             )
  end
end
