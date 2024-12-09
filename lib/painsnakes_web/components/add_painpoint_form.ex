defmodule PainsnakesWeb.AddPainpointForm do
  alias Painsnakes.Painpoints
  use PainsnakesWeb, :live_component

  @impl true
  def mount(socket) do
    selected_painsnake = socket.assigns[:selected_painsnake] || %{}
    category_name = Map.get(selected_painsnake, :category_name, "")
    selected_painsnake = Map.put(selected_painsnake, :category_name, category_name)

    {:ok,
     assign(socket,
       category_name: category_name,
       painsnake_id: nil,
       selected_painsnake: selected_painsnake
     )}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("add_painpoint", %{"painpoint_description" => description}, socket) do
    painsnake_id = socket.assigns.selected_painsnake.id
    creation_date = DateTime.utc_now()

    valid_attrs = %{
      description: description,
      painsnake_id: painsnake_id,
      creation_date: creation_date
    }

    dbg(valid_attrs)

    case Painpoints.create_painpoint(valid_attrs) do
      {:ok, _} ->
        {:noreply, push_navigate(socket, to: ~p"/")}

      {:error, changeset} ->
        error_message =
          changeset.errors
          |> Enum.map(fn {field, {message, _}} -> "#{field}: #{message}" end)
          |> Enum.join(", ")

        {:noreply,
         socket
         |> put_flash(
           :error,
           "Sorry, adding the painpont failed: #{error_message}"
         )
         |> push_navigate(to: ~p"/")}
    end
  end
end
