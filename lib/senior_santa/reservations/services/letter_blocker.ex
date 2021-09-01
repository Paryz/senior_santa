defmodule SeniorSanta.Reservations.Services.LetterBlocker do
  use GenServer

  alias SeniorSantaWeb.LetterLive
  @max_timer 45

  ########
  # Client 
  ########

  def start_link(_default) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def get_state() do
    GenServer.call(__MODULE__, :get_state)
  end

  def block(letter_id, socket_id) do
    GenServer.cast(__MODULE__, {:start_timer, letter_id, socket_id})
  end

  def unblock(letter_id, socket_id) do
    GenServer.cast(__MODULE__, {:stop_timer, letter_id, socket_id})
  end

  def is_letter_blocked?(letter_blocker, letter_id) do
    case Map.get(letter_blocker, letter_id) do
      nil -> false
      _ -> true
    end
  end

  def blocked_by_me?(letter_blocker, letter_id, socket_id) do
    case Map.get(letter_blocker, letter_id) do
      %{owner: ^socket_id} -> true
      _ -> false
    end
  end

  def unblock_all_user_timers(socket_id) do
    GenServer.cast(__MODULE__, {:unblock_all_user_timers, socket_id})
  end

  ########
  # Server 
  ########

  def init(state), do: {:ok, state}

  def handle_cast({:start_timer, letter_id, socket_id}, state) do
    case Map.get(state, letter_id) do
      nil -> decrement(state, letter_id, %{owner: socket_id, time_left: @max_timer})
      _remaining_time -> {:noreply, state}
    end
  end

  def handle_cast({:stop_timer, letter_id, socket_id}, state) do
    if blocked_by_me?(state, letter_id, socket_id) do
      state
      |> Map.delete(letter_id)
      |> then(&{:noreply, &1})
    else
      {:noreply, state}
    end
  end

  def handle_cast({:unblock_all_user_timers, socket_id}, state) do
    state
    |> Enum.filter(fn {_k, %{owner: owner}} -> owner == socket_id end)
    |> Enum.reduce(state, fn {k, _v}, acc -> Map.delete(acc, k) end)
    |> tap(&broadcast_state(&1))
    |> then(&{:noreply, &1})
  end

  def handle_info({:decrement, letter_id}, state) do
    case Map.get(state, letter_id) do
      nil ->
        {:noreply, state}

      %{time_left: 0} ->
        remove(state, letter_id)

      letter_state ->
        decrement(state, letter_id, %{letter_state | time_left: letter_state.time_left - 1})
    end
  end

  # So that unhanded messages don't error
  def handle_info(_, state) do
    {:ok, state}
  end

  def handle_call(:get_state, _from, state), do: {:reply, state, state}

  defp remove(state, id) do
    state
    |> Map.delete(id)
    |> tap(&broadcast_state(&1, :deleted))
    |> then(&{:noreply, &1})
  end

  defp decrement(state, letter_id, new_letter_state) do
    Process.send_after(self(), {:decrement, letter_id}, 1_000)

    state
    |> Map.put(letter_id, new_letter_state)
    |> tap(&broadcast_state/1)
    |> then(&{:noreply, &1})
  end

  defp broadcast_state(state, action \\ :updated) do
    Phoenix.PubSub.broadcast(
      SeniorSanta.PubSub,
      LetterLive.Index.topic(),
      {LetterLive.Index, [:letter_blocker, action], state}
    )
  end
end
