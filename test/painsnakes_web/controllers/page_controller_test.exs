defmodule PainsnakesWeb.PageControllerTest do
  use PainsnakesWeb.ConnCase

  import Painsnakes.AccountsFixtures

  test "GET /", %{conn: conn} do
    conn = log_in_team(conn, team_fixture())
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Painsnakes"
  end
end
