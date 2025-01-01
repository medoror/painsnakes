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
      painsnake_one = painsnake_fixture(%{team: team})
      painsnake_two = painsnake_fixture(%{team: team})
      painpoint_one_for_painsnake_one = painpoint_fixture(%{painsnake: painsnake_one})
      painpoint_two_for_painsnake_one = painpoint_fixture(%{painsnake: painsnake_one})

      painpoint_one_for_painsnake_two = painpoint_fixture(%{painsnake: painsnake_two})
      painpoint_two_for_painsnake_two = painpoint_fixture(%{painsnake: painsnake_two})

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

    test "painsakes are ordered by the amount of paipoints from biggest to smallest", %{
      conn: conn,
      team: team
    } do
      small_painsnake = painsnake_fixture(%{team: team, category_name: "Small"})
      painpoint_fixture(%{painsnake: small_painsnake})

      medium_painsnake = painsnake_fixture(%{team: team, category_name: "Medium"})
      Enum.each(1..2, fn _ -> painpoint_fixture(%{painsnake: medium_painsnake}) end)

      large_painsnake = painsnake_fixture(%{team: team, category_name: "Large"})
      Enum.each(1..3, fn _ -> painpoint_fixture(%{painsnake: large_painsnake}) end)

      {:ok, _, html} = live(conn, ~p"/")

      painsnake_names = extract_painsnake_names(html) |> Enum.map(&String.trim/1)

      assert painsnake_names == [
               large_painsnake.category_name,
               medium_painsnake.category_name,
               small_painsnake.category_name
             ]
    end
  end

  defp extract_painsnake_names(html) do
    regex = ~r/<div class="painsnake">.*?<h3.*?>(.*?)<\/h3>.*?<\/div>/s
    Regex.scan(regex, html) |> Enum.map(fn [_, name] -> name end)
  end
end
