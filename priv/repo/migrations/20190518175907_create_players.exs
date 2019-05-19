defmodule Futibas.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string, null: false
      add :overall, :integer, null: false
      add :external_id, :integer, null: false
      add :positions, {:array, :string}

      timestamps()
    end
  end
end
