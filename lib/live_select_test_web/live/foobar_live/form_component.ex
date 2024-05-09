defmodule LiveSelectTestWeb.FoobarLive.FormComponent do
  use LiveSelectTestWeb, :live_component

  alias LiveSelectTest.Foo

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage foobar records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="foobar-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} label="Name" />
        <.live_select
          field={@form[:other_id]}
          label="Other"
          phx-target={@myself}
          options={@other_opts}
          value_mapper={&to_string(&1)}
        >
          <:option :let={opt}>
            <.baz label={opt.label} quo={@quox[opt.label]} />
          </:option>
        </.live_select>
        <:actions>
          <.button phx-disable-with="Saving...">Save Foobar</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def baz(assigns) do
    ~H"<%= @label %>"
  end

  @impl true
  def update(%{foobar: foobar} = assigns, socket) do
    changeset = Foo.change_foobar(foobar)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:other_opts, other_opts())
     |> assign(:quox, %{})
     |> assign_form(changeset)}
  end

  def other_opts() do
    [{"abc", "1"}, {"def", "2"}]
  end

  @impl true
  def handle_event(
        "live_select_change",
        %{"text" => text, "id" => live_select_id},
        socket
      ) do
    opts = other_opts()
    send_update(LiveSelect.Component, id: live_select_id, options: opts)
    {:noreply, assign(socket, :quox, %{text => 3})}
  end

  @impl true
  def handle_event("validate", %{"foobar" => foobar_params}, socket) do
    changeset =
      socket.assigns.foobar
      |> Foo.change_foobar(foobar_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"foobar" => foobar_params}, socket) do
    save_foobar(socket, socket.assigns.action, foobar_params)
  end

  defp save_foobar(socket, :edit, foobar_params) do
    case Foo.update_foobar(socket.assigns.foobar, foobar_params) do
      {:ok, foobar} ->
        notify_parent({:saved, foobar})

        {:noreply,
         socket
         |> put_flash(:info, "Foobar updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_foobar(socket, :new, foobar_params) do
    case Foo.create_foobar(foobar_params) do
      {:ok, foobar} ->
        notify_parent({:saved, foobar})

        {:noreply,
         socket
         |> put_flash(:info, "Foobar created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
