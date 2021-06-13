defmodule SeniorSanta.Reservations.Models.User do
  defstruct [:id, :name, :email, :city, :phone, :date_of_birth, :gender]

  alias FE.{Maybe, Result}

  alias Data.Parser

  alias SeniorSanta.Validators

  @type t :: %__MODULE__{
          id: Maybe.t(String.t()),
          name: String.t(),
          email: String.t(),
          city: String.t(),
          phone: String.t(),
          gender: atom(),
          date_of_birth: Date.t()
        }

  @spec new(map()) :: Result.t(t())
  def new(input) do
    Data.Constructor.struct(
      [
        {:id, Parser.BuiltIn.string(), optional: true},
        {:name, Parser.BuiltIn.string()},
        {:email, Parser.predicate(&Validators.email_valid?/1)},
        {:city, Parser.BuiltIn.string()},
        {:phone, Parser.predicate(&Validators.polish_phone_number_valid?/1)},
        {:date_of_birth, Parser.BuiltIn.date()},
        {:gender, gender_parser()}
      ],
      __MODULE__,
      input
    )
  end

  @valid_genders [:male, :female, :other]
  defp gender_parser() do
    fn
      gender when is_atom(gender) and gender in @valid_genders ->
        Result.ok(gender)

      gender when is_binary(gender) ->
        atomized_value = String.to_existing_atom(gender)

        case atomized_value in @valid_genders do
          true -> Result.ok(atomized_value)
          false -> Error.domain(:gender_is_not_valid) |> Result.error()
        end

      _ ->
        Error.domain(:gender_is_not_valid) |> Result.error()
    end
  end
end
