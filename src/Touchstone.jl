module Touchstone

import Base: ==, ≈

export Options, DataPoint, TS, freqs, params, param, mags, dBmags, angs, reals, imags
export version, ports, refs
export parse_touchstone_stream, parse_touchstone_string, parse_touchstone_file
export write_touchstone_stream, write_touchstone_string, write_touchstone_file

"Holds values from option line."
struct Options
  unit::Float64
  parameter::Symbol
  format::Symbol
  resistance::Float64
end
Options() = Options( units[ default_units ], parameters[ default_parameter ], formats[ default_format ], default_resistance )
"Compares Options."
function ==( o1, o2 :: Options )
  o1.unit ≈ o2.unit &&
  o1.parameter == o2.parameter &&
  o1.format == o2.format &&
  o1.resistance ≈ o2.resistance
end

"Holds scalar frequency and parameter matrix for one data point."
struct DataPoint
  frequency::Float64
  parameter::Matrix{Complex{Float64}}
end
"Compares data points."
function ==( dp1, dp2 :: DataPoint )
  dp1.frequency == dp2.frequency &&
  dp1.parameter == dp2.parameter
end
"Compares data points approximately."
function ≈( dp1, dp2 :: DataPoint )
  dp1.frequency ≈ dp2.frequency &&
  dp1.parameter ≈ dp2.parameter
end

"Holds data for Touchstone file."
struct TS
  data::Vector{ DataPoint }
  options::Options
  comments::Vector{ String }
  keywordparams::Dict{ Symbol, Any }
end
TS(
  data = Vector{ DataPoint }(),
  options::Options = Options(),
  comments = Vector{ String }(),
  keywordparams = Dict{ Symbol, Any }()
) = TS( data, options, comments, keywordparams )

"Compares Touchstone data."
function ==( ts1, ts2 :: TS )
    ts1.data == ts2.data &&
    ts1.options == ts2.options &&
    ts1.comments == ts2.comments &&
    ts1.keywordparams == ts2.keywordparams
end

"""
    freqs( ts )

Gets the frequency vector from Touchstone data.
"""
freqs( ts::TS ) = map( dp -> dp.frequency, ts.data )

"""
    params( ts )

Gets the vector of parameter matrices from Touchstone data.
"""
params( ts::TS ) = map( dp -> dp.parameter, ts.data )

"""
    param( ts, p1, p2 )

Gets the vector of parameters with indices p1, p2 from Touchstone data.
"""
param( ts::TS, p1 = 1, p2 = 1 ) = map( dp -> dp.parameter[ p1, p2 ], ts.data )

"""
    mags( ts, p1, p2 )

Gets the vector of the magnitudes of parameters with indices p1, p2 from Touchstone data.
"""
mags( ts::TS, p1 = 1, p2 = 1 ) = map( abs, param( ts, p1, p2 ) )

"""
    dBmags( ts, p1, p2 )

Gets the vector of the magnitudes in dB of parameters with indices p1, p2 from Touchstone data.
"""
dBmags( ts::TS, p1 = 1, p2 = 1 ) = map( x -> 20log10( abs( x ) ), param( ts, p1, p2 ) )

"""
    angs( ts, p1, p2 )

Gets the vector of the angles in radians of parameters with indices p1, p2 from Touchstone data.
"""
angs( ts::TS, p1 = 1, p2 = 1 ) = map( p -> rad2deg( angle( p ) ), param( ts, p1, p2 ) )

"""
    reals( ts, p1, p2 )

Gets the vector of the real parts of parameters with indices p1, p2 from Touchstone data.
"""
reals( ts::TS, p1 = 1, p2 = 1 ) = map( real, param( ts, p1, p2 ) )

"""
    imags( ts, p1, p2 )

Gets the vector of the imaginary parts of parameters with indices p1, p2 from Touchstone data.
"""
imags( ts::TS, p1 = 1, p2 = 1 ) = map( imag, param( ts, p1, p2 ) )


function version( ts::TS )
  if haskey( ts.keywordparams, :Version )
    if ts.keywordparams[ :Version ] == 2
      return "2.0"
    else
      error( "Unknown version." )
    end
  else
    return( "1.0" )
  end
end

function ports( ts::TS )
  ports = 0
  if version( ts ) == "2.0"
    ports = ts.keywordparams[ :NumberOfPorts ]
  elseif length( ts.data ) > 0
    ports = size( ts.data[ 1 ].parameter, 1 )
  end
  return ports
end

function refs( ts::TS )
  if version( ts ) == "2.0" && haskey( ts.keywordparams, :Reference )
    refs = ts.keywordparams[ :Reference ]
  else
    refs = fill( ts.options.resistance, ports( ts ) )
  end
  return refs
end

include( "ParseTouchstone.jl" )
include( "WriteTouchstone.jl" )

end
