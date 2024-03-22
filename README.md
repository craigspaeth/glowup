# GlowUp

A WIP full-stack gleam lang framework.

# Principles

- **GlowUp believes in science.** If there isn't research using the scientific method to prove something's effectiveness, then it's not worth the DX cost.
- [TDD](https://www.researchgate.net/publication/3249271_Guest_Editors'_Introduction_TDD--The_Art_of_Fearless_Programming) is one of the few scientifically proven ways to reduce a large amount of bugs so it's worth the DX cost.
- **The testing pyramid is great therefore pure functions are great.** Functions that [compose](https://redux.js.org/api/compose/) or [flow](https://lodash.com/docs/4.17.15#flow) together with a [ctx](https://github.com/gleam-wisp/wisp?tab=readme-ov-file#handlers) record are awesome. They're simple to break up control flow into pure functions that are easy to unit test and apply TDD.
- **Static types are for DX not correctness.** [The research](https://danluu.com/empirical-pl/) on static types shows that it only reduces _production_ bugs by at most 15% and most likely 2–5% (there's no evidence backing [the AirBnB claim](https://www.reddit.com/r/typescript/comments/aofcik/38_of_bugs_at_airbnb_could_have_been_prevented_by/) yet). Therefore static types are primarily useful as a DX tool (intellisense, documentation, etc.) and as such, it shouldn't get in the way of DX and it's okay to do some hacky things to get static types to work.
- **Stand on the shoulders of giants.** Gleam has the potential to build a large adoption. It intends to be simple instead of clever. It embraces javascript instead of belittling it. It has a pragmatic vibe that doesn't throw the baby out with the bathwater. Let's help Gleam become more popular by embracing popular patterns and libraries from the Erlang/JS ecosystem like Cowboy and React instead of re-inventing the wheel as long as they don't get too in the way of GlowUp's principles.
- **Simple over clever.** Like Gleam itself, [less but better](https://designwanted.com/dieter-rams-discover-10-best-designs/), is the way. We're not going to enforce a [directory structure](https://nextjs.org/docs/pages), [magically autoload code](https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#autoloading-when-the-application-boots) to avoid some import statements, [invent new languages](https://sass-lang.com/) for minor syntax wins, or build [a whole ass Rust engine](https://www.prisma.io/docs/orm/more/under-the-hood/engines#prisma-engines) so folks don't have to write SQL sometimes. If it comes down to picking between choosing a giant that does this kind of stuff vs. rolling our own simple library—simple should win. GlowUp should just be library (and maybe a CLI wizard to get started) that you can import the pieces you want with an easy escape hatch to evolve away from vs. a platform to get locked into. The only languages used should be web standards (HTML, CSS, JSON) or Gleam.
- **Don't solve imaginary scale problems.** Microservices are a way to scale teams, not software. Data meshes, event buses, GraphQL, etc. are an inevitability as a company grows to a certain size. But these are extremely costly and should be punted down the road for as long as possible. The BEAM VM is a very scaleable platform that'll scale technically for 99% of projects. GlowUp should enable folks to scale a modular monolith into a monorepo and leave the SOA vision to the poor folks selling their souls at 1k+ engineering teams. Simple RPC patterns over public API tools. Modular code like onion architecture, DDD, composable sub-applications over distributed systems. Performance of core DX like running linting, tests, etc. are worth investing in. Serverless and edge are nice but not necessary. React is fast enough.

_* Even that research that concludes static types catch 15% of bugs is questionable, as it looks at bugs in existing software and attempts to retroactively catch them with static types. There's no control for other quality measures like if every software applies TDD, code review, etc. There's no debate static types can catch some bugs—and probably a lot if no other quality controls are applied—but would it be 15% if every software analyzed used TDD, code review, etc.? Or would it be more like what other studies show of 2–5%?_

# MVVMC

A model, view, view model, controller architecture.

## Model

Server-side business logic and data transactions. A SQL query builder library in the spirit of [Kysely](https://github.com/kysely-org/kysely) or [Slonik](https://github.com/gajus/slonik). Could wrap [PGO](https://github.com/lpil/pgo) or maybe even [Ecto](https://hexdocs.pm/ecto/Ecto.html). Would be nice to work as well as it does for PG as SQLite (Turso)—shouldn't try to do the crazy thing ORMs do and claim to allow one easily switch databases behind it (asked no one ever).

## View

[React Gleam bindings](https://github.com/brettkolodny/react-gleam) that encourages leaving React to a presentation layer.

## View Model

Client-side business logic and data transactions. [Zustand](https://github.com/pmndrs/zustand) bindings to power global state stores with reducer/selector patterns and convenient namespaces for utility functions.

## Controller

Server-side user or computer input handlers such as isomorphic route handlers and RPCs. Could we use RSC for this or do we roll our own isomorphic rendering/RPC layer?

# Sub-apps

Like express sub-apps, it's nice to be able to isolate an entire bounded context into an application that can be run as its own isolated web server and compose together into one large web server for prod. This solves the 80/20 of microservices enabling teams to scale by forcing folks to be mindful of dependencies in their code (e.g. don't import backwards into another app) and keeps the DX light and fast (e.g. doesn't have to load the entire monolith to work on a sub-app).

GlowUp should make it easy to start with one big app and then simply move it into a folder of apps with a root lib directory to share code across those apps.

# CLI Wizard

Scaffolds a hello world app with:

- ./src
- ./models
  - todo.gleam
- ./views
  - ./list
    - list.glx
    - list.css
- ./view_models
  - todos.gleam
- ./controllers
  - todos.gleam
- ./test
  - ./models
    - todo.gleam
  - ...
 
Can also prompt for sub-apps and moves src and test into ./src/apps with a root lib directory holding a ./lib/design_system/button/button.gleam.
