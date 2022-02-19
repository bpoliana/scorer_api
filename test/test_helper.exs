ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ScorerApi.Repo, :manual)

Mox.defmock(ScorerWorkerMock, for: ScorerApi.Workers.UsersWorker)
Application.put_env(:api, :scorer_server, ScorerWorkerMock)
