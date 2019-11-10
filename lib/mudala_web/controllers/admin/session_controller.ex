defmodule MudalaWeb.Admin.SessionController do
  use MudalaWeb, :controller
  plug :set_layout
  alias Mudala.Administration

  def new(conn, _params) do
    conn
    |> render("new.html")
  end

  def create(conn, %{"token" => token}) do
    case verify_token(token) do
      {:ok, user_id} ->
        user = Administration.get_user!(user_id)

        conn
        |> assign(:current_admin, user)
        |> put_session(:admin_id, user.id)
        |> put_flash(:info, "Successfully logged in!")
        |> redirect(to: Routes.admin_user_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Authentication error")
        |> render(:new)
    end
  end

  def send_link(
        conn,
        %{
          "session" => %{
            "email" => email
          }
        }
      ) do
    user = Administration.get_admin_by_email(email)

    conn =
      case user do
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

  def delete(conn, _) do
    clear_session(conn)
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: Routes.admin_session_path(conn, :new))
  end

  defp set_layout(conn, _) do
    conn
    |> put_layout("admin_login.html")
  end

  defp generate_login_link(conn, user) do
    token = Phoenix.Token.sign(MudalaWeb.Endpoint, "user", user.id)
    Routes.admin_session_url(conn, :create, %{token: token})
  end

  @max_age 600
  defp verify_token(token) do
    Phoenix.Token.verify(MudalaWeb.Endpoint, "user", token, max_age: @max_age)
  end
end
