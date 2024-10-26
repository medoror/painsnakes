defmodule Painsnakes.Repo.Migrations.AddTeamNameToTeams do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :team_name, :string, null: false
    end

    create unique_index(:teams, [:team_name])
  end
end
