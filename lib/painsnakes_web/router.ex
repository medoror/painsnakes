defmodule PainsnakesWeb.Router do
  use PainsnakesWeb, :router

  import PainsnakesWeb.TeamAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PainsnakesWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_team
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", PainsnakesWeb do
  #   pipe_through :browser
  #   live "/", BoardLive, :index
  # end

  # Other scopes may use custom stacks.
  # scope "/api", PainsnakesWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:painsnakes, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PainsnakesWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", PainsnakesWeb do
    pipe_through [:browser, :redirect_if_team_is_authenticated]

    live_session :redirect_if_team_is_authenticated,
      on_mount: [
        {PainsnakesWeb.TeamAuth, :redirect_if_team_is_authenticated},
        {PainsnakesWeb.CurrentPath, :get_current_path}
      ] do
      live "/teams/register", TeamRegistrationLive, :new
      live "/teams/log_in", TeamLoginLive, :new
      live "/teams/reset_password", TeamForgotPasswordLive, :new
      live "/teams/reset_password/:token", TeamResetPasswordLive, :edit
    end

    post "/teams/log_in", TeamSessionController, :create
  end

  scope "/", PainsnakesWeb do
    pipe_through [:browser, :require_authenticated_team]

    live_session :require_authenticated_team,
      on_mount: [
        {PainsnakesWeb.TeamAuth, :ensure_authenticated},
        {PainsnakesWeb.CurrentPath, :get_current_path}
      ] do
      live "/", BoardLive, :index
      live "/teams/settings", TeamSettingsLive, :edit
      live "/teams/settings/confirm_email/:token", TeamSettingsLive, :confirm_email
      live "/teams/add_painsnake", BoardLive, :add_painsnake
      live "/teams/add_painpoint", BoardLive, :add_painpoint
      live "/teams/edit_painpoint", BoardLive, :edit_painpoint
    end
  end

  scope "/", PainsnakesWeb do
    pipe_through [:browser]

    delete "/teams/log_out", TeamSessionController, :delete

    live_session :current_team,
      on_mount: [
        {PainsnakesWeb.TeamAuth, :mount_current_team},
        {PainsnakesWeb.CurrentPath, :get_current_path}
      ] do
      live "/teams/confirm/:token", TeamConfirmationLive, :edit
      live "/teams/confirm", TeamConfirmationInstructionsLive, :new
    end
  end
end
