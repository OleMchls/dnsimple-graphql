defmodule DnsimpleGraphql.Router do
  use DnsimpleGraphql.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug DnsimpleGraphql.Web.Context
  end

  # scope "/api", DnsimpleGraphql do
  #   pipe_through :api
  # end

  scope "/" do
    pipe_through :api
    forward "/", Absinthe.Plug, schema: DnsimpleGraphql.Schema
  end

end
