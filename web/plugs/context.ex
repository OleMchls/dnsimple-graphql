defmodule DnsimpleGraphql.Web.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})
      {:error, reason} ->
        conn
        |> resp(403, reason)
        |> send_resp
        |> halt()
      _ ->
        conn
        |> resp(400, "Bad Request")
        |> send_resp
        |> halt()
    end
  end

  @doc """
  Return the current user context based on the authorization header
  """
  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization") do
      authorize(token)
    end
  end

  defp authorize(token) do
    client = %Dnsimple.Client{access_token: token}
    case Dnsimple.Identity.whoami(client) do
      {:ok, response} -> {:ok, %{account: response.data.account, client: client}}
      any -> any
    end
  end
end
