defmodule MudalaWeb.Acceptance.CategoryPageTest do
  use Mudala.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    ## GIVEN ##
    # There are two products Apple and Tamota priced 100 and 50
    # categorised under `fruits` and `vegetables` respectively
    alias Mudala.Repo
    alias Mudala.Catalog.Product
    Repo.insert(%Product{name: "Tomato", price: 50, is_seasonal: false, category: "vegetables"})
    Repo.insert(%Product{name: "Apple", price: 100, is_seasonal: true, category: "fruits"})
    :ok
  end

  test "show fruits" do
    ## WHEN ##
    # I navigate to the fruits page

    navigate_to("/categories/fruits")

    ## THEN ##
    # I expect page tiel to be "seasonal products"
    page_title = find_element(:css, ".page-title") |> visible_text()
    assert page_title == "Fruits"

    # And i expect Apple in the product displayed

    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text()
    product_price = find_within_element(product, :css, ".product-price") |> visible_text()

    assert product_name == "Apple"
    # And I expect its price to be displayed on screen
    assert product_price == "100"

    # And I expect that Tomato is not present on screen.
    refute page_source() =~ "Tomato"
  end

  test "shows vegetables" do
    ## WHEN ##
    # I navigate to vegetables page
    navigate_to("/categories/vegetables")

    ## THEN ##
    # I expect the page title to be "Seasonal products"
    page_title = find_element(:css, ".page-title") |> visible_text()
    assert page_title == "Vegetables"

    # And I expect Tomato in the product displayed
    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text()
    product_price = find_within_element(product, :css, ".product-price") |> visible_text()

    assert product_name == "Tomato"
    # And I expect its price to be displayed on screen
    assert product_price == "50"

    # And I expect that Apple is not present on screen.
    refute page_source() =~ "Apple"
  end
end
