push!( LOAD_PATH, "../src/" )

using Documenter, Touchstone

makedocs(
  format = :html,
  sitename = "Touchstone.jl"
)

deploydocs(
  repo   = "github.com/mpichl87/Touchstone.jl",
  target = "build",
  deps   = nothing,
  make   = nothing
)
