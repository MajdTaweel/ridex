defmodule RidexWeb.LoginLive do
  use RidexWeb, :live_view

  alias Ridex.User

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("login", %{"type" => type}, socket) do
    {:ok, user} = User.get_or_create(socket.assigns.phone, type)

    socket =
      socket
      |> assign(user: user)
      |> push_navigate(to: "/map")

    {:noreply, socket}
  end

  def handle_event("changed", %{"phone" => phone}, socket) do
    socket = assign(socket, phone: phone)
    {:noreply, socket}
  end
end
