defmodule EctoTest.Repo.Migrations.CreateDweets do
  use Ecto.Migration

  def change do
    create table(:dweets) do
      add :content, :string, size: 140, null: false
      add :author, :string, size: 50, null: false
    end
  end
end
