defmodule MudalaWeb.SessionController do
  use MudalaWeb, :controller

  alias Mudala.CRM

  def new(conn, _params) do
      render(conn, "new.html")
  end


  def create(conn, %{"session" => session_params}) do
        case CRM.get_customer_by_credentials(session_params) do
            :error ->
                conn
                  |> put_flash(:error, "Invalid username/password combination")
                  |>render("new.html")
            customer ->
                conn
                  |> assign(:current_customer, customer)
                  |> put_session(:customer_id, customer.id)
                  |> configure_session(renew: true)
                  |> put_flash(:info, "Login successful")
                  |> redirect(to: Routes.page_path(conn, :index))
        end
  end
end
