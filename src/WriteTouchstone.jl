const unitstrings = Dict{ Float64, String }(
    1e0 => "Hz",
    1e3 => "kHz",
    1e6 => "MHz",
    1e9 => "GHz"
)
const default_unit_value = 1e9

const parameterstrings = Dict{ Symbol, String }(
    :ScatteringParameters   => "S",
    :AdmittanceParameters   => "Y",
    :ImpedanceParameters    => "Z",
    :HybridHParameters      => "H",
    :HybridGParameters      => "G",
)
const default_parameter_symbol = :ScatteringParameters

const formatstrings = Dict{ Symbol, String }(
     :DecibelAngle      => "dB",
     :MagnitudeAngle    => "MA",
     :RealImaginary     => "RI"
)
const default_format_symbol = :MagnitudeAngle

const default_resistance_string = "50"

write_comment_line( line ) = "!" * line

write_frequency_unit_option( value = default_unit_value ) = unitstrings[ value ]
write_parameter_option( symbol = default_parameter_symbol ) = parameterstrings[ symbol ]
write_format_option( symbol = default_format_symbol ) = formatstrings[ symbol ]
write_resistance_option( resistance = 50 ) = string( resistance )

function write_option_line( options::Options = Options() )
    "# " *
    write_frequency_unit_option( options.unit ) * " " *
    write_parameter_option( options.parameter ) * " " *
    write_format_option( options.format ) * " " *
    "R " * write_resistance_option( options.resistance )
end

compstring( z ) = string( real( z ) ) * " " * string( imag( z ) )

comp2ma( z ) = ( abs( z ), rad2deg( angle( z ) ) )

function comp2da( z )
    m, a = comp2ma( z )
    20log10( m ), a
end

pairstring( pair ) = string( pair[ 1 ] ) * " " * string( pair[ 2 ] )

mastring( z ) = pairstring( comp2ma( z ) )

dastring( z ) = pairstring( comp2da( z ) )

function write_one_port_data( data::DataPoint, options = Options() )
    format = options.format
    freqstring = string( data.frequency / options.unit )
    s11 = data.parameter[ 1, 1 ]
    if format == :RealImaginary
        datastring = compstring( s11 )
    elseif format == :MagnitudeAngle
        datastring = mastring( s11 )
    elseif format == :DecibelAngle
        datastring = dastring( s11 )
    else
        throw( error( "wrong format!" ) )
    end
    freqstring * " " * datastring
end

function write_two_port_data( data::DataPoint, options = Options() )
    format = options.format
    freqstring = string( data.frequency / options.unit )
    s11 = data.parameter[ 1, 1 ]
    s12 = data.parameter[ 1, 2 ]
    s21 = data.parameter[ 2, 1 ]
    s22 = data.parameter[ 2, 2 ]
    if format == :RealImaginary
        datastring =    compstring( s11 ) * " " *
                        compstring( s21 ) * " " *
                        compstring( s12 ) * " " *
                        compstring( s22 )
    elseif format == :MagnitudeAngle
        datastring =    mastring( s11 ) * " " *
                        mastring( s21 ) * " " *
                        mastring( s12 ) * " " *
                        mastring( s22 )
    elseif format == :DecibelAngle
        datastring =    dastring( s11 ) * " " *
                        dastring( s21 ) * " " *
                        dastring( s12 ) * " " *
                        dastring( s22 )
    else
        throw( error( "wrong format!" ) )
    end
    freqstring * " " * datastring
end


function write_three_port_data( data::DataPoint, options = Options() )
    format = options.format
    freqstring = string( data.frequency / options.unit )
    s11 = data.parameter[ 1, 1 ]
    s12 = data.parameter[ 1, 2 ]
    s13 = data.parameter[ 1, 3 ]
    s21 = data.parameter[ 2, 1 ]
    s22 = data.parameter[ 2, 2 ]
    s23 = data.parameter[ 2, 3 ]
    s31 = data.parameter[ 3, 1 ]
    s32 = data.parameter[ 3, 2 ]
    s33 = data.parameter[ 3, 3 ]
    if format == :RealImaginary
        datastring1 =   compstring( s11 ) * " " *
                        compstring( s12 ) * " " *
                        compstring( s13 )
        datastring2 =   compstring( s21 ) * " " *
                        compstring( s22 ) * " " *
                        compstring( s23 )
        datastring3 =   compstring( s31 ) * " " *
                        compstring( s32 ) * " " *
                        compstring( s33 )
    elseif format == :MagnitudeAngle
        datastring1 =   mastring( s11 ) * " " *
                        mastring( s12 ) * " " *
                        mastring( s13 )
        datastring2 =   mastring( s21 ) * " " *
                        mastring( s22 ) * " " *
                        mastring( s23 )
        datastring3 =   mastring( s31 ) * " " *
                        mastring( s32 ) * " " *
                        mastring( s33 )
    elseif format == :DecibelAngle
        datastring1 =   dastring( s11 ) * " " *
                        dastring( s12 ) * " " *
                        dastring( s13 )
        datastring2 =   dastring( s21 ) * " " *
                        dastring( s22 ) * " " *
                        dastring( s23 )
        datastring3 =   dastring( s31 ) * " " *
                        dastring( s32 ) * " " *
                        dastring( s33 )
    else
        throw( error( "wrong format!" ) )
    end
    [ freqstring * " " * datastring1, datastring2, datastring3 ]
end

function write_four_port_data( data::DataPoint, options = Options() )
    format = options.format
    freqstring = string( data.frequency / options.unit )
    s11 = data.parameter[ 1, 1 ]
    s12 = data.parameter[ 1, 2 ]
    s13 = data.parameter[ 1, 3 ]
    s14 = data.parameter[ 1, 4 ]
    s21 = data.parameter[ 2, 1 ]
    s22 = data.parameter[ 2, 2 ]
    s23 = data.parameter[ 2, 3 ]
    s24 = data.parameter[ 2, 4 ]
    s31 = data.parameter[ 3, 1 ]
    s32 = data.parameter[ 3, 2 ]
    s33 = data.parameter[ 3, 3 ]
    s34 = data.parameter[ 3, 4 ]
    s41 = data.parameter[ 4, 1 ]
    s42 = data.parameter[ 4, 2 ]
    s43 = data.parameter[ 4, 3 ]
    s44 = data.parameter[ 4, 4 ]
    if format == :RealImaginary
        datastring1 =   compstring( s11 ) * " " *
                        compstring( s12 ) * " " *
                        compstring( s13 ) * " " *
                        compstring( s14 )
        datastring2 =   compstring( s21 ) * " " *
                        compstring( s22 ) * " " *
                        compstring( s23 ) * " " *
                        compstring( s24 )
        datastring3 =   compstring( s31 ) * " " *
                        compstring( s32 ) * " " *
                        compstring( s33 ) * " " *
                        compstring( s34 )
        datastring4 =   compstring( s41 ) * " " *
                        compstring( s42 ) * " " *
                        compstring( s43 ) * " " *
                        compstring( s44 )
    elseif format == :MagnitudeAngle
        datastring1 =   mastring( s11 ) * " " *
                        mastring( s12 ) * " " *
                        mastring( s13 ) * " " *
                        mastring( s14 )
        datastring2 =   mastring( s21 ) * " " *
                        mastring( s22 ) * " " *
                        mastring( s23 ) * " " *
                        mastring( s24 )
        datastring3 =   mastring( s31 ) * " " *
                        mastring( s32 ) * " " *
                        mastring( s33 ) * " " *
                        mastring( s34 )
        datastring4 =   mastring( s41 ) * " " *
                        mastring( s42 ) * " " *
                        mastring( s43 ) * " " *
                        mastring( s44 )
    elseif format == :DecibelAngle
        datastring1 =   dastring( s11 ) * " " *
                        dastring( s12 ) * " " *
                        dastring( s13 ) * " " *
                        dastring( s14 )
        datastring2 =   dastring( s21 ) * " " *
                        dastring( s22 ) * " " *
                        dastring( s23 ) * " " *
                        dastring( s24 )
        datastring3 =   dastring( s31 ) * " " *
                        dastring( s32 ) * " " *
                        dastring( s33 ) * " " *
                        dastring( s34 )
        datastring4 =   dastring( s41 ) * " " *
                        dastring( s42 ) * " " *
                        dastring( s43 ) * " " *
                        dastring( s44 )
    else
        throw( error( "wrong format!" ) )
    end
    [ freqstring * " " * datastring1, datastring2, datastring3, datastring4 ]
end

struct TS
    data::Vector{DataPoint}
    options::Options
    comments::Vector{String}
end

export write_touchstone_stream
function write_touchstone_stream( stream::IO, ts::TS )
    for comment in ts.comments
        write( stream, write_comment_line( comment ) )
        write( stream, "\n" )
    end

    writeln( stream, write_option_line( ts.options ) )

    ports = size( ts.data, 1 )

    for datapoint in ts.data
        if ports == 1
            write( stream, write_one_port_data( datapoint, ts.options ) )
            write( stream, "\n" )
        elseif ports == 2
            write( stream, write_two_port_data( datapoint, ts.options ) )
            write( stream, "\n" )
        elseif ports == 3
            for line in write_three_port_data( datapoint, ts.options )
                write( stream, line )
                write( stream, "\n" )
            end
        elseif ports == 4
            for line in write_four_port_data( datapoint, ts.options )
                write( stream, line )
                write( stream, "\n" )
            end
        end
    end
end

export write_touchstone_string
function write_touchstone_string( ts::TS )
    buffer = IOBuffer()
    write_touchstone_stream( buffer, ts )
    String( take!( copy( buffer ) ) )
end

export write_touchstone_file
write_touchstone_file( filename::String, ts::TS ) = write_touchstone_stream( open( filename, "w+" ), ts )
