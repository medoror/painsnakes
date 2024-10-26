defmodule PainsnakesWeb.TeamLoginLiveTest do
  use PainsnakesWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Painsnakes.AccountsFixtures

  describe "Log in page" do
    test "renders log in page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/teams/log_in")

      assert html =~ "Log in"
      assert html =~ "Register"
      assert html =~ "Forgot your password?"
    end

    test "redirects if already logged in", %{conn: conn} do
      result =
        conn
        |> log_in_team(team_fixture())
        |> live(~p"/teams/log_in")
        |> follow_redirect(conn, "/")

      assert {:ok, _conn} = result
    end
  end

  describe "team login" do
    test "redirects if team login with valid credentials", %{conn: conn} do
      password = "123456789abcd"
      team = team_fixture(%{password: password})

      {:ok, lv, _html} = live(conn, ~p"/teams/log_in")

      form =
        form(lv, "#login_form", team: %{team_name: team.team_name, email: team.email, password: password, remember_me: true})

      conn = submit_form(form, conn)

      assert redirected_to(conn) == ~p"/"
    end

    test "redirects to login page with a flash error if there are no valid credentials", %{
      conn: conn
    } do
      {:ok, lv, _html} = live(conn, ~p"/teams/log_in")

      form =
        form(lv, "#login_form",
          team: %{team_name: "Some team name", email: "test@email.com", password: "123456", remember_me: true}
        )

      conn = submit_form(form, conn)

      assert Phoenix.Flash.get(conn.assigns.flash, :error) == "Invalid name or password"

      assert redirected_to(conn) == "/teams/log_in"
    end
  end

  describe "login navigation" do
    test "redirects to registration page when the Register button is clicked", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/teams/log_in")

      {:ok, _login_live, login_html} =
        lv
        |> element(~s|main a:fl-contains("Sign up")|)
        |> render_click()
        |> follow_redirect(conn, ~p"/teams/register")

      assert login_html =~ "Register"
    end

    test "redirects to forgot password page when the Forgot Password button is clicked", %{
      conn: conn
    } do
      {:ok, lv, _html} = live(conn, ~p"/teams/log_in")

      {:ok, conn} =
        lv
        |> element(~s|main a:fl-contains("Forgot your password?")|)
        |> render_click()
        |> follow_redirect(conn, ~p"/teams/reset_password")

      assert conn.resp_body =~ "Forgot your password?"
    end
  end
end
