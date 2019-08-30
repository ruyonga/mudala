defmodule Mudala.Sales.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mudala.Sales.{Order, LineItem}

  schema "orders" do
    field :status, :string
    field :total, :decimal
    embeds_many :line_items, LineItem, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:status, :total, :line_items])
    |> validate_required([:status, :total, :line_items])
  end
end
