defmodule MudalaWeb.CategoryView do
  use MudalaWeb, :view

  def title_case(name) do
    name
    |> String.downcase()
    |> String.capitalize()
  end
end
