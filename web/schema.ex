defmodule DnsimpleGraphql.Schema do
  use Absinthe.Schema
  import_types DnsimpleGraphql.Schema.Types

  query do
    @desc "Get all Zones (Domains)"
    field :zones, list_of(:zone) do
      resolve &DnsimpleGraphql.ZoneResolver.all/2
    end

    field :zone, type: :zone do
      arg :id, non_null(:id)
      resolve &DnsimpleGraphql.ZoneResolver.find/2
    end
  end

end
