defmodule SeniorSanta.Reservations.Models.User do
  defstruct [:id, :name, :email, :city, :phone, :date_of_birth, :gender]

  alias SeniorSanta.Validators

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          email: String.t(),
          city: String.t(),
          phone: String.t(),
          gender: atom(),
          date_of_birth: DateTime.t()
        }

  @spec new(map()) :: Result.t(__MODULE__.t())
  def new(input) do
    Data.Constructor.struct(
      [
        {:id, Data.Parser.BuiltIn.string()},
        {:name, Data.Parser.BuiltIn.string()},
        {:email, Data.Parser.predicate(&Validators.email_valid?/1)},
        {:city, Data.Parser.BuiltIn.string()},
        {:phone, Data.Parser.predicate(&Validators.polish_phone_number_valid?/1)},
        {:date_of_birth, Data.Parser.BuiltIn.datetime()},
        {:gender, SeniorSanta.Parsers.gender_parser()}
      ],
      __MODULE__,
      input
    )
  end
end
