defmodule MudalaWeb.Admin.OrdersController do
  use MudalaWeb, :controller
  alias Mudala.Sales

  def index(conn, _params) do
        orders = Sales.get_order()
        json(conn, orders)
  end
end