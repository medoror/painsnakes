defmodule Painsnakes do
  @moduledoc """
  Painsnakes keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  import Ecto.Query, warn: false
  alias Painsnakes.Repo
  alias Painsnakes.Painpoints.{Painsnake, Painpoint}

  @doc """
  Lists all painsnakes for a given team.
  """
  def list_painsnakes_for_team(team_id) do
    from(p in Painsnake,
      where: p.team_id == ^team_id,
      left_join: pp in Painpoint,
      on: pp.painsnake_id == p.id,
      group_by: p.id,
      order_by: [desc: count(pp.id)],
      select: p
    )
    |> Repo.all()
  end

  @doc """
  Lists all painpoints for a given painsnake.
  """
  def list_painpoints_for_painsnake(painsnake_id) do
    from(pp in Painpoint, where: pp.painsnake_id == ^painsnake_id)
    |> Repo.all()
  end
end
