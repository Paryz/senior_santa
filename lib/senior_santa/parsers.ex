defmodule SeniorSanta.Parsers do
  alias FE.Result

  @valid_genders [:male, :female, :other]
  def gender_parser() do
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

  @valid_statuses [:zarezerwowany, :aktywny]
  def status_parser() do
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
