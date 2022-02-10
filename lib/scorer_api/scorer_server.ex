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
    with {:ok, users} <- Users.list_by_punctuation(state_data.max_number, 2) do
      state_data
      |> update_timestamp()
      |> reply_success(:ok, %{users: users})
      |> IO.inspect()
    else
      :error -> {:reply, :error, state_data}
    end
  end

  defp update_timestamp(state_data) do
    current_timestamp =
      NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()

    IO.inspect(%{state_data | timestamp: current_timestamp})
  end

  defp reply_success(state_data, reply, %{users: users}),
    do: {:reply, reply, %{users: users, timestamp: state_data.timestamp}}
end
