"Values for units for strings found in option line."
const units = Dict{ String, Float64 }(
  "HZ"    =>      1e0,
  "KHZ"   =>      1e3,
  "MHZ"   =>      1e6,
  "GHZ"   =>      1e9
)
"The default unit, if not found in option line."
const default_units = "GHZ"

"Symbols for different parameter formats for strings found in option line"
const parameters = Dict{ String, Symbol }(
  "S" => :ScatteringParameters,
  "Y" => :AdmittanceParameters,
  "Z" => :ImpedanceParameters,
  "H" => :HybridHParameters,
  "G" => :HybridGParameters,
)
"The default parameter format, if not found in option line."
const default_parameter = "S"

"Symbols for data format for strings found in option line."
const formats = Dict{ String, Symbol }(
  "DB" => :DecibelAngle,
  "MA" => :MagnitudeAngle,
  "RI" => :RealImaginary
)
"The default data format, if not found in option line."
const default_format = "MA"
"The default characteristic impedance, if not found in option line."
const default_resistance = 50

"""
    is_commentline( line )

Checks, if a line is a comment line.
"""
is_comment_line( line ) = length( line ) > 0 && line[ 1 ] == '!'
"""
    parse_comment_line( line )

Returns the comment of a comment line.
"""
parse_comment_line( line ) = line[ 2:end ]

"""
    is_option_line( line )

Checks, if a line is a option line.
"""
is_option_line( line ) = length( line ) > 0 && line[ 1 ] == '#'

"""
    is_frequency_unit_option( option )

Checks, if a string is a valid unit in an option line.
"""
is_frequency_unit_option( option ) = haskey( units,  uppercase( option ) )

"""
    parse_frequency_unit_option( option )

Returns the multiplier for a unit string in an option line.
"""
parse_frequency_unit_option( option ) = units[ uppercase( option ) ]

"""
    is_parameter_option( option )

Checks, if a string is a valid parameter format in an option line.
"""
is_parameter_option( option ) = haskey( parameters, uppercase( option ) )

"""
    parse_parameter_option( option )

Returns the symbol for a valid parameter format string in an option line.
"""
parse_parameter_option( option ) = parameters[ uppercase( option ) ]

"""
    is_format_option( option )

Checks, if a string is a valid data format in an option line.
"""
is_format_option( option ) = haskey( formats, uppercase( option ) )

"""
    parse_format_option( option )

Returns the symbol for a valid data format string in an option line.
"""
parse_format_option( option ) = formats[ uppercase( option ) ]

"""
    is_resistance_option( option )

Checks, if a string is a valid resistance in an option line.
"""
is_resistance_option( option ) = uppercase( option ) == "R"

"""
    parse_resistance_option( option )

Returns the value of the characteristic impedance for a valid resistance string in an option line.
"""
parse_resistance_option( option ) = parse( Float64, option )

"""
    is_keyword_line( line )

Checks, if a line is a valid keyword line.

TODO: Needed for Version 2.0, which is not implemented for now.
"""
is_keyword_line( line ) = length( line ) > 0 && line[ 1 ] == '['

"""
    is_empy_line( line )

Checks, if a line is empty.
"""
is_empy_line( line ) = length( line ) == 0

"""
    parse_option_line( line )

Returns the option structure for a valid option line.
"""
function parse_option_line( line )
  line = uppercase( line )

  default = Options()
  unit        = default.unit
  parameter   = default.parameter
  format      = default.format
  resistance  = default.resistance

  entries = split( line[ 2:end ] )

  next_is_resistance = false
  for entry in entries
    if next_is_resistance
      resistance = parse_resistance_option( entry )
      next_is_resistance = false
    else
      if is_frequency_unit_option( entry )
        unit = parse_frequency_unit_option( entry )
      elseif is_parameter_option( entry )
        parameter = parse_parameter_option( entry )
      elseif is_format_option( entry )
        format = parse_format_option( entry )
      else
        next_is_resistance =  is_resistance_option( entry )
      end
    end
  end
  Options( unit, parameter, format, resistance )
end

"""
    ma2comp( m, a )

Converts a pair of values in magnitude / angle format to a complex number.
"""
ma2comp( m, a ) =  m * cis( deg2rad( a ) )

"""
    da2comp( m, a )

Converts a pair of values in dB / angle format to a complex number.
"""
da2comp( d, a ) = ma2comp( 10 ^ ( d / 20 ), a )

"Holds conversion functions for parameter format symbols when parsing."
const ParseConversions = Dict{ Symbol, Function }(
  :RealImaginary  => complex,
  :MagnitudeAngle => ma2comp,
  :DecibelAngle   => da2comp,
)

"""
    parse_data( line, N, [ options ] )

Returns a data point structure for a valid line of a one-port Touchstone file.

For 3 or more ports, the line should be the concatenation of 3 or more lines from the Touchstone file.
"""
function parse_data( line::String, N, options = Options() )
  vals = map( s -> parse( Float64, s ), split( line ) )
  parse_data( vals, N, options )
end

"""
    parse_data( vals, N, [ options ] )

Returns a data point structure for a vector of numbers from a one-port Touchstone file.

For 3 or more ports, the array should contain exactly 2N² + 1 values.
"""
function parse_data( vals::Array{Float64}, N, options = Options() )
  if length( vals ) != 2N * N + 1
    throw( error( "Wrong number of values!" ) )
  end
  freq = vals[ 1 ]  * options.unit
  pairs = zip( vals[ 2:2:end - 1 ], vals[ 3:2:end ] )
  converted = map( pair -> ParseConversions[ options.format ]( pair... ), pairs )
  res = reshape( converted, N, N )
  if N > 2
    res = permutedims( res, [ 2, 1 ] )
  end
  return DataPoint( freq, res )
end

"""
    parse_touchstone_stream( stream, [ ports ] )

Returns a TS structure for a valid Touchstone data stream.
"""
function parse_touchstone_stream( stream::IO, ports::Integer = 1 )
  options = Options()
  first_option_line = true
  comments = Vector{String}()
  data = Vector{DataPoint}()
  neededValues = 1 + 2ports * ports
  vals = Vector{Float64}()
  for line in eachline( stream )
    if is_empy_line( line )
      ;# nothing
    elseif is_keyword_line( line )
      throw( error( "Version 2.0 not implemented!" ) )
    elseif is_comment_line( line )
      push!( comments, parse_comment_line( line ) )
    elseif first_option_line && is_option_line( line )
      options = parse_option_line( line )
      first_option_line = false
    else
      vals = [ vals; map( s -> parse( Float64, s ), split( line ) ) ]
      nVals = length( vals )
      if nVals >= neededValues
        push!( data, parse_data( vals, ports, options ) )
        vals = Vector{Float64}()
      end
    end
  end
  TS( data, options, comments )
end

"""
    parse_touchstone_string( in, [ ports ] )

Returns a TS structure for a valid Touchstone data string.
"""
parse_touchstone_string( in::String, ports::Integer = 1 ) = parse_touchstone_stream( IOBuffer( in ), ports )

"""
    parse_touchstone_file( filename, [ ports ] )

Returns a TS structure for a valid Touchstone data file.

When called without ports, tries to interpret the file extension, such as ".s2p", or ".S4P".
"""
function parse_touchstone_file( filename::String, ports::Integer = 0 )
  if ports == 0
    extorig =  splitext( filename )[ 2 ][ 2: end ]
    ext = uppercase( extorig )
    if ext[ 1 ] == 'S' && ext[ end ] == 'P'
      ports = parse( Int64, ext[ 2:end - 1 ] )
    else
      throw( error( "File extension ( $( extorig ) ) not recognized, unknown number of ports." ) )
    end
  end
  open( filename ) do io
    parse_touchstone_stream( open( filename ), ports )
  end
end
