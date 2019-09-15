defmodule MudalaWeb.CartController do
  use MudalaWeb, :controller

  alias Mudala.Sales

  def show(conn, _params) do
    cart = conn.assigns.cart
    cart_changeset = Sales.change_cart(cart)
    render conn, "show.html", cart: cart, cart_changeset: cart_changeset
  end

  def add(conn, %{"cart" => cart_params}) do
    cart = conn.assigns.cart
    case Sales.add_to_cart(cart, cart_params) do
      {:ok, cart} ->
       render(conn, "add.json", cart: cart, cart_params: cart_params)
      {:error, _} ->
        conn
        |> put_flash(:info, "Error adding product to cart")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
