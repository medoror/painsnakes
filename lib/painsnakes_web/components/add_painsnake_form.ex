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
    dbg(socket)
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

  @impl true
  def render(assigns) do
    ~H"""
    <form phx-submit="add_painsnake" class="w-full" phx-target={@myself}>
      <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
        <label
          for="add-painsnake-input"
          class="text-lg leading-6 font-medium text-gray-900"
          id="add-painsnake-modal-headline"
        >
          Add Painsnake
        </label>
        <div class="mt-2">
          <div class="mt-1 relative rounded-md shadow-sm">
            <input
              class={[
                "appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md placeholder-gray-400",
                "focus:outline-none focus:shadow-outline-blue focus:border-blue-300 transition duration-150 ease-in-out sm:text-sm sm:leading-5"
              ]}
              id="add-painsnake-input"
              type="text"
              name="category_name"
              value={@category_name}
              placeholder="What's this painsnake's name?"
              data-cy="add-painsnake-input"
              autocomplete="off"
            />
          </div>
        </div>
      </div>
      <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
        <span class="flex w-full rounded-md shadow-sm sm:ml-3 sm:w-auto">
          <button
            type="submit"
            phx-disable-with="Add..."
            class="inline-flex justify-center rounded-md border border-transparent px-4 py-2 bg-green-600 text-base leading-6 font-medium text-white shadow-sm hover:bg-green-500 focus:outline-none focus:border-green-700 focus:shadow-outline-green transition ease-in-out duration-150 sm:text-sm sm:leading-5"
          >
            Add
          </button>
        </span>
        <span class="flex w-full rounded-md shadow-sm sm:ml-3 sm:w-auto">
          <.link navigate={~p"/"}>
            <button class="inline-flex justify-center w-full rounded-md border border-gray-300 px-4 py-2 bg-white text-base leading-6 font-medium text-gray-700 shadow-sm hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue transition ease-in-out duration-150 sm:text-sm sm:leading-5">
              Cancel
            </button>
          </.link>
        </span>
      </div>
    </form>
    """
  end
end
