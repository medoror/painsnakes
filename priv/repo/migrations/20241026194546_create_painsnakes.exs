defmodule Painsnakes.Repo.Migrations.CreatePainsnakes do
  use Ecto.Migration

  def change do
    create table(:painsnakes) do
      add :category_name, :string
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:painsnakes, [:team_id])
  end
end
