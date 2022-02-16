defmodule ScorerApiWeb.UserViewTest do
  use ScorerApiWeb.ConnCase

  import ScorerApi.Factory

  alias ScorerApiWeb.UserView

  test "render/2 index.json" do
    user = insert!(:user, %{points: 33})

    assert %{
             users: [%{id: user.id, points: user.points}],
             timestamp: nil
           } ==
             UserView.render(
               "index.json",
               %{users: [user], timestamp: nil}
             )
  end
end
