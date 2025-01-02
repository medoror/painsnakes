defmodule PainsnakesWeb.EditPainpointForm do
  alias Painsnakes.Painpoints
  use PainsnakesWeb, :live_component

  @impl true
  def mount(socket) do
    selected_painpoint = socket.assigns[:selected_painpoint] || %{}
    description = Map.get(selected_painpoint, :description, "")
    selected_painpoint = Map.put(selected_painpoint, :description, description)
    {:ok, assign(socket, selected_painpoint: selected_painpoint)}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <form phx-submit="update_painpoint" class="w-full" phx-target={@myself}>
      <div class="mt-2">
        <div class="mt-1 relative rounded-md shadow-sm">
          <input
            class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 transition duration-150 ease-in-out sm:text-sm sm:leading-5"
            id="painpoint_description"
            type="text"
            name="painpoint_description"
            placeholder="Edit the painpoint description"
            value={@selected_painpoint.description}
            required
          />
        </div>
      </div>
      <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
        <span class="flex w-full rounded-md shadow-sm sm:ml-3 sm:w-auto">
          <.button
            type="submit"
            phx-disable-with="Saving..."
            class="inline-flex justify-center rounded-md border border-transparent px-4 py-2 bg-blue-600 text-base leading-6 font-medium text-white shadow-sm hover:bg-blue-500 focus:outline-none focus:border-blue-700 focus:shadow-outline-blue transition ease-in-out duration-150 sm:text-sm sm:leading-5"
          >
            Save Changes
          </.button>
        </span>
      </div>
    </form>
    """
  end

  @impl true
  def handle_event("update_painpoint", %{"painpoint_description" => description}, socket) do
    selected_painpoint = socket.assigns.selected_painpoint

    case update_painpoint(selected_painpoint, description) do
      {:ok, updated_painpoint} ->
        {:noreply,
         socket
         |> put_flash(:info, "Painpoint updated successfully.")
         |> assign(:selected_painpoint, updated_painpoint)
         |> push_navigate(to: ~p"/")}

      {:error, changeset} ->
        {:noreply,
         socket
         |> put_flash(:error, "Failed to update painpoint.")
         |> assign(:changeset, changeset)
         |> push_navigate(to: ~p"/")}
    end
  end

  defp update_painpoint(painpoint, description) do
    creation_date = DateTime.utc_now()

    Painpoints.update_painpoint(painpoint, %{
      description: description,
      creation_date: creation_date
    })
  end
end
