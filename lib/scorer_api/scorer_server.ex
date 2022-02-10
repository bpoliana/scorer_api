defmodule ScorerApi.ScorerServer do
  use GenServer

  alias ScorerApi.Users

  # Client

  def via_tuple(name), do: {:via, Registry, {Registry.ScorerServer, name}}

  def start_link(name) when is_binary(name),
    do: GenServer.start_link(__MODULE__, name, name: via_tuple(name))

  def init(_name) do
    state = %{max_number: 80, timestamp: nil}
    {:ok, state}
  end

  # Server (callbacks)

  def get_users(server, name) when is_binary(name),
    do: GenServer.call(server, {:get_users, name})

  @impl true
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

  @impl true
  def handle_info(:update, state_data) do
    IO.puts("this message has been handled by handle_info/2, matching on :update")
    new_max_number = Enum.random(0..100)
    Users.update_all()

    schedule_work()

    {:noreply, %{max_number: new_max_number, timestamp: state_data.timestamp}}
  end

  defp update_timestamp(state_data) do
    current_timestamp =
      NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()

    %{state_data | timestamp: current_timestamp}
  end

  defp reply_success(state_data, reply, %{users: users}),
    do: {:reply, reply, %{users: users, timestamp: state_data.timestamp}}

  defp schedule_work do
    # Scheduling the work to happen every minute
    Process.send_after(self(), :update, :timer.minutes(1))
  end
end
