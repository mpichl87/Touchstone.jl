__precompile__()
module Touchstone

const units = Dict{ String, Float64 }(
    "Hz"    =>      1e0,
    "kHz"   =>      1e3,
    "MHz"   =>      1e6,
    "GHz"   =>      1e9
)
const default_units = "GHz"

const parameter = Dict{ String, String }(
    "S" => "Scattering parameters",
    "Y" => "Admittance parameters",
    "Z" => "Impedance parameters",
    "H" => "Hybrid-h parameters",
    "G" => "Hybrid-g parameters"
)
const default_parameter = "S"

const format = Dict{ String, String }(
    "DB" => "decibel-angle",
    "MA" => "magnitude-angle",
    "RI" => "real-imaginary"
)
const default_format = "MA"

const default_resistance = 50.0

export Options
struct Options
    unit::Float64
    parameter::String
    format::String
    resistance::Float64
end

export parse_option_line
function parse_option_line( line::String = "" )
    unit = units[ default_units ]
    parameter = default_parameter
    format = default_format
    resistance = default_resistance
    entries = split( line )
    println( entries )
    # for entry in entries
    #
    # end
    Options( unit, parameter, format, resistance )
end

end
