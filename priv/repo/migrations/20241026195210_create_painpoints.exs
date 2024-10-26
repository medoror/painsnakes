defmodule Painsnakes.Repo.Migrations.CreatePainpoints do
  use Ecto.Migration

  def change do
    create table(:painpoints) do
      add :description, :text
      add :creation_date, :utc_datetime
      add :painsnake_id, references(:painsnakes, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:painpoints, [:painsnake_id])
  end
end
