defmodule MudalaWeb.CheckoutController do
  use MudalaWeb, :controller

  def edit(conn, _params) do
    render conn, "edit.html"
  end

end
