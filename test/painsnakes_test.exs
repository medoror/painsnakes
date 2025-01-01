defmodule PainsnakesTest do
  use Painsnakes.DataCase, async: true

  alias Painsnakes

  import Painsnakes.PainpointsFixtures
  import Painsnakes.AccountsFixtures

  describe "list_painsnakes_for_team/1" do
    test "returns all painsnakes for a given team" do
      team = team_fixture()
      painsnake1 = painsnake_fixture(%{team: team})
      painsnake2 = painsnake_fixture(%{team: team})

      other_team = Painsnakes.AccountsFixtures.team_fixture()
      _other_painsnake = painsnake_fixture(%{team: other_team})

      result = Painsnakes.list_painsnakes_for_team(team.id)

      assert length(result) == 2
      assert Enum.any?(result, fn p -> p.id == painsnake1.id end)
      assert Enum.any?(result, fn p -> p.id == painsnake2.id end)
    end

    test "returns painsnakes ordered by the number of painpoints" do
      team = Painsnakes.AccountsFixtures.team_fixture()

      large_painsnake = painsnake_fixture(%{team: team})
      Enum.each(1..3, fn _ -> painpoint_fixture(%{painsnake: large_painsnake}) end)

      medium_painsnake = painsnake_fixture(%{team: team})
      Enum.each(1..2, fn _ -> painpoint_fixture(%{painsnake: medium_painsnake}) end)

      small_painsnake = painsnake_fixture(%{team: team})
      painpoint_fixture(%{painsnake: small_painsnake})

      result = Painsnakes.list_painsnakes_for_team(team.id)

      assert Enum.map(result, & &1.id) == [
               large_painsnake.id,
               medium_painsnake.id,
               small_painsnake.id
             ]
    end
  end
end
