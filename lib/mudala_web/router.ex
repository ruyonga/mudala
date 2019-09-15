defmodule MudalaWeb.Router do
  use MudalaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :frontend do
    # Add plugs related to frontend
    plug MudalaWeb.Plugs.LoadCustomer
    plug MudalaWeb.Plug.FetchCart
  end

  # Unauthenticated scope
  scope "/", MudalaWeb do
    pipe_through [:browser, :frontend]
    # Add all routes that don't require authentication
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create

    get "/", PageController, :index
    get "/categories/:name", CategoryController, :show

    get "/cart", CartController, :show
    post "/cart", CartController, :add
    patch "/cart", CartController, :update
    put "/cart", CartController, :update
  end


  # Authenticated scope
  scope "/", MudalaWeb do
    pipe_through [:browser, :frontend, MudalaWeb.Plugs.AuthenticateCustomer]
    # Add all routes that do require authentication
    get "/logout", SessionController, :delete
    get "/checkout", CheckoutController, :edit
    put "/checkout/confirm", CheckoutController, :update

  end


  # Other scopes may use custom stacks.
  # scope "/api", MudalaWeb do
  #   pipe_through :api
  # end
end
