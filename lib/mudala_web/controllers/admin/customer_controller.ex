defmodule MudalaWeb.Admin.CustomerController do
  use MudalaWeb, :controller

  alias Mudala.CRM

  def index(conn, _params) do
    customers = CRM.get_all_customers()
  end
end