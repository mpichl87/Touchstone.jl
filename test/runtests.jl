import Touchstone

using Base.Test

# @test Touchstone.parse_option_line() == Touchstone.Options( 1e9, "S", "MA", 50.0 )
println( Touchstone.parse_option_line() )
println( Touchstone.Options( 1e9, "S", "MA", 50.0 ) )

Touchstone.parse_option_line() == Touchstone.Options( 1e9, "S", "MA", 50.0 ) 
