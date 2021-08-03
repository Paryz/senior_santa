defmodule SeniorSantaWeb.Components.Letter.Detail do
  use SeniorSantaWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div class="sm:w-1/3 lg:w-1/2 flex flex-col text-center items-center">
        <div class="bg-gray-100 sm:rounded-lg px-8 py-2 mb-2">
          <%= @letter.author %>
        </div>
        <div>
          <img src="<%= @letter.content %>">
        </div>
        <%= if @letter.status != :zarezerwowany do %>
          <div class="mt-6" x-data="{ open: false }">
            <button class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow" @click="open = true">Zarezerwuj</button>
            <div class="fixed z-1 w-full h-full top-0 left-0 flex items-center justify-center" x-cloak x-show="open">
              <div class="fixed w-full h-full bg-gray-500 opacity-50"></div>
              <div class="relative z-2 w-7/12 max-w-3xl bg-white p-8 mx-auto rounded-xl flex flex-col items-center" @click.away="open = false">
                <%= f = form_for @reservation, "#", [phx_submit: :save, class: "w-full max-w-lg"] %>
                  <div class="flex flex-wrap -mx-3 mb-6">
                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                      <%= hidden_input f, :letter_id, value: @letter.id %>
                      <%= label f, :name, "Imię + Nazwisko", class: "block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" %>
                      <%= text_input f, :name, class: "appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white", placeholder: "Anna Nowak" %>
                      <%= error_tag f, :name %>
                    </div>
                    <div class="w-full md:w-1/2 px-3">
                      <%= label f, :email, "Email", class: "block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" %>
                      <%= email_input f, :email, class: "appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white", placeholder: "anna.nowak@email.pl" %>
                      <%= error_tag f, :email %>
                    </div>
                  </div>
                  <div class="flex flex-wrap -mx-3 mb-6">
                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                      <%= label f, :city, "Miasto", class: "block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" %>
                      <%= text_input f, :city, class: "appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white", placeholder: "Warszawa" %>
                      <%= error_tag f, :city %>
                    </div>
                    <div class="w-full md:w-1/2 px-3">
                      <%= label f, :phone, "Telefon", class: "block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" %>
                      <%= telephone_input f, :phone, class: "appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white", placeholder: "555444333" %>
                      <%= error_tag f, :phone %>
                    </div>
                  </div>
                  <div class="flex flex-wrap -mx-3 mb-6">
                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                      <%= label f, :date_of_birth, "Data urodzenia", class: "block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" %>
                      <%= date_input f, :date_of_birth, class: "appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" %>
                      <%= error_tag f, :date_of_birth %>
                    </div>
                    <div class="w-full md:w-1/2 px-3">
                      <%= label f, :gender, "Płeć", class: "block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" %>
                      <%= select f, :gender, ["Kobieta": "female", "Mężczyzna": "male", "Inne": "other"], class: "block w-full bg-gray-200 text-gray-700 border rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" %>
                      <%= error_tag f, :gender %>
                    </div>
                  </div>
                  <div class="flex flex-wrap -mx-3 mb-6 justify-evenly">
                    <%= submit "Rezerwuj", class: "w-full md:w-1/3 bg-white hover:bg-green-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow mt-6" %>
                    <div class="w-full md:w-1/3 bg-white hover:bg-red-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow mt-6 cursor-pointer" @click="open = false">Zamknij</div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        <% end %>
      </div>

    """
  end
end
