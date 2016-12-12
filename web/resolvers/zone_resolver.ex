defmodule DnsimpleGraphql.ZoneResolver do
  def all(_args, %{context: context}) do
    {:ok, response} = Dnsimple.Zones.list_zones(context.client, context.account.id)
    {:ok, response.data}
  end
  def find(%{id: id}, %{context: context}) do
    {:ok, response} = Dnsimple.Zones.get_zone(context.client, context.account.id, id)
    {:ok, response.data}
  end
end
