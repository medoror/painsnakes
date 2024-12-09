# lib/your_app_web/live/board_live.ex
defmodule PainsnakesWeb.BoardLive do
  use PainsnakesWeb, :live_view

  alias Painsnakes
  alias Painsnakes.Painpoints

  def mount(params, _session, socket) do
    painsnake_id = params["painsnake_id"]

    selected_painsnake =
      if painsnake_id do
        get_painsnake_by_id(painsnake_id)
      else
        nil
      end

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
        |> assign(:selected_painsnake, selected_painsnake)

      {:ok, socket}
    else
      {:ok, assign(socket, :selected_painsnake, selected_painsnake)}
    end
  end

  defp get_painsnake_by_id(painsnake_id) do
    # Implement your logic to fetch the painsnake by ID
    Painpoints.get_painsnake!(painsnake_id)
  end

  def handle_event("delete_painsnake", %{"id" => id}, socket) do
    painsnake = get_painsnake_by_id(id)

    case Painsnakes.Painpoints.delete_painsnake(painsnake) do
      {:ok, _painsnake} ->
        {:noreply, assign(socket, :painsnakes, Painsnakes.Painpoints.list_painsnakes())}

      {:error, _reason} ->
        {:noreply, socket}
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
