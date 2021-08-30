defmodule SeniorSantaWeb.Components.Letter.List do
  use SeniorSantaWeb, :live_component
  alias SeniorSantaWeb.Components.Letter.ListRow

  @impl true
  def render(assigns) do
    ~L"""
    <div class="sm:w-2/3 lg:w-1/2 -my-2 overflow-x-auto">
      <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
        <div class="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
          <table class="min-w-full divide-y divide-gray-200 -mb-0">
            <thead class="bg-gray-50">
              <tr>
                <th scope="col" class="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Autor
                </th>
                  <!--
                <th scope="col" class="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Liczba obserwująych
                </th>
                  -->
                <th scope="col" class="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Status
                </th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <%= for letter <- @letters do %>
                <%= live_component ListRow, letter: letter, letter_id: @letter.id %>
              <% end %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    """
  end
end
