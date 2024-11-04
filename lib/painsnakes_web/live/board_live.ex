# lib/your_app_web/live/board_live.ex
defmodule PainsnakesWeb.BoardLive do
  use PainsnakesWeb, :live_view

  alias Painsnakes

  def mount(_params, _session, socket) do
    if team = socket.assigns[:current_team] do
      painsnakes = Painsnakes.list_painsnakes_for_team(team.id)

      painpoints =
        Enum.flat_map(painsnakes, fn painsnake ->
          Painsnakes.list_painpoints_for_painsnake(painsnake.id)
        end)

      socket =
        socket
        |> assign(:painsnakes, painsnakes)
        |> assign(:painpoints, painpoints)

      {:ok, socket}
    else
      {:ok, socket}
    end
  end

  # Handle adding new painsnake
  # def handle_event("create_painsnake", %{"name" => name}, socket) do
  #   case Board.create_painsnake(%{name: name}) do
  #     {:ok, painsnake} ->
  #       socket = update(socket, :painsnakes, &[painsnake | &1])
  #       {:noreply, socket}

  #     {:error, _changeset} ->
  #       {:noreply, put_flash(socket, :error, "Failed to create painsnake")}
  #   end
  # end

  # # Handle adding painpoint to a painsnake
  # def handle_event("add_painpoint", %{"painsnake_id" => id, "content" => content}, socket) do
  #   # Your painpoint creation logic
  #   {:noreply, socket}
  # end
end
