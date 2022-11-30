defmodule Yugo.Conn do
  @moduledoc false

  @type t :: %__MODULE__{
          tls: boolean,
          socket: :gen_tcp.socket() | :ssl.sslsocket(),
          server: String.t(),
          username: String.t(),
          mailbox: String.t(),
          password: String.t(),
          next_cmd_tag: integer,
          capabilities: [String.t()],
          got_server_greeting: boolean,
          state: :not_authenticated | :authenticated | :selected,
          tag_map: %{
            String.t() => %{
              command: String.t(),
              on_response: (__MODULE__.t(), :ok | :no | :bad -> __MODULE__.t())
            }
          },
          applicable_flags: [String.t()],
          permanent_flags: [String.t()],
          num_exists: nil | integer,
          num_recent: nil | integer,
          first_unseen: nil | integer,
          uid_validity: nil | integer,
          uid_next: nil | integer,
          mailbox_mutability: :read_only | :read_write
        }

  @derive {Inspect, except: [:password]}
  @enforce_keys [:tls, :socket, :username, :password, :server, :mailbox]
  defstruct [
    :tls,
    :socket,
    :server,
    :username,
    :mailbox,
    # only stored temporarily; gets cleared from memory after sending LOGIN
    :password,
    next_cmd_tag: 0,
    capabilities: [],
    got_server_greeting: false,
    state: :not_authenticated,
    tag_map: %{},
    applicable_flags: [],
    permanent_flags: [],
    num_exists: nil,
    num_recent: nil,
    first_unseen: nil,
    uid_validity: nil,
    uid_next: nil,
    mailbox_mutability: nil
  ]
end
