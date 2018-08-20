push!( LOAD_PATH, "../src/" )

using Documenter, Touchstone

makedocs(
  format = :html,
  sitename = "Touchstone.jl"
)

deploydocs(
  repo   = "github.com/mpichl87/Touchstone.jl.git",
  target = "build",
  julia = "1.0",
  deps = nothing,
  make = nothing,
)
