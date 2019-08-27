defmodule Mudala.Catalog do
  alias Mudala.Catalog.Product
  alias Mudala.Repo

  def list_products do
    Product
    |> Repo.all()
  end

  def list_seasonal_products do
    list_products()
    |> Enum.filter(fn product -> product.is_seasonal == true end)
  end

  def get_category_products(name) do
    list_products()
    |> Enum.filter(fn product -> product.category == name end)
  end
end
