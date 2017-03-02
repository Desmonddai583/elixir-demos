defmodule EctoTest.Dweet do
  use Ecto.Schema

  schema "dweets" do
    field :content, :string
    field :author, :string
  end
end
