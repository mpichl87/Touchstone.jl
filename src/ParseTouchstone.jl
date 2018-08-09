
is_comment_line( line ) = length( line ) > 0 && line[ 1 ] == '!'

parse_comment_line( line ) = line[ 2:end ]

is_option_line( line ) = length( line ) > 0 && line[ 1 ] == '#'

is_frequency_unit_option( option ) = haskey( units,  uppercase( option ) )

parse_frequency_unit_option( option ) = units[ uppercase( option ) ]

is_parameter_option( option ) = haskey( parameters, uppercase( option ) )

parse_parameter_option( option ) = parameters[ uppercase( option ) ]

is_format_option( option ) = haskey( formats, uppercase( option ) )

parse_format_option( option ) = formats[ uppercase( option ) ]

is_resistance_option( option ) = uppercase( option ) == "R"

parse_resistance_option( option ) = parse( Float64, option )

# Version 2.0 not implemented:
is_keyword_line( line ) = length( line ) > 0 && line[ 1 ] == '['

is_empy_line( line ) = length( line ) == 0


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

ma2comp( m, a ) =  m * cis( deg2rad( a ) )

da2comp( d, a ) = ma2comp( 10 ^ ( d / 20 ), a )

function parse_one_port_data( line, options = Options() )
    format = options.format
    values = map( s -> parse( Float64, s ), split( line ) )
    freq = values[ 1 ]  * options.unit
    if format == :RealImaginary
        data = complex( values[ 2 ],values[ 3 ] )
    elseif format == :MagnitudeAngle
        data = ma2comp( values[ 2 ], values[ 3 ] )
    elseif format == :DecibelAngle
        data = da2comp( values[ 2 ], values[ 3 ] )
    else
        throw( error( "wrong format!" ) )
    end
    DataPoint( freq, fill( data, 1, 1 ) )
end

function parse_two_port_data( line, options = Options() )
    format = options.format
    values = map( s -> parse( Float64, s ), split( line ) )
    freq = values[ 1 ]  * options.unit
    if format == :RealImaginary
        data11 = complex( values[ 2 ],values[ 3 ] )
        data21 = complex( values[ 4 ],values[ 5 ] )
        data12 = complex( values[ 6 ],values[ 7 ] )
        data22 = complex( values[ 8 ],values[ 9 ] )
    elseif format == :MagnitudeAngle
        data11 = ma2comp( values[ 2 ],values[ 3 ] )
        data21 = ma2comp( values[ 4 ],values[ 5 ] )
        data12 = ma2comp( values[ 6 ],values[ 7 ] )
        data22 = ma2comp( values[ 8 ],values[ 9 ] )
    elseif format == :DecibelAngle
        data11 = da2comp( values[ 2 ],values[ 3 ] )
        data21 = da2comp( values[ 4 ],values[ 5 ] )
        data12 = da2comp( values[ 6 ],values[ 7 ] )
        data22 = da2comp( values[ 8 ],values[ 9 ] )
    else
        throw( error( "wrong format!" ) )
    end
    DataPoint( freq, [ data11 data12; data21 data22 ] )
end

function parse_three_port_data( string, options = Options() )
    println( "parse_three_port_data; string: $( string )" )
    format = options.format
    values = map( s -> parse( Float64, s ), split( string ) )
    freq = values[ 1 ]  * options.unit
    if format == :RealImaginary
        data11 = complex( values[ 2  ],values[ 3  ] )
        data12 = complex( values[ 4  ],values[ 5  ] )
        data13 = complex( values[ 6  ],values[ 7  ] )
        data21 = complex( values[ 8  ],values[ 9  ] )
        data22 = complex( values[ 10 ],values[ 11 ] )
        data23 = complex( values[ 12 ],values[ 13 ] )
        data31 = complex( values[ 14 ],values[ 15 ] )
        data32 = complex( values[ 16 ],values[ 17 ] )
        data33 = complex( values[ 18 ],values[ 19 ] )
    elseif format == :MagnitudeAngle
        data11 = ma2comp( values[ 2 ],values[ 3 ] )
        data12 = ma2comp( values[ 4  ],values[ 5  ] )
        data13 = ma2comp( values[ 6  ],values[ 7  ] )
        data21 = ma2comp( values[ 8  ],values[ 9  ] )
        data22 = ma2comp( values[ 10 ],values[ 11 ] )
        data23 = ma2comp( values[ 12 ],values[ 13 ] )
        data31 = ma2comp( values[ 14 ],values[ 15 ] )
        data32 = ma2comp( values[ 16 ],values[ 17 ] )
        data33 = ma2comp( values[ 18 ],values[ 19 ] )
    elseif format == :DecibelAngle
        data11 = da2comp( values[ 2 ],values[ 3 ] )
        data12 = da2comp( values[ 4  ],values[ 5  ] )
        data13 = da2comp( values[ 6  ],values[ 7  ] )
        data21 = da2comp( values[ 8  ],values[ 9  ] )
        data22 = da2comp( values[ 10 ],values[ 11 ] )
        data23 = da2comp( values[ 12 ],values[ 13 ] )
        data31 = da2comp( values[ 14 ],values[ 15 ] )
        data32 = da2comp( values[ 16 ],values[ 17 ] )
        data33 = da2comp( values[ 18 ],values[ 19 ] )
    else
        throw( error( "wrong format!" ) )
    end
    DataPoint( freq, [ data11 data12 data13; data21 data22 data23; data31 data32 data33 ] )
end

export parse_touchstone_stream
function parse_touchstone_stream( stream::IO, ports::Integer = 1 )
    options = Options()
    first_option_line = true
    comments = Vector{String}()
    data = Vector{DataPoint}()
    multiline = Vector{String}()
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
        elseif ports == 1
            push!( data, parse_one_port_data( line, options ) )
        elseif ports == 2
            push!( data, parse_two_port_data( line, options ) )
        elseif ports == 3
            push!( multiline, line )
            lines = length( multiline )
            if lines == 3
                string = join( lines, " " )
                push!( data, parse_three_port_data( string, options ) )
                multiline = Vector{String}()
            end
        end
    end
    TS( data, options, comments )
end
export parse_touchstone_string
parse_touchstone_string( in::String, ports::Integer = 1 ) = parse_touchstone_stream( IOBuffer( in ), ports )
export parse_touchstone_file
parse_touchstone_file( filename::String, ports::Integer = 1 ) = parse_touchstone_stream( open( filename ), ports )
