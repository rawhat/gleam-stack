import lustre
import lustre/element.{text}

pub fn main() {
  let app = lustre.element(text("Hello, world!"))
  let assert Ok(_) = lustre.start(app, "[data-lustre-app]", Nil)
}
