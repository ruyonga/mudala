defmodule Mudala.SalesTest do

  use Mudala.DataCase

  alias Mudala.{Sales, Repo}
  alias Mudala.Sales.Order


  test "create_cart" do
    assert %Order{status: "In Cart"} = Sales.create_cart
  end

  test "get_cart/1" do
    cart1 = Sales.create_cart
    cart2 = Sales.get_cart(cart1.id)
    assert cart1.id == cart2.id
  end
end
