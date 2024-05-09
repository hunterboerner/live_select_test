defmodule LiveSelectTestWeb.FoobarLive.Index do
  use LiveSelectTestWeb, :live_view

  alias LiveSelectTest.Foo
  alias LiveSelectTest.Foo.Foobar

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :foobars, Foo.list_foobars())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Foobar")
    |> assign(:foobar, Foo.get_foobar!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Foobar")
    |> assign(:foobar, %Foobar{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Foobars")
    |> assign(:foobar, nil)
  end

  @impl true
  def handle_info({LiveSelectTestWeb.FoobarLive.FormComponent, {:saved, foobar}}, socket) do
    {:noreply, stream_insert(socket, :foobars, foobar)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    foobar = Foo.get_foobar!(id)
    {:ok, _} = Foo.delete_foobar(foobar)

    {:noreply, stream_delete(socket, :foobars, foobar)}
  end
end
