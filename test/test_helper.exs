ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ScorerApi.Repo, :manual)

Mox.defmock(ScorerServerMock, for: ScorerApi.Servers.UsersServer)
Application.put_env(:api, :scorer_server, ScorerServerMock)
