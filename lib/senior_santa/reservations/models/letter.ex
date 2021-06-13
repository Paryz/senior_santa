defmodule SeniorSanta.Reservations.Models.Letter do
  defstruct [:id, :author, :content, :location, :status]

  alias FE.Result

  alias Data.Parser.BuiltIn

  @type t :: %__MODULE__{
          id: String.t(),
          author: String.t(),
          content: String.t(),
          # currently_watching: integer(),
          location: String.t(),
          status: atom()
        }

  @spec new(map()) :: Result.t(t())
  def new(input) do
    Data.Constructor.struct(
      [
        {:id, BuiltIn.string()},
        {:author, BuiltIn.string()},
        {:content, BuiltIn.string()},
        {:location, BuiltIn.string()},
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

  @spec update_status(t(), :zarezerwowany) :: Result.t(t())
  def update_status(letter, new_status) do
    letter |> Map.put(:status, new_status) |> new()
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
