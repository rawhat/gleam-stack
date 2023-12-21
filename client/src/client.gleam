import lustre
import lustre/attribute.{attribute}
import lustre/element.{type Element, text}
import lustre/element/html.{div, span}

pub fn main() {
  let app = lustre.simple(fn(_) { Nil }, fn(model, _msg) { model }, view)
  let assert Ok(_) = lustre.start(app, "[data-lustre-app]", Nil)
}

fn view(_model: Nil) -> Element(Nil) {
  div(
    [
      attribute.class(
        "container mx-auto h-screen flex justify-center items-center",
      ),
    ],
    [
      span([attribute.class("text-3xl text-fuchsia-300 font-mono")], [
        text("✨ you're up and running ✨"),
      ]),
    ],
  )
}
