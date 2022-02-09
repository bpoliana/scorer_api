defmodule ScorerApi.ScorerServer do
  use GenServer

  alias ScorerApi.Users

  def via_tuple(name), do: {:via, Registry, {Registry.ScorerServer, name}}

  def start_link(name) when is_binary(name),
    do: GenServer.start_link(__MODULE__, name, name: via_tuple(name))

  def init(_name) do
    state = %{max_number: 80, timestamp: nil}
    {:ok, state}
  end

  def get_users(server, name) when is_binary(name),
    do: GenServer.call(server, {:get_users, name})

  def handle_call({:get_users, name}, _from, state_data) do
    IO.inspect(Users.list_by_punctuation(state_data.max_number, 2))
    # TO-DO create a get_users method that returns the right pattern matching
    with {:ok, users} <- Users.list_by_punctuation(state_data.max_number, 2) do
      state_data
      |> update_timestamps()
      |> reply_success(:ok, users)
    else
      :error -> {:reply, :error, state_data}
    end
  end

  defp save_last_timestamps(state_data) do
    %{max_number: max_number, timestamp: old_timestamp} = state_data
  end

  defp update_timestamps(state_data) do
    %{
      max_number: state_data.max_number,
      timestamp:
        NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()
    }
  end

  defp reply_success(state_data, reply, users), do: {:reply, reply, users}
end
