defmodule ScorerApiWeb.UserControllerTest do
  use ExUnit.Case
  use ScorerApiWeb.ConnCase

  import ScorerApi.Factory

  describe "index" do
    test "should list an empty list of users", %{conn: conn} do
      response =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert response == %{"data" => []}
    end
  end
end
