defmodule MudalaWeb.Acceptance.SessionTest do
  use Mudala.DataCase
  use Hound.Helpers

  setup do
    ## GIVEN ##
    # There is a vailid registered user

    alias Mudala.CRM

    valid_attr = %{
      "name" => "John",
      "email" => "john@example.com",
      "password" => "secret",
      "residence_area" => "Area 1",
      "phone" => "1111"
    }

    {:ok, _j} = CRM.create_customer(valid_attr)
  end

  test "successful login for valid credentials" do
    ## When ##
    navigate_to("/login")

    form = find_element(:id, "session-form")

    find_within_element(form, :name, "session[email]")
    |> fill_field("john@example.com")

    find_within_element(form, :name, "session[password]")
    |> fill_field("secret")

    find_within_element(form, :tag, "button")
    |> click()

    ## THEN ##

    assert current_path() == "/"

    message =
      find_element(:class, "alert-info")
      |> visible_text()

    assert message == "Login successful"
  end

  test "shows error message for invalid crendetials " do
    ## WHEN ##
    navigate_to("/login")

    form = find_element(:id, "session-form")

    find_within_element(:id, :tag, "button")
    |> click()

    ## THEN ##
    assert current_path() == "/login"

    message =
      find_element(:class, "alert-danger")
      |> visible_text()

    assert message == "Invalid username/password combination"
  end
end
