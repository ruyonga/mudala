defmodule Mudala.CRM do
  alias Mudala.CRM.Customer

  def build_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
  end

end
