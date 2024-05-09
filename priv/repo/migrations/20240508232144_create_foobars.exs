defmodule LiveSelectTest.Repo.Migrations.CreateFoobars do
  use Ecto.Migration

  def change do
    create table(:foobars) do
      add :name, :string
      add :other_id, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
