defmodule MudalaWeb.TicketController do
  use MudalaWeb, :controller

  alias Mudala.Ticket.CRM
  alias Mudala.CRM.Ticket

  def index(conn, _params) do
    customer = conn.assigns.current_customer
    tickets = CRM.list_customer_tickets(customer)
    render(conn, "index.html", tickets: tickets)
  end

  def new(conn, _params) do
    customer = conn.assigns.current_customer
    changeset = CRM.build_customer_ticket(customer)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    customer = conn.assigns.current_customer

    case CRM.create_customer_ticket(customer, ticket_params) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket created successfully.")
        |> redirect(to: Routes.ticket_path(conn, :show, ticket))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = conn.assigns.current_customer
    ticket = CRM.get_customer_ticket!(customer, id)
    render(conn, "show.html", ticket: ticket)
  end

  def edit(conn, %{"id" => id}) do
    customer = conn.assigns.current_customer
    ticket = CRM.get_customer_ticket!(customer, id)
    changeset = CRM.build_customer_ticket(customer)
    render(conn, "edit.html", ticket: ticket, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = CRM.get_ticket!(id)

    case CRM.update_ticket(ticket, ticket_params) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket updated successfully.")
        |> redirect(to: Routes.ticket_path(conn, :show, ticket))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ticket: ticket, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ticket = CRM.get_ticket!(id)
    {:ok, _ticket} = CRM.delete_ticket(ticket)

    conn
    |> put_flash(:info, "Ticket deleted successfully.")
    |> redirect(to: Routes.ticket_path(conn, :index))
  end
end
