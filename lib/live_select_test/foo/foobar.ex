defmodule LiveSelectTest.Foo.Foobar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "foobars" do
    field :name, :string
    field :other_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(foobar, attrs) do
    foobar
    |> cast(attrs, [:name, :other_id])
    |> validate_required([:name, :other_id])
  end
end
