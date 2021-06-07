defmodule SeniorSanta.Reservations.Models.Letter do
  defstruct [:id, :author, :content, :currently_watching, :location, :status]

  @type t :: %__MODULE__{
          id: integer(),
          author: String.t(),
          content: String.t(),
          currently_watching: integer(),
          location: String.t(),
          status: String.t()
        }

  def new(input) do
    Data.Constructor.struct(
      [
        {:id, Data.Parser.BuiltIn.integer()},
        {:author, Data.Parser.BuiltIn.string()},
        {:content, Data.Parser.BuiltIn.string()},
        {:location, Data.Parser.BuiltIn.string()},
        {:status, Data.Parser.BuiltIn.string()}
        # {:currently_watching, Data.Parser.BuiltIn.integer()}
      ],
      __MODULE__,
      input
    )
  end
end
