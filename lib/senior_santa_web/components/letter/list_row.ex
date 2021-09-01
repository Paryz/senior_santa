defmodule SeniorSantaWeb.Components.Letter.ListRow do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <tr phx-click="select" phx-value-letter_id={@letter.id} class={selected_row(assigns)}>
      <td class="px-6 py-4 whitespace-nowrap">
        <div class="flex justify-center">
          <div>
            <div class="text-lg font-medium text-gray-900">
              <%= @letter.author %>
            </div>
          </div>
        </div>
      </td>
      <td class="px-6 py-4 whitespace-nowrap">
        <span class="px-2 flex justify-center text-xs leading-5 font-semibold rounded-full">
          <div>
            <div class="text-lg font-medium text-gray-900">
              <%= time_left(assigns) %>
            </div>
          </div>
        </span>
      </td>
      <td class="px-6 py-4 whitespace-nowrap">
        <span class="px-2 flex justify-center text-xs leading-5 font-semibold rounded-full">
          <div>
            <div class={button_color(assigns)}>
              <%= status(assigns) %>
            </div>
          </div>
        </span>
      </td>
    </tr>
    """
  end

  defp time_left(%{letter_blocker: blocker, letter: %{id: id}}) do
    case Map.get(blocker, id) do
      nil -> ""
      %{time_left: count} -> count
    end
  end

  defp selected_row(%{letter: %{id: id}, letter_id: letter_id}) do
    selected_row = if id == letter_id, do: "bg-yellow-50", else: ""
    "cursor-pointer hover:bg-gray-50 #{selected_row}"
  end

  defp button_color(%{letter_blocker: blocker, letter: %{id: id}}) do
    button_color =
      case Map.get(blocker, id) do
        nil -> "bg-green-100 text-green-800"
        _count -> "bg-red-100 text-red-800"
      end

    "px-2 flex justify-center text-xs leading-5 font-semibold rounded-full #{button_color}"
  end

  defp status(%{letter_blocker: blocker, letter: %{id: id}}) do
    case Map.get(blocker, id) do
      nil -> "aktywny"
      _count -> "zablokowany"
    end
  end
end
