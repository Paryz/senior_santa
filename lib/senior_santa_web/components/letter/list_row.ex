defmodule SeniorSantaWeb.Components.Letter.ListRow do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <tr phx-click="select" phx-value-letter_id={@letter.id} class={selected_row(assigns)}>
      <td class="px-6 py-4 whitespace-nowrap">
        <div class="flex items-center">
          <div class="ml-4">
            <div class="text-lg font-medium text-gray-900">
              <%= @letter.author %>
            </div>
          </div>
        </div>
      </td>
      <td class="px-6 py-4 whitespace-nowrap">
        <span class={button_color(assigns)}>
          <%= @letter.status %>
        </span>
      </td>
    </tr>
    """
  end

  defp selected_row(%{letter: %{id: id}, letter_id: letter_id}) do
    selected_row = if id == letter_id, do: "bg-yellow-50", else: ""
    "cursor-pointer hover:bg-gray-50 #{selected_row}"
  end

  defp button_color(%{letter: %{status: status}}) do
    button_color =
      case status == :zarezerwowany do
        true -> "bg-red-100 text-red-800"
        false -> "bg-green-100 text-green-800"
      end

    "px-2 inline-flex text-xs leading-5 font-semibold rounded-full #{button_color}"
  end
end
