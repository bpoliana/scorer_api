# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ScorerApi.Repo.insert!(%ScorerApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ScorerApi.{Repo, Users.User}

users =
  Enum.map(1..1_000_000, fn _ ->
    date_time = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    %{points: 0, inserted_at: date_time, updated_at: date_time}
  end)

list_of_chunks = Enum.chunk_every(users, 21_600)

Enum.each(list_of_chunks, fn chunk ->
  Repo.insert_all(User, chunk)
end)
