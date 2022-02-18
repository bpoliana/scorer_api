defmodule ScorerApi.Servers.ScorerServer do
  @moduledoc """
    The module ScorerServer uses GenServer and implements its the callbacks
    that retrieves two users with at least the max_number of the server and timestamp.
    It uses the UsersServer behaviour definition.
  """
  @behaviour ScorerApi.Servers.UsersServer

  use GenServer

  require Logger

  alias ScorerApi.Users

  @timeout 15_000

  # Client

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: ScorerServer)

  @impl true
  def init(_) do
    Logger.info("Initializing ScorerServer...")

    schedule_work()

    state = %{max_number: Enum.random(0..100), timestamp: nil}

    {:ok, state, @timeout}
  end

  # Server (callbacks)

  @impl ScorerApi.Servers.UsersServer
  def get_users(), do: GenServer.call(ScorerServer, :get_users)

  @impl true
  def handle_call(:get_users, _from, state_data) do
    %{max_number: previous_max_number, timestamp: previous_timestamp} = state_data
    {:ok, users} = Users.list_by_punctuation(previous_max_number, 2)

    # credo:disable-for-next-line
    IO.inspect(users)

    updated_state = update_timestamp(state_data)

    Logger.info(
      "handle_call/4 matching on :get_users with:
                  Previous State: max_number: #{state_data.max_number}, timestamp: #{previous_timestamp}
                  Current State: max_number: #{state_data.max_number}, timestamp: #{state_data.timestamp}"
    )

    {:reply, %{users: users, timestamp: previous_timestamp}, updated_state, @timeout}
  end

  @impl true
  def handle_info(:update, state_data) do
    Logger.info("Starting update...")
    new_max_number = Enum.random(0..100)

    Logger.info(
      "handle_info/2, matching on :update with:
                    Current State: max_number: #{new_max_number}, timestamp: #{state_data.timestamp}"
    )

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

    Logger.info("Updated timestamp to #{current_timestamp}")
    %{state_data | timestamp: current_timestamp}
  end

  defp schedule_work do
    # Scheduling the work to happen every minute
    Process.send_after(self(), :update, :timer.minutes(1))
  end
end