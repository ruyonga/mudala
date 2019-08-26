defmodule MudalaWeb.RegistrationController do
  use MudalaWeb, :controller

  alias Mudala.CRM

    def new(conn, _) do
      changest = CRM.build_customer()

      render(conn, "new.html", changest: changest)
    end
end
