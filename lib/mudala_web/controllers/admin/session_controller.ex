defmodule MudalaWeb.Admin.SessionController do
  use MudalaWeb, :controller
  plug :set_layout
  alias Mudala.Administration

  def new(conn, _params) do
    conn
    |> render("new.html")
  end

  def send_link(conn, %{"session" => %{"email" => email}}) do
    user = Administration.get_admin_by_email(email)
    conn = case user do
      nil ->
        conn
        |> put_flash(:error, "Authentication error")
      user ->
          link = generate_login_link(conn, user)
          conn
            |> put_flash(:info, "Your magic login link is #{link}")
    end
    conn
    |> render("new.html")
  end
  defp set_layout(conn, _) do
      conn
      |> put_layout("admin_login.html")
  end

  defp generate_login_link(conn, user) do
      token = Phoenix.Token.sign(MudalaWeb.Endpoint, "user", user.id)
      Routes.admin_session_url(conn, :create, %{token: token})
  end
end