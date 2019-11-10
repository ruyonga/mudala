defmodule MudalaWeb.RegistrationController do
  use MudalaWeb, :controller

  alias Mudala.CRM

  def new(conn, _) do
    changeset = CRM.build_customer()
    residence_areas = Places.ResidenceService.list_areas()
    render(conn, "new.html", changeset: changeset, residence_areas: residence_areas)
  end

  def create(conn, %{"registration" => registration_parmas}) do
    case CRM.create_customer(registration_parmas) do
      {:ok, _customer} ->
        conn
        |> put_flash(:info, "Registration successful")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        residence_areas = Places.ResidenceService.list_areas()

        conn
        |> render(:new, changeset: changeset, residence_areas: residence_areas)
    end
  end
end
