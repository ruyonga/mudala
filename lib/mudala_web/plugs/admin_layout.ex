defmodule MudalaWeb.Plugs.AdminLayout do
  import Phoenix.Controller, only: [put_layout: 2]

  def init(_opts), do: nil

  def call(conn, _) do
      conn
      |> put_layout({MudalaWeb.LayoutView, "admin_app.html"})
  end
end