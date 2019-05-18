defmodule Futibas.Clubs.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :external_id, :integer
    field :name, :string
    field :overall, :integer
    field :positions, {:array, :string}

    timestamps()
  end

  @required_fields ~w(name overall external_id)a
  @optional_fields ~w(positions)a

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
