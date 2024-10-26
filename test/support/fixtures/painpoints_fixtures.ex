defmodule Painsnakes.PainpointsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Painsnakes.Painpoints` context.
  """

  @doc """
  Generate a painsnake.
  """
  def painsnake_fixture(attrs \\ %{}) do
    {:ok, painsnake} =
      attrs
      |> Enum.into(%{
        category_name: "some category_name"
      })
      |> Painsnakes.Painpoints.create_painsnake()

    painsnake
  end

  @doc """
  Generate a painpoint.
  """
  def painpoint_fixture(attrs \\ %{}) do
    {:ok, painpoint} =
      attrs
      |> Enum.into(%{
        creation_date: ~U[2024-10-25 19:46:00Z],
        description: "some description"
      })
      |> Painsnakes.Painpoints.create_painpoint()

    painpoint
  end
end
