defmodule MudalaWeb.HomepageTest do
  use Mudala.DataCase

  use Hound.Helpers

  hound_session()
  setup do
    ## GIVEN ##
    # There are two products Apple and Tomato priced 100 and 50 respectively
    # Where Apple being the only seasonal product
    alias Mudala.Repo
    alias Mudala.Catalog.Product
    Repo.insert %Product{name: "Tomato", price: 50, is_seasonal: false}
    Repo.insert %Product{name: "Apple", price: 100, is_seasonal: true}
    :ok
  end
  test "presence of featured products" do
    ## GIVEN##
    # There are two products Apple and Tomato priced at 100 and 50 respectively
    # With Apple being the only seasonal product

    ## WHEN ##
    # I navigate to homepage
    navigate_to("/")

    ## THEN ##
    # I expect the page title to be "Seasonal Products"
    page_title = find_element(:css, ".page-title") |> visible_text()

    assert page_title == "Seasonal Products"

    # And  I expect Apple to be in the product displayed
    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text()
    product_price = find_within_element(product, :css, ".product-price") |> visible_text()

    assert product_name == "Apple"

    #And I expect its price to be displayed on the screen
    assert product_price == "100"

    #And I ext that Tomato is not present on the screen

    refute page_source() =~ "Tomato"

  end
end
