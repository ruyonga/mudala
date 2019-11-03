defmodule Mudala.Ticket.CRM do
  @moduledoc """
  The CRM context.
  """

  import Ecto.Query, warn: false
  alias Mudala.Repo

  alias Mudala.Ticket
  alias Mudala.CRM.Customer

  @doc """
  Returns the list of tickets.

  ## Examples

      iex> list_customer_tickets()
      [%Ticket{}, ...]

  """
  def list_customer_tickets(customer) do
    customer
    |> Ecto.assoc(:tickets)
    |> Repo.all()
  end

  @doc """
  Gets a single ticket.

  Raises `Ecto.NoResultsError` if the Ticket does not exist.

  ## Examples

      iex> get_customer_ticket!(123)
      %Ticket{}

      iex> get_customer_ticket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer_ticket!(customer, id)  do
    customer
    |> Ecto.assoc(:tickets)
    |> Repo.get!(id)
  end


  @doc """
  Creates a ticket.

  ## Examples

      iex> create_customer_ticket(%{field: value})
      {:ok, %Ticket{}}

      iex> create_customer_ticket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer_ticket(%Customer{} = customer, attrs \\ %{}) do
    build_customer_ticket(customer, attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ticket.

  ## Examples

      iex> update_ticket(ticket, %{field: new_value})
      {:ok, %Ticket{}}

      iex> update_ticket(ticket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ticket.

  ## Examples

      iex> delete_ticket(ticket)
      {:ok, %Ticket{}}

      iex> delete_ticket(ticket)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ticket changes.

  ## Examples

      iex> build_customer_ticket(ticket)
      %Ecto.Changeset{source: %Ticket{}}

  """
  def build_customer_ticket(%Customer{} = customer, attrs \\ %{}) do
    Ecto.build_assoc(customer, :tickets, %{status: "News"})
    |> Ticket.changeset(attrs)
  end
end
