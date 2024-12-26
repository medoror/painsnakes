# lib/your_app_web/live/board_live.ex
defmodule PainsnakesWeb.BoardLive do
  use PainsnakesWeb, :live_view

  alias Painsnakes
  alias Painsnakes.Painpoints

  def mount(params, _session, socket) do
    painsnake_id = params["painsnake_id"]
    painpoint_id = params["painpoint_id"]

    selected_painsnake =
      if painsnake_id do
        get_painsnake_by_id(painsnake_id)
      else
        nil
      end

    selected_painpoint =
      if painpoint_id do
        get_painpoint_by_id(painpoint_id)
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
        |> assign(:selected_painpoint, selected_painpoint)

      {:ok, socket}
    else
      {:ok,
       assign(socket,
         selected_painsnake: selected_painsnake,
         selected_painpoint: selected_painpoint
       )}
    end
  end

  def handle_event("update_painsnake", %{"id" => id, "category_name" => category_name}, socket) do
    case Painpoints.update_painsnake(id, %{category_name: category_name}) do
      {:ok, _painsnake} ->
        {:noreply, socket}

      {:error, _reason} ->
        {:noreply, put_flash(socket, :error, "Failed to update painsnake")}
    end
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

  def handle_event("reset_path", _params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/")}
  end

  defp get_painsnake_by_id(painsnake_id) do
    # Implement your logic to fetch the painsnake by ID
    Painpoints.get_painsnake!(painsnake_id)
  end

  defp get_painpoint_by_id(painpoint_id) do
    # Implement your logic to fetch the painpoint by ID
    Painpoints.get_painpoint!(painpoint_id)
  end
end
