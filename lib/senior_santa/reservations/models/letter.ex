defmodule SeniorSanta.Reservations.Models.Letter do
  defstruct [:id, :author, :content, :currently_watching, :location, :status]

  alias FE.Result

  @type t :: %__MODULE__{
          id: String.t(),
          author: String.t(),
          content: String.t(),
          currently_watching: integer(),
          location: String.t(),
          status: atom()
        }

  @spec new(map()) :: Result.t(__MODULE__.t())
  def new(input) do
    Data.Constructor.struct(
      [
        {:id, Data.Parser.BuiltIn.string()},
        {:author, Data.Parser.BuiltIn.string()},
        {:content, Data.Parser.BuiltIn.string()},
        {:location, Data.Parser.BuiltIn.string()},
        {:status, status_parser()}
        # {:currently_watching, Data.Parser.BuiltIn.integer()}
      ],
      __MODULE__,
      input
    )
    |> Result.map(fn struct ->
      content_url = SeniorSanta.LetterUploader.url({struct.content, struct})
      Map.put(struct, :content, content_url)
    end)
  end

  @valid_statuses [:zarezerwowany, :aktywny]
  defp status_parser() do
    fn
      status when is_atom(status) and status in @valid_statuses ->
        Result.ok(status)

      status when is_binary(status) ->
        atomized_value = String.to_existing_atom(status)

        case atomized_value in @valid_statuses do
          true -> Result.ok(atomized_value)
          false -> Error.domain(:status_is_not_valid) |> Result.error()
        end

      _ ->
        Error.domain(:status_is_not_valid) |> Result.error()
    end
  end
end
