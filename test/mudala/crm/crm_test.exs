defmodule Mudala.CRMTest do
  use Mudala.DataCase

  alias Mudala.CRM
  alias Mudala.CRM.Customer

  test "build_customer/0 return a customer changest" do
    assert %Ecto.Changeset{data: %Customer{}} = CRM.build_customer
  end

  test "build_customer/1 returns a customer changeset with values applied" do
    attrs = %{"name" => "John"}
    changeset = CRM.build_customer(attrs)
    assert changeset.params == attrs
  end

end
