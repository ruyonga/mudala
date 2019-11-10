defmodule MudalaWeb.Plugs.LoadAdmin do
  import Plug.Conn
  alias Mudala.Administration

  def init(_opts), do: nil

  def call(%Plug.Conn{} = conn, _opts) do
    admin_id = get_session(conn, :admin_id)
    admin = admin_id && Administration.get_user!(admin_id)

    assign(conn, :current_admin, admin)
  end
end
