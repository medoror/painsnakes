defmodule PainsnakesWeb.BoardLiveTest do
  use PainsnakesWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Painsnakes.AccountsFixtures
  import Painsnakes.PainpointsFixtures

  describe "default board page" do
    setup %{conn: conn} do
      team = team_fixture()
      %{conn: log_in_team(conn, team), team: team}
    end

    test "retrieves painsnakes and painpoints for associated team", %{conn: conn, team: team} do
      # create two painsnakes (painsnake_one, painsnake_two) and associate with the above team
      painsnake_one = painsnake_fixture(%{team: team})
      painsnake_two = painsnake_fixture(%{team: team})
      # create two painpoints for each painsnake
      painpoint_one_for_painsnake_one = painpoint_fixture(%{painsnake: painsnake_one})
      painpoint_two_for_painsnake_one = painpoint_fixture(%{painsnake: painsnake_one})

      painpoint_one_for_painsnake_two = painpoint_fixture(%{painsnake: painsnake_two})
      painpoint_two_for_painsnake_two = painpoint_fixture(%{painsnake: painsnake_two})

      # Perform the action you want to test
      {:ok, _, html} = live(conn, ~p"/")

      [painsnake_one, painsnake_two]
      |> Enum.each(fn painsnake ->
        assert html =~ painsnake.category_name
      end)

      [
        painpoint_one_for_painsnake_one,
        painpoint_two_for_painsnake_one,
        painpoint_one_for_painsnake_two,
        painpoint_two_for_painsnake_two
      ]
      |> Enum.each(fn painpoint ->
        assert html =~ painpoint.description
      end)
    end
  end
end
