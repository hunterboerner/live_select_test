defmodule LiveSelectTestWeb.FoobarLive.Show do
  use LiveSelectTestWeb, :live_view

  alias LiveSelectTest.Foo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:foobar, Foo.get_foobar!(id))}
  end

  defp page_title(:show), do: "Show Foobar"
  defp page_title(:edit), do: "Edit Foobar"
end
