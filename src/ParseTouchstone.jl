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
function parse_data( vals::Array{Float64}, N, options = Options(), twoPortDataFlipped = true )
  if length( vals ) != 2N * N + 1
    error( "Wrong number of values!" )
  end
  freq = vals[ 1 ]  * options.unit
  pairs = zip( vals[ 2:2:end - 1 ], vals[ 3:2:end ] )
  converted = map( pair -> ParseConversions[ options.format ]( pair... ), pairs )
  res = reshape( converted, N, N )
  if N > 2 || ( N == 2 && !twoPortDataFlipped )
    res = permutedims( res, [ 2, 1 ] )
  end
  return DataPoint( freq, res )
end

"""
    parse_touchstone_stream( stream, [ ports ] )

Returns a TouchstoneData structure for a valid Touchstone data stream.
"""
function parse_touchstone_stream( stream::IO, ports::Integer = 1 )
  version = 1
  options = Options()
  option_line_found = false
  comments = Vector{ String }()
  data = Vector{ DataPoint }()
  noiseData = Vector{ NoiseDataPoint }()
  neededValues = 1 + 2ports * ports
  vals = Vector{ Float64 }()
  keywordparams = Dict{ Symbol, Any }()
  networkdata = false
  noiseDataExpected = false
  twoPortDataFlipped = true
  referenceNextLine = false
  endfound = false
  for line in eachline( stream )
    if referenceNextLine
      keywordparams[ :Reference ] = parse_reference( split( line ) )
      if length( keywordparams[ :Reference ] ) != ports
        error( "V2.0: $ports parameters for [Reference] expected.")
      end
      referenceNextLine = false
    elseif is_empy_line( line )
      ;# nothing
    elseif is_keyword_line( line )
      version = 2
      keyword, params = parse_keyword_line( line )
      keywordparams[ keyword ] = params
      if option_line_found && keyword == :Version
        error( "V2.0: [Version] 2.0 before option line expected." )
      end
      if keyword in unOrderedKeywordSymbols
        keywordString = keywordSymbolStrings[ keyword ]
        if !haskey( keywordparams, :Version ) || keywordparams[ :Version ] != 2
          error( "V2.0: [Version] keyword before [$( keywordString )] keyword expected." )
        end
        if !option_line_found
          error( "V2.0: Option line before [$( keywordString )] keyword expected." )
        end
        if !haskey( keywordparams, :NumberOfPorts )
          error( "V2.0: [Number of Ports] keyword before [$( keywordString )] keyword expected." )
        end
        if haskey( keywordparams, :NetworkData )
          error( "V2.0: [Network Data] keyword after [$( keywordString )] keyword expected." )
        end
      end
      if keyword == :Reference
        if length( keywordparams[ :Reference ] ) == 0
          referenceNextLine = true
        elseif length( keywordparams[ :Reference ] ) != ports
          error( "V2.0: $ports parameters for [Reference] expected.")
        end
      elseif keyword == :NetworkData
        networkdata = true
        if haskey( keywordparams, :NoiseData )
          error( "V2.0: [Noise Data] keyword after [Network Data] keyword expected." )
        end
        if !haskey( keywordparams, :NumberOfFrequencies )
          error( "V2.0: [Number of Frequencies] keyword before [Network Data] keyword expected." )
        end
        if ports == 2 && !haskey( keywordparams, :TwoPortDataOrder )
          error( "V2.0: [Two-Port Data Order] expected for two port data." )
        end
      elseif keyword == :NumberOfPorts
        ports = keywordparams[ :NumberOfPorts ]
        neededValues = 1 + 2ports * ports
        if ports != 2
          if options.parameter in [ :HybridHParameters, :HybridGParameters ]
            error( "$( parameterstrings[ options.parameter ] ) parameter format for $( ports )-port files not allowed." )
          end
        end
      elseif keyword == :TwoPortDataOrder
        if ports != 2
          error( "V2.0: [Two-Port Data Order] keyword not allowed for $(ports) port data." )
        end
        dataOrder = keywordparams[ :TwoPortDataOrder ]
        if dataOrder == "12_21"
          twoPortDataFlipped = true
        elseif dataOrder == "21_12"
          twoPortDataFlipped = false
        else
          error( "V2.0: Unknown parameter '$dataOrder' for [Two-Port Data Order] keyword." )
        end
      elseif keyword == :MixedModeOrder
        if options.parameter in [ :HybridHParameters, :HybridGParameters ]
          error( "[Mixed-Mode Order] keyword for $( parameterstrings[ options.parameter ] ) parameter format not allowed." )
        end
      elseif keyword == :NoiseData
        if ports != 2
          error( "V2.0: [NoiseData] keyword not allowed for $(ports) port data." )
        end
        noiseDataExpected   = true
        networkdata = false
      elseif keyword == :End
        networkdata = false
        noiseDataExpected   = false
        endfound = true
      end
    elseif is_comment_line( line )
      push!( comments, parse_comment_line( line ) )
    elseif !option_line_found && is_option_line( line )
      if haskey( keywordparams, :Version ) && keywordparams[ :Version ] == 2 && haskey( keywordparams, :NumberOfPorts )
        error( "V2.0: Option line before [Number of Ports] keyword expected." )
      end
      options = parse_option_line( line )
      if version == 1 && ports != 2
        if options.parameter in [ :HybridHParameters, :HybridGParameters ]
          error( "$( parameterstrings[ options.parameter ] ) parameter format for $( ports )-port files not allowed." )
        end
      end
      option_line_found = true
    elseif !haskey( keywordparams, :Version ) || ( keywordparams[ :Version ] == 2 && networkdata )
      strings = split( line, "!" )
      if length( strings ) > 1
        comment = join( strings[ 2:end ], "!" )
        push!( comments, comment )
        line = strings[ 1 ]
      end
      newVals = map( s -> parse( Float64, s ), split( line ) )
      if version == 1
        # V1.0: not more then 4 value pairs per line. (#7)
        # The first  line contains the frequency.
        maxVals = length( vals ) == 0 ? 9 : 8
        if length( newVals ) > maxVals
          error( "V1.0: more than four complex values in one parameter line." )
        end
      end
      vals = [ vals; newVals ]
      if length( vals ) >= neededValues
        push!( data, parse_data( vals, ports, options, twoPortDataFlipped ) )
        vals = Vector{Float64}()
      end
    elseif endfound
      error( "V2.0: Non empty or comment line found after [End] keyword." )
    end
  end
  if haskey( keywordparams, :Version ) && keywordparams[ :Version ] == 2
    frequs = keywordparams[ :NumberOfFrequencies ]
    if length( data ) != frequs
      error( "V2.0: $( frequs ) data rows expected, $( length( data ) ) found." )
    end
  end
  ret = TouchstoneData( data, noiseData, options, comments, keywordparams )
  return ret
end

"""
    parse_touchstone_string( in, [ ports ] )

Returns a TouchstoneData structure for a valid Touchstone data string.
"""
parse_touchstone_string( in::String, ports::Integer = 1 ) = parse_touchstone_stream( IOBuffer( in ), ports )

"""
    parse_touchstone_file( filename, [ ports ] )

Returns a TouchstoneData structure for a valid Touchstone data file.

When called without ports, tries to interpret the file extension, such as ".s2p", or ".S4P".
"""
function parse_touchstone_file( filename::String, ports::Integer = 0 )
  if ports == 0
    extorig =  splitext( filename )[ 2 ][ 2: end ]
    ext = uppercase( extorig )
    if ext[ 1 ] == 'S' && ext[ end ] == 'P'
      ports = parse( Int64, ext[ 2:end - 1 ] )
    else
      error( "File extension ( $( extorig ) ) not recognized, unknown number of ports." )
    end
  end
  open( filename ) do io
    parse_touchstone_stream( open( filename ), ports )
  end
end

# V2.0
"Symbols for different keywords"
const keywordStringSymbols = Dict{ String, Symbol }(
  "VERSION"         => :Version,
  "NUMBER OF PORTS" => :NumberOfPorts,
  "TWO-PORT DATA ORDER"         => :TwoPortDataOrder,
  "NUMBER OF FREQUENCIES"       => :NumberOfFrequencies,
  "NUMBER OF NOISE FREQUENCIES" => :NumberOfNoiseFrequencies,
  "REFERENCE"         => :Reference,
  "MATRIX FORMAT"     => :MatrixFormat,
  "MIXED-MODE ORDER"  => :MixedModeOrder,
  "BEGIN INFORMATION" => :BeginInformation,
  "END INFORMATION"   => :EndInformation,
  "NETWORK DATA"      => :NetworkData,
  "NOISE DATA"        => :NoiseData,
  "END"   => :End,
)

const keywordSymbolStrings = Dict{ Symbol, String }(
  :Version        => "Version",
  :NumberOfPorts  => "Number of Ports",
  :TwoPortDataOrder         => "Two-Port Data Order",
  :NumberOfFrequencies      => "Number of Frequencies",
  :NumberOfNoiseFrequencies => "Number of Noise Frequencies",
  :Reference        => "Reference",
  :MatrixFormat     => "Matrix Format",
  :MixedModeOrder   => "Mixed-Mode Order",
  :BeginInformation => "Begin Information",
  :EndInformation   => "End Information",
  :NetworkData      => "Network Data",
  :NoiseData  => "NoiseData",
  :End        => "End",
)

const unOrderedKeywordSymbols = [
  :TwoPortDataOrder,
  :NumberOfFrequencies,
  :NumberOfNoiseFrequencies,
  :Reference,
  :MatrixFormat,
  :MixedModeOrder,
  :BeginInformation,
  :EndInformation,
]

"""
    is_keyword_line( line )

Checks, if a line is a valid keyword line.
"""
is_keyword_line( line::String ) = length( line ) > 0 && line[ 1 ] == '['

function parse_N_params( params, N::Integer, tp::DataType = String )
  if length( params ) != N
    error( "Exactly $( N ) parameter expected." )
  else
    if tp != String
      params = map( x -> parse( tp, x ), params )
    end
    if N == 1
      params = params[ 1 ]
    end
    return params
  end
end


function parse_N_params( params, tp::DataType )
  N = length( params )
  if tp != String
    params = map( x -> parse( tp, x ), params )
  end
end

function parse_version_params( params )
  versionstring = parse_N_params( params, 1 )
  if versionstring == "2.0"
    return 2
  else
    error( "Unknown version $( versionstring )" )
  end
end

parse_number_of_ports( params ) = parse_N_params( params, 1, Int64 )
parse_two_port_data_order( params )  = parse_N_params( params, 1 )
parse_number_of_frequencies( params )       = parse_N_params( params, 1, Int64 )
parse_number_of_noise_frequencies( params ) = parse_N_params( params, 1, Int64 )
parse_reference( params )         = parse_N_params( params, Float64 )
parse_matrix_format( params )     = []
parse_mixed_mode_order( params )  = []
parse_begin_information( params ) = []
parse_end_information( params )   = []
parse_network_data( params )  = []
parse_noise_data( params )  = []
parse_end( params )  = []

const version_param_parsers = Dict{ Symbol, Function }(
  :Version        => parse_version_params,
  :NumberOfPorts  => parse_number_of_ports,
  :TwoPortDataOrder          => parse_two_port_data_order,
  :NumberOfFrequencies       => parse_number_of_frequencies,
  :NumberOfNoiseFrequencies  => parse_number_of_noise_frequencies,
  :Reference      => parse_reference,
  :MatrixFormat   => parse_matrix_format,
  :MixedModeOrder => parse_mixed_mode_order,
  :BeginInformation => parse_begin_information,
  :EndInformation   => parse_end_information,
  :NetworkData      => parse_network_data,
  :NoiseData  => parse_noise_data,
  :End        => parse_end,
)

"""
    parse_keyword_line( line )

Returns the keyword parameters for a keyword line.
"""
function parse_keyword_line( line )
  keyword, paramstring = split( line[ 2:end ], "]" )
  keyword = uppercase( keyword )
  params = split( paramstring )
  if haskey( keywordStringSymbols, keyword )
    kwSymbol = keywordStringSymbols[ keyword ]
    params = version_param_parsers[ kwSymbol ]( params )
  else
    error( "Not a valid keyword." )
  end
  return kwSymbol, params
end
