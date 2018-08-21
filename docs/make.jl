push!( LOAD_PATH, "../src/" )

using Documenter, Touchstone

makedocs(
  format = :html,
  sitename = "Touchstone.jl",
  modules = [ Touchstone ],
  pages = [
    "Home" => "index.md",
    "Library" => [
      "Public" => "public.md",
      "Internals" => "internals.md"
    ]
  ]
)

deploydocs(
  repo   = "github.com/mpichl87/Touchstone.jl.git",
  target = "build",
  julia = "1.0",
  deps = nothing,
  make = nothing,
)
