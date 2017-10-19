defmodule MehrSchulferienWeb.Router do
  use MehrSchulferienWeb, :router

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

  scope "/", MehrSchulferienWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/federal_states/:federal_state_id/:starts_on/:ends_on", FederalStateController, :show
    get "/federal_states/:federal_state_id/:year", FederalStateController, :show
  end

  scope "/admin", MehrSchulferienWeb.Admin, as: :admin do
    pipe_through :browser # Use the default browser stack

    # Locations
    #
    resources "/countries", CountryController
    resources "/federal_states", FederalStateController
    resources "/cities", CityController
    resources "/schools", SchoolController

    # Timetables
    #
    resources "/years", YearController
    resources "/months", MonthController
    resources "/days", DayController
    resources "/categories", CategoryController
    resources "/periods", PeriodController
    resources "/slots", SlotController
  end

  # Other scopes may use custom stacks.
  # scope "/api", MehrSchulferienWeb do
  #   pipe_through :api
  # end
end
