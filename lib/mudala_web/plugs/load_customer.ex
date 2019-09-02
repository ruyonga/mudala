defmodule MudalaWeb.Plugs.LoadCustomer do
  import Plug.Conn
  alias Mudala.CRM


  def init(_opts), do: nil

  def call(%Plug.Conn{} = conn, _opts) do
    customer_id = get_session(conn, :customer_id)
    customer = customer_id && CRM.get_customer(customer_id)

    assign(conn, :current_customer, customer)
  end

end
