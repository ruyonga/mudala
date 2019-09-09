defmodule MudalaWeb.CartController do
  use MudalaWeb, :controller

  alias Mudala.Sales

  def show(conn, _params) do
    cart = conn.assigns.cart
    render conn, "show.html", cart: cart
  end

  def add(conn, %{"cart" => cart_params}) do
    cart = conn.assigns.cart
    case Sales.add_to_cart(cart, cart_params) do
      {:ok, _} ->
        %{"product_name" => name, "pack_size" => size, "quantity" => qty } = cart_params
        message = "Product added to cart - #{name}(#{size}) x #{qty} qty"

        conn
        |> put_flash(:info, message)
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:info, "Error adding product to cart")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
