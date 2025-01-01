defmodule Painsnakes.PainpointsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Painsnakes.Painpoints` context.
  """

  @doc """
  Generate a painsnake.
  """
  def painsnake_fixture(attrs \\ %{}) do
    team = Map.get(attrs, :team) || Painsnakes.AccountsFixtures.team_fixture()
    category_name = Map.get(attrs, :category_name, "some category_name")

    {:ok, painsnake} =
      attrs
      |> Map.put(:team_id, team.id)
      |> Map.put(:category_name, category_name)
      |> Painsnakes.Painpoints.create_painsnake()

    painsnake
  end

  @doc """
  Generate a painpoint.
  """
  def painpoint_fixture(attrs \\ %{}) do
    painsnake = Map.get(attrs, :painsnake) || Painsnakes.PainpointsFixtures.painsnake_fixture()

    {:ok, painpoint} =
      attrs
      |> Map.put(:painsnake_id, painsnake.id)
      |> Enum.into(%{
        description: "some description",
        creation_date: ~U[2024-10-25 19:46:00Z]
      })
      |> Painsnakes.Painpoints.create_painpoint()

    painpoint
  end
end
