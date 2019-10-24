defmodule MudalaWeb.OrdersController do

  use MudalaWeb, :controller
  alias Mudala.Sales

  def index(conn, _param) do
    customer = conn.assigns.current_customer

    orders =
        Sales.get_orders(customer.id)

    render conn, "index.html", orders: orders

  end


  def show(conn, id) do
    customer = conn.assigns.current_customer
    orders = Sales.get_order(customer.id)
    render conn, "show.html", orders: orders

  end
end
