# DNSimple GraphQL (Spike)

This is a spike of adding a [GraphQL](http://graphql.org/) bridge on top of the DNSimple REST API v2. GitHub just released their new API as a GraphQL API as well. So it's a hot topic in API world.

At the moment this spike only implements Zones and Records. But adding additional types is fairly easy and can be done with cahanges in the following files:

- https://github.com/nesQuick/dnsimple-graphql/blob/master/web/schema/types.ex
- https://github.com/nesQuick/dnsimple-graphql/blob/master/web/resolvers/zone_resolver.ex
- https://github.com/nesQuick/dnsimple-graphql/blob/master/web/schema.ex

## Show it to me!

There is a example deployment at https://pure-escarpment-69887.herokuapp.com/client.html it uses a sample browser based IDE client called [graphiql](https://github.com/graphql/graphiql). It has a handful of great auto complete features for example auto-completion.

It will prompt you for a  DNSimple *Account* access token on the first load.

### The first query

See the power of GraphQL, lets' write our first query. Get all Zones but onl;y fetch name and id.

```graphql
query {
  zones{
    id
    name
  }
}
```

That was easy. We can also fetch all subressources with a single request.

```graphql
query {
  zones{
    id
    name
    records {
      type
      name
      content
      zoneId
    }
  }
}
```

Or lets fetch a single zone:

```graphql
query {
  zone(id: "codestars.eu") {
    id
    name
    records {
      type
      name
      content
    }
  }
}
```

Queries can be combined in any way, for the last, lets do a more complex one:

```graphql
query {
  zone(id: "codestars.eu") {
    id
    name
    records {
      type
      name
      content
    }
  }
  zones{
    id
    name
    records {
      type
      name
      content
      zoneId
    }
  }
}
```



## Development -- To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4050/client`](http://localhost:4050/client.html) from your browser.
