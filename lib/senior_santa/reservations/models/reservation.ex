defmodule SeniorSanta.Reservations.Models.Reservation do
  defstruct [:id, :user_id, :letter_id]

  alias FE.Maybe

  alias Data.Parser

  alias SeniorSanta.Validators

  @type t :: %__MODULE__{
          id: Maybe.t(String.t()),
          user_id: String.t(),
          letter_id: String.t()
        }

  @spec new(map()) :: Result.t(__MODULE__.t())
  def new(input) do
    Data.Constructor.struct(
      [
        {:id, Parser.BuiltIn.string(), optional: true},
        {:letter_id, Parser.predicate(&Validators.uuid_valid?/1)},
        {:user_id, Parser.predicate(&Validators.uuid_valid?/1)}
      ],
      __MODULE__,
      input
    )
  end
end
