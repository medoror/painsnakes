defmodule PainsnakesWeb.AddPainsnakeForm do
  alias Painsnakes.Painpoints
  use PainsnakesWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, assign(socket, category_name: "")}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("add_painsnake", %{"category_name" => category_name}, socket) do
    valid_attrs = %{category_name: category_name, team_id: socket.assigns.team.id}

    case Painpoints.create_painsnake(valid_attrs) do
      {:ok, _} ->
        {:noreply, push_navigate(socket, to: ~p"/")}

      {:error, _} ->
        {:noreply,
         socket
         |> put_flash(
           :error,
           "Sorry, a painsnake with the name '#{category_name}' already exists"
         )
         |> push_navigate(to: ~p"/")}
    end
  end
end
