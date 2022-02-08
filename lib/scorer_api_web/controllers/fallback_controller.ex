defmodule ScorerApiWeb.FallbackController do
  use ScorerApiWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ScorerApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ScorerApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :invalid_fields, invalid_fields}) do
    errors = Enum.map(invalid_fields, &{&1, "is not valid for the specified event"})

    conn
    |> put_status(:bad_request)
    |> put_view(ScorerApiWeb.ErrorView)
    |> render("error.json", errors: errors)
  end

  def call(conn, {:error, :missing_fields, invalid_fields}) do
    errors = Enum.map(invalid_fields, &{&1, "is required for the specified event"})

    conn
    |> put_status(:bad_request)
    |> put_view(ScorerApiWeb.ErrorView)
    |> render("error.json", errors: errors)
  end
end
