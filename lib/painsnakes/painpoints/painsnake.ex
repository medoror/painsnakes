defmodule Painsnakes.Painpoints.Painsnake do
  use Ecto.Schema
  import Ecto.Changeset

  schema "painsnakes" do
    field :category_name, :string
    field :team_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(painsnake, attrs) do
    painsnake
    |> cast(attrs, [:category_name])
    |> validate_required([:category_name])
  end
end