defmodule Painsnakes.Painpoints.Painpoint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "painpoints" do
    field :description, :string
    field :creation_date, :utc_datetime
    field :painsnake_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(painpoint, attrs) do
    painpoint
    |> cast(attrs, [:painsnake_id, :description, :creation_date])
    |> validate_required([:painsnake_id, :description, :creation_date])
  end
end
