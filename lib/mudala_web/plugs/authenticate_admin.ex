defmodule MudalaWeb.Plugs.AuthenticateAdmin do
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]

  def init(_opts), do: nil

  def call(conn, _opts) do
    case conn.assigns[:current_admin] do
      nil ->
        conn
        |> put_session(:intending_to_visit, conn.request_path)
        |> put_flash(:info, "you are not an logged in as an admin")
        |> redirect(to: "/admin/login")
        |> halt

      _ ->
        conn
    end
  end
end
