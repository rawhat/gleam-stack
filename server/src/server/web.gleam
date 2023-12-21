import gleam/dynamic
import gleam/http/request.{type Request}
import gleam/io
import gleam/pgo.{type Connection as DbConnection}
import wisp.{type Connection}

pub fn handle_request(
  req: Request(Connection),
  db: DbConnection,
  asset_dir: String,
) {
  use <- wisp.serve_static(req, under: "/static", from: asset_dir)

  let assert Ok(resp) =
    pgo.execute("select * from users", db, [], dynamic.unsafe_coerce)
  io.debug(#("got something back", resp))

  case request.path_segments(req) {
    _ ->
      wisp.response(200)
      |> wisp.string_body("Ok")
  }
}
