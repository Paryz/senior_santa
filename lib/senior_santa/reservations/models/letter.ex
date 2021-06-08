defmodule SeniorSanta.Reservations.Models.Letter do
  defstruct [:id, :author, :content, :currently_watching, :location, :status]

  @type t :: %__MODULE__{
          id: String.t(),
          author: String.t(),
          content: String.t(),
          currently_watching: integer(),
          location: String.t(),
          status: String.t()
        }

  @spec new(map()) :: Result.t(__MODULE__.t())
  def new(input) do
    Data.Constructor.struct(
      [
        {:id, Data.Parser.BuiltIn.string()},
        {:author, Data.Parser.BuiltIn.string()},
        {:content, Data.Parser.BuiltIn.string()},
        {:location, Data.Parser.BuiltIn.string()},
        {:status, Data.Parser.BuiltIn.atom()}
        # {:currently_watching, Data.Parser.BuiltIn.integer()}
      ],
      __MODULE__,
      input
    )
    |> FE.Result.map(fn struct ->
      content_url = SeniorSanta.LetterUploader.url({struct.content, struct})
      Map.put(struct, :content, content_url)
    end)
  end
end
