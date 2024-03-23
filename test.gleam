let #(reducer, selector) = view_model(init_state)

type State {
  todos: List(Todo)
  is_saving: Bool
}

type Todo {
  body: String
  title: String
  is_done: Bool
}

fn add_todo(ctx: Ctx) {
    ctx.state
}

fn init_state() {
    State(
      todos: [
        Todo(title: "Groceries", body: "Buy milk", is_done: False)
      ],
      is_saving: false
    )
}