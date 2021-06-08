defmodule SeniorSanta.LetterUploader do
  use Waffle.Definition

  use Waffle.Ecto.Definition

  @versions [:original]
  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  # Whitelist file extensions:
  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname() |> String.downcase()
    Enum.member?(@extension_whitelist, file_extension)
  end

  # Override the storage directory:
  def storage_dir(_version, {_file, scope}) do
    "uploads/letters/#{scope.id}"
  end
end
