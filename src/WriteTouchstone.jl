"String for unit multiplier in option line"
const unitstrings = Dict{ Float64, String }(
  1e0 => "Hz",
  1e3 => "kHz",
  1e6 => "MHz",
  1e9 => "GHz"
)
"Default unit value to use in option line."
const default_unit_value = 1e9

"Strings for parameter format symbols in option line."
const parameterstrings = Dict{ Symbol, String }(
  :ScatteringParameters   => "S",
  :AdmittanceParameters   => "Y",
  :ImpedanceParameters    => "Z",
  :HybridHParameters      => "H",
  :HybridGParameters      => "G",
)
"Defaoult parameter format symbo to use in option line."
const default_parameter_symbol = :ScatteringParameters

"String for data format symbols in option line."
const formatstrings = Dict{ Symbol, String }(
 :DecibelAngle      => "dB",
 :MagnitudeAngle    => "MA",
 :RealImaginary     => "RI"
)
"Default data format symbol to use in option line."
const default_format_symbol = :MagnitudeAngle

"Default characteristic iimpedance to use in option line."
const default_resistance_string = "50"

"""
    write_comment_line( comment )

Returns a comment line string for a comment.
"""
write_comment_line( comment ) = "!" * comment

"""
    write_frequency_unit_option( [ value ] )

Returns an option line string for a valid frequency unit multiplier.
"""
write_frequency_unit_option( value = default_unit_value ) = unitstrings[ value ]

"""
    write_parameter_option( [ symbol ] )

Returns an option line string for a valid parameter option symbol.
"""
write_parameter_option( symbol = default_parameter_symbol ) = parameterstrings[ symbol ]

"""
    write_format_option( [ symbol ] )

Returns an option line string for a valid data format symbol.
"""
write_format_option( symbol = default_format_symbol ) = formatstrings[ symbol ]

"""
    write_resistance_option( [ resistance ] )

Returns an option line string for the characteristic impedance.
"""
write_resistance_option( resistance = 50 ) = string( resistance )


"""
     write_option_line( [ options ] )

Returns the option line string for an option structure.
"""
function write_option_line( options::Options = Options() )
  "# " *
  write_frequency_unit_option( options.unit ) * " " *
  write_parameter_option( options.parameter ) * " " *
  write_format_option( options.format ) * " " *
  "R " * write_resistance_option( options.resistance )
end

"""
    compstring( z )

Returns a pair with the real and imaginary components of a complex number.
"""
compstring( z ) = string( real( z ) ) * " " * string( imag( z ) )

"""
    comp2ma( z )

Returns a pair with the linear magnitude and angle in degrees of a complex number.
"""
comp2ma( z ) = ( abs( z ), rad2deg( angle( z ) ) )

"""
    comp2da( z )

Returns a pair with the magnitude in dB and angle in degrees of a complex number.
"""
function comp2da( z )
  m, a = comp2ma( z )
  20log10( m ), a
end

"""
    pairstring( pair )

Returns a string combining the components of a pair.
"""
pairstring( pair ) = string( pair[ 1 ] ) * " " * string( pair[ 2 ] )

"""
    mastring( z )

Returns a string in magnitude / angle format of a complex number.
"""
mastring( z ) = pairstring( comp2ma( z ) )

"""
    dastring( z )

Returns a string in dB / angle format of a complex number.
"""
dastring( z ) = pairstring( comp2da( z ) )

"Holds conversion functions for parameter format symbols when writing."
const WriteConversions = Dict{ Symbol, Function }(
  :RealImaginary  => compstring,
  :MagnitudeAngle => mastring,
  :DecibelAngle   => dastring
)

"""
    write_data( data, N [ options ] )

Returns a string for N-port Touchstone formated lines for a data point.
"""
function write_data( data::DataPoint, N::Integer, options::Options = Options() )
  freqstring = string( data.frequency / options.unit )
  if N == 2
    paras = reshape( data.parameter, 1, 4 )
    lines = 1
  else
    paras = data.parameter
    lines = N
  end
  strings = map( snn -> WriteConversions[ options.format ]( snn ), paras )
  datastrings = ones( String, lines )
  for row in 1:lines
    # V 1.0 not more than 4 pairs ( + freq ) in a line
    if N > 4
      for col in 1:N
        if col > 0 && col % 4 == 0
          strings[ row, col ] *= "\n"
        end
      end
    end
    datastrings[ row ] = replace( join( strings[ row, : ], " " ), "\n " => "\n" )
  end
  datastrings[ 1 ] = freqstring * " " * datastrings[ 1 ]
  datastring = join( datastrings, "\n" )
  if datastring[ end ] == "\n"
    return datastring
  else
    return datastring * "\n"
  end
end

"""
    write_touchstone_stream( stream, ts )

Writes formated Touchstone data for a TouchstoneData structure to a stream.
"""
function write_touchstone_stream( stream::IO, ts::TouchstoneData )
  for comment in ts.comments
    write( stream, write_comment_line( comment ) )
    write( stream, "\n" )
  end

  write( stream, write_option_line( ts.options ) )
  write( stream, "\n" )

  ports = -1
  if size( ts.data, 1 ) > 0
    ports = size( ts.data[ 1 ].parameter, 1 )
  end

  for datapoint in ts.data
    write( stream, write_data( datapoint, ports, ts.options ) )
  end
end

"""
    write_touchstone_string( ts )

Returns a string with formated Touchstone data for a TouchstoneData structure.
"""
function write_touchstone_string( ts::TouchstoneData )
  buffer = IOBuffer()
  write_touchstone_stream( buffer, ts )
  String( take!( copy( buffer ) ) )
end

"""
    write_touchstone_file( filename, ts )

Writes formated Touchstone data for a TouchstoneData structure to a file.
"""
function write_touchstone_file( filename::String, ts::TouchstoneData )
  open( filename, "w" ) do io
    write_touchstone_stream( io, ts )
  end
end
