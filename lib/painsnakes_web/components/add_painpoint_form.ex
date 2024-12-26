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

  @impl true
  def render(assigns) do
    ~H"""
    <form phx-submit="add_painpoint" class="w-full" phx-target={@myself}>
      <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left flex items-center">
        <label class="text-lg leading-6 font-medium text-gray-900 mr-2">
          Category Name:
        </label>
        <span class="text-gray-700">
          <%= if @selected_painsnake do %>
            <%= @selected_painsnake.category_name %>
          <% else %>
            No category selected
          <% end %>
        </span>
      </div>
      <div class="mt-2">
        <div class="mt-1 relative rounded-md shadow-sm">
          <input
            class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 transition duration-150 ease-in-out sm:text-sm sm:leading-5"
            id="painpoint_description"
            type="text"
            name="painpoint_description"
            placeholder="Describe the painpoint"
            required
          />
        </div>
      </div>
      <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
        <span class="flex w-full rounded-md shadow-sm sm:ml-3 sm:w-auto">
          <button
            type="submit"
            phx-disable-with="Adding..."
            class="inline-flex justify-center rounded-md border border-transparent px-4 py-2 bg-green-600 text-base leading-6 font-medium text-white shadow-sm hover:bg-green-500 focus:outline-none focus:border-green-700 focus:shadow-outline-green transition ease-in-out duration-150 sm:text-sm sm:leading-5"
          >
            Add Painpoint
          </button>
        </span>
      </div>
    </form>
    """
  end
end
