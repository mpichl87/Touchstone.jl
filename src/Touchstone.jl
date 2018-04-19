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

struct Options
    unit::Float64
    parameter::Symbol
    format::Symbol
    resistance::Float64
end
Options() = Options( units[ default_units ], parameters[ default_parameter ], formats[ default_format ], default_resistance )
function equ( o1, o2 :: Options )
    isapprox( o1.unit, o2.unit ) &&
    o1.parameter == o2.parameter &&
    o1.format == o2.format &&
    isapprox( o1.resistance, o2.resistance )
end

struct Comments
    lines::Vector{String}
end
Comments() = Comments( [] )
equ( c1, c2 :: Comments ) = c1.lines == c2.lines

struct DataPoint
    frequency::Float64
    parameter::Matrix{Float64}
end

struct Data
    points::Vector{DataPoint}
end

struct TS
    options::Options
    comments::Comments
end
TS() = TS( Options(), Comments() )
function equ( ts1, ts2 :: TS )
    equ( ts1.options, ts2.options ) &&
    equ( ts1.comments, ts2.comments )
end

is_comment_line( line ) = length( line ) > 0 && line[ 1 ] == '!'

parse_comment_line( line ) = line[ 2:end ]

is_option_line( line ) = length( line ) > 0 && line[ 1 ] == '#'

is_frequency_unit_option( option ) = haskey( units, option )

parse_frequency_unit_option( option ) = units[ option ]

is_parameter_option( option ) = haskey( parameters, option )

parse_parameter_option( option ) = parameters[ option ]

is_format_option( option ) = haskey( formats, option )

parse_format_option( option ) = formats[ option ]

is_resistance_option( option ) = option == "R"

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

function parse_touchstone_file( stream::IO )
    options = Options()
    first_option_line = true
    comments = []
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
        end
    end
    TS( options, Comments( comments ) )
end
parse_touchstone_file( in::String ) = parse_touchstone_file( IOBuffer( in ) )

end
