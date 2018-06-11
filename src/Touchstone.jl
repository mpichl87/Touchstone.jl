__precompile__()
module Touchstone

const units = Dict{ String, Float64 }(
    "HZ"    =>      1e0,
    "KHZ"   =>      1e3,
    "MHZ"   =>      1e6,
    "GHZ"   =>      1e9
)
const default_units = "GHZ"

const parameters = Dict{ String, String }(
    "S" => :ScatteringParameters,
    "Y" => :AdmittanceParameters,
    "Z" => :ImpedanceParameters,
    "H" => :HybridHParameters,
    "G" => :HybridGParameters,
)
const default_parameter = "S"

const formats = Dict{ String, String }(
    "DB" => :DecibelAngle,
    "MA" => :MagnitudeAngle,
    "RI" => :RealImaginary
)
const default_format = "MA"

const default_resistance = 50.0

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

export parse_touchstone_stream
function parse_touchstone_stream( stream::IO, ports::Integer = 1 )
    options = Options()
    first_option_line = true
    comments = Vector{String}()
    data = Vector{DataPoint}()
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
        end
    end
    TS( data, options, comments )
end
export parse_touchstone_string
parse_touchstone_string( in::String, ports::Integer = 1 ) = parse_touchstone_stream( IOBuffer( in ), ports )
export parse_touchstone_file
parse_touchstone_file( filename::String, ports::Integer = 1 ) = parse_touchstone_stream( open( filename ), ports )

export freqs
freqs( ts::TS ) = map( dp -> dp.frequency, ts.data )
export params
params( ts::TS, p1 = 1, p2 = 1 ) = map( dp -> dp.parameter[ p1, p2 ], ts.data )
export mags
mags( ts::TS, p1 = 1, p2 = 1 ) = map( abs, params( ts, p1, p2 ) )
export dBmags
dBmags( ts::TS, p1 = 1, p2 = 1 ) = map( x -> 20log10( abs( x ) ), params( ts, p1, p2 ) )
export angs
angs( ts::TS, p1 = 1, p2 = 1 ) = map( p -> rad2deg( angle( p ) ), params( ts, p1, p2 ) )
export reals
reals( ts::TS, p1 = 1, p2 = 1 ) = map( real, params( ts, p1, p2 ) )
export imags
imags( ts::TS, p1 = 1, p2 = 1 ) = map( imag, params( ts, p1, p2 ) )


end
