import lustre
import lustre/attribute.{attribute}
import lustre/element.{type Element, text}
import lustre/element/html.{div, p}

pub fn main() {
  let app = lustre.simple(fn(_) { Nil }, fn(model, _msg) { model }, view)
  let assert Ok(_) = lustre.start(app, "[data-lustre-app]", Nil)
}

fn view(_model: Nil) -> Element(Nil) {
  div([attribute.style([#("width", "100vw"), #("height", "100vh")])], [
    p([attribute.class("h-full"), attribute.class("w-full")], [
      text("Hello, world!"),
    ]),
  ])
}
