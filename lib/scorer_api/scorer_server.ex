defmodule ScorerApi.ScorerServer do
  @moduledoc """
    The module ScorerServer uses GenServer and implements its the callbacks
    that retrieves two users with at least the max_number of the server and timestamp
  """

  use GenServer

  require Logger

  alias ScorerApi.Users

  @timeout 15_000

  # Client

  def via_tuple(name), do: {:via, Registry, {Registry.ScorerServer, name}}

  def start_link(name),
    do: GenServer.start_link(__MODULE__, name, name: via_tuple(name))

  @impl true
  def init(_name) do
    state = %{max_number: Enum.random(0..100), timestamp: nil}
    {:ok, state, @timeout}
  end

  # Server (callbacks)

  def get_users(server, name) when is_binary(name),
    do: GenServer.call(server, {:get_users, name})

  @impl true
  def handle_call({:get_users, name}, _from, state_data) do
    {:ok, users} = Users.list_by_punctuation(state_data.max_number, 2)

    # credo:disable-for-next-line
    IO.inspect(users)

    state_data
    |> update_timestamp()
    |> log_info(:get_users, name)
    |> reply_success(:ok, %{users: users})
  end

  @impl true
  def handle_info(:update, state_data) do
    Logger.info("Starting update...")
    new_max_number = Enum.random(0..100)

    Logger.info("handle_info/2, matching on :update with:
                  max_number: #{new_max_number}, timestamp: #{state_data.timestamp}")

    Logger.info("Updating all users...")
    Users.update_all()

    schedule_work()

    {:noreply, %{max_number: new_max_number, timestamp: state_data.timestamp}}
  end

  @impl true
  def handle_info(:timeout, state_data) do
    Logger.info("Terminating with :timeout")

    {:noreply, state_data}
  end

  defp update_timestamp(state_data) do
    current_timestamp =
      NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()

    %{state_data | timestamp: current_timestamp}
  end

  defp reply_success(state_data, reply, %{users: users}),
    do: {:reply, reply, %{users: users, timestamp: state_data.timestamp}, @timeout}

  defp log_info(state_data, message, name) do
    Logger.info("Updated timestamp: #{state_data.timestamp}")
    Logger.info("handle_call/4 called by #{name} matching on :#{message} with:
                  max_number: #{state_data.max_number}, timestamp: #{state_data.timestamp}")

    state_data
  end

  defp schedule_work do
    # Scheduling the work to happen every minute
    Process.send_after(self(), :update, :timer.minutes(1))
  end
end
