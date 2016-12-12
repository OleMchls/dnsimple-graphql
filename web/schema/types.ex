defmodule DnsimpleGraphql.Schema.Types do
  use Absinthe.Schema.Notation

  object :zone do
    field :id, :id
    field :account_id, :id
    field :name, :string
    field :reverse, :boolean
    field :created_at, :string
    field :updated_at, :string
    field :records, list_of(:record)  do
      resolve fn (zone, _, %{context: context}) ->
        case Dnsimple.Zones.list_zone_records(context.client, context.account.id, zone.name) do
          {:ok, response} -> {:ok, response.data}
          any -> any
        end
      end
    end
  end

  object :record do
     field :id, :id # 1,
     field :zone_id, :string # "example.com",
     field :name, :string # "",
     field :content, :string # "ns1.dnsimple.com admin.dnsimple.com 1458642070 86400 7200 604800 300",
     field :ttl, :integer # 3600,
     field :priority, :integer # null,
     field :type, :string # "SOA",
     field :system_record, :boolean # true,
     field :created_at, :string # "2016-03-22T10:20:53Z",
     field :updated_at, :string # "2016-10-05T09:26:38Z"
  end
end
