defmodule SeniorSanta.Factory do
  use ExMachina.Ecto, repo: SeniorSanta.Repo

  alias SeniorSanta.Reservations.IO.Schemas.Letter

  def letter_factory() do
    %Letter{
      id: Ecto.UUID.generate(),
      location: "Warszawa",
      content: "filename.jpeg",
      author: "Helena",
      status: :aktywny
    }
  end
end
