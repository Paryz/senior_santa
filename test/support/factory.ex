defmodule SeniorSanta.Factory do
  use ExMachina.Ecto, repo: SeniorSanta.Repo

  alias SeniorSanta.Reservations.IO.Schemas.{Letter, Reservation, User}

  def letter_factory() do
    %Letter{
      id: Ecto.UUID.generate(),
      location: "Warszawa",
      content: "filename.jpeg",
      author: "Helena",
      status: :aktywny
    }
  end

  def user_factory() do
    %User{
      name: "John Doe",
      email: "john@doe.com",
      city: "Kielce",
      phone: "+48555444333",
      date_of_birth: "1989-07-08",
      gender: :male
    }
  end

  def reservation_factory() do
    %Reservation{
      user_id: Ecto.UUID.generate(),
      letter_id: Ecto.UUID.generate()
    }
  end
end
