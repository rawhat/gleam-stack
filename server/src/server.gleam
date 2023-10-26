import gleam/erlang.{priv_directory}
import gleam/erlang/process
import server/database
import server/web
import wisp
import mist

pub fn main() {
  let assert Ok(priv) = priv_directory("server")

  let db = database.connect()
  let assert Ok(Nil) = database.migrate(db)

  let secret_key = wisp.random_string(64)

  let router = web.handle_request(_, db, priv)

  let assert Ok(_) =
    wisp.mist_handler(router, secret_key)
    |> mist.new
    |> mist.port(8080)
    |> mist.start_http

  process.sleep_forever()
}
