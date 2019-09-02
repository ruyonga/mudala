defmodule MudalaWeb.Plugs.FetchCartTest do
  use MudalaWeb.ConnCase
  alias Mudala.Sales.Order

test "create and set cart on first visit"  do
      conn = get build_conn()

      cart_id = get_session(conn, :cart_id)
      assert %Order{status: "In Cart"} = conn.assigns.cart
      assert cart_id == conn.assigns.cart.id
end

test "fetch cart from session on subsequent visit" do
      conn = get build_conn(), "/"

      cart_id = get_session(conn, :cart_id)
      conn = get conn, "/"
      assert cart_id == conn.assigns.cart.id
end
end
