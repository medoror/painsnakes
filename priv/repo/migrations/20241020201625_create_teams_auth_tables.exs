defmodule Painsnakes.Repo.Migrations.CreateTeamsAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:teams) do
      add :email, :citext, null: false
      add :hashed_password, :string, null: false
      add :confirmed_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create unique_index(:teams, [:email])

    create table(:teams_tokens) do
      add :team_id, references(:teams, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string

      timestamps(type: :utc_datetime, updated_at: false)
    end

    create index(:teams_tokens, [:team_id])
    create unique_index(:teams_tokens, [:context, :token])
  end
end
