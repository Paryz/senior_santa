defmodule SeniorSantaWeb.Components.Letter.ListRow do
  use SeniorSantaWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <tr phx-click="select" phx-value-letter_id="<%= @letter.id %>" class="cursor-pointer hover:bg-gray-50 <%= if (@letter.id == @letter_id), do: "bg-yellow-50" %>">
      <td class="px-6 py-4 whitespace-nowrap">
        <div class="flex items-center">
          <div class="ml-4">
            <div class="text-lg font-medium text-gray-900">
              <%= @letter.author %>
            </div>
          </div>
        </div>
      </td>
      <!--
      <td class="px-6 py-4 whitespace-nowrap">
        <div class="text-sm text-gray-500">
          <%= 0 #letter.currently_watching %>
        </div>
      </td>
      -->
      <td class="px-6 py-4 whitespace-nowrap">
        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full <%= if (@letter.status == :zarezerwowany), do: "bg-red-100 text-red-800", else:  "bg-green-100 text-green-800" %>">
          <%= @letter.status %>
        </span>
      </td>
    </tr>
    """
  end
end
