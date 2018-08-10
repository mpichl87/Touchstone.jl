module Touchstone

import Base: ==, ≈
struct Options
    unit::Float64
    parameter::Symbol
    format::Symbol
    resistance::Float64
end
Options() = Options( units[ default_units ], parameters[ default_parameter ], formats[ default_format ], default_resistance )
function ==( o1, o2 :: Options )
    o1.unit ≈ o2.unit &&
    o1.parameter == o2.parameter &&
    o1.format == o2.format &&
    o1.resistance ≈ o2.resistance
end

struct DataPoint
    frequency::Float64
    parameter::Matrix{Complex{Float64}}
end
function ==( dp1, dp2 :: DataPoint )
    dp1.frequency == dp2.frequency &&
    dp1.parameter == dp2.parameter
end
function ≈( dp1, dp2 :: DataPoint )
    dp1.frequency ≈ dp2.frequency &&
    dp1.parameter ≈ dp2.parameter
end

struct TS
    data::Vector{DataPoint}
    options::Options
    comments::Vector{String}
end
TS( data = Vector{DataPoint}(), options::Options = Options(), comments = Vector{String}() ) = TS( data, options, comments )
TS( options::Options, comments = Vector{String}() ) = TS( Vector{DataPoint}(), options, comments )

function ==( ts1, ts2 :: TS )
    ts1.data == ts2.data &&
    ts1.options == ts2.options &&
    ts1.comments == ts2.comments &&
    ts1.data == ts2.data
end

export freqs
freqs( ts::TS ) = map( dp -> dp.frequency, ts.data )
export params
params( ts::TS ) = map( dp -> dp.parameter, ts.data )
export param
param( ts::TS, p1 = 1, p2 = 1 ) = map( dp -> dp.parameter[ p1, p2 ], ts.data )
export mags
mags( ts::TS, p1 = 1, p2 = 1 ) = map( abs, param( ts, p1, p2 ) )
export dBmags
dBmags( ts::TS, p1 = 1, p2 = 1 ) = map( x -> 20log10( abs( x ) ), param( ts, p1, p2 ) )
export angs
angs( ts::TS, p1 = 1, p2 = 1 ) = map( p -> rad2deg( angle( p ) ), param( ts, p1, p2 ) )
export reals
reals( ts::TS, p1 = 1, p2 = 1 ) = map( real, param( ts, p1, p2 ) )
export imags
imags( ts::TS, p1 = 1, p2 = 1 ) = map( imag, param( ts, p1, p2 ) )

include( "ParseTouchstone.jl" )
include( "WriteTouchstone.jl" )

end
