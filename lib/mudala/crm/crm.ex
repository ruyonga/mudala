defmodule Mudala.CRM do
  alias Mudala.CRM.Customer
  alias Mudala.Repo

  def build_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
  end

  def create_customer(attrs) do
    attrs
    |> build_customer()
    |> Repo.insert()
  end
end
