defmodule SeniorSanta.Factory do
  use ExMachina.Ecto, repo: SeniorSanta.Repo

  alias SeniorSanta.Reservations.IO.Schemas.Letter

  def letter_factory() do
    %Letter{
      location: "Warszawa",
      content: "content",
      author: "Helena",
      status: "aktywny"
    }
  end
end
