defmodule PainsnakesWeb.TeamConfirmationInstructionsLiveTest do
  use PainsnakesWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Painsnakes.AccountsFixtures

  alias Painsnakes.Accounts
  alias Painsnakes.Repo

  setup do
    %{team: team_fixture()}
  end

  describe "Resend confirmation" do
    test "renders the resend confirmation page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/teams/confirm")
      assert html =~ "Resend confirmation instructions"
    end

    test "sends a new confirmation token", %{conn: conn, team: team} do
      {:ok, lv, _html} = live(conn, ~p"/teams/confirm")

      {:ok, conn} =
        lv
        |> form("#resend_confirmation_form", team: %{email: team.email})
        |> render_submit()
        |> follow_redirect(conn, ~p"/")

      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~
               "If your email is in our system"

      assert Repo.get_by!(Accounts.TeamToken, team_id: team.id).context == "confirm"
    end

    test "does not send confirmation token if team is confirmed", %{conn: conn, team: team} do
      Repo.update!(Accounts.Team.confirm_changeset(team))

      {:ok, lv, _html} = live(conn, ~p"/teams/confirm")

      {:ok, conn} =
        lv
        |> form("#resend_confirmation_form", team: %{email: team.email})
        |> render_submit()
        |> follow_redirect(conn, ~p"/")

      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~
               "If your email is in our system"

      refute Repo.get_by(Accounts.TeamToken, team_id: team.id)
    end

    test "does not send confirmation token if email is invalid", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/teams/confirm")

      {:ok, conn} =
        lv
        |> form("#resend_confirmation_form", team: %{email: "unknown@example.com"})
        |> render_submit()
        |> follow_redirect(conn, ~p"/")

      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~
               "If your email is in our system"

      assert Repo.all(Accounts.TeamToken) == []
    end
  end
end
