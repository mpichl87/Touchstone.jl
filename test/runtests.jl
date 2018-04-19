import Touchstone
TS = Touchstone
using Base.Test

# @test ! TS.is_comment_line( "" )
# @test   TS.is_comment_line( "!" )
# @test   TS.is_comment_line( "!comment" )
#
# @test   TS.parse_comment_line( "!" ) == ""
# @test   TS.parse_comment_line( "!comment" ) == "comment"
#
# @test ! TS.is_option_line( "" )
# @test   TS.is_option_line( "#" )
# @test   TS.is_option_line( "#options" )
#
# @test ! TS.is_frequency_unit_option( "" )
# @test   TS.is_frequency_unit_option( "Hz" )
# @test   TS.is_frequency_unit_option( "kHz" )
# @test   TS.is_frequency_unit_option( "MHz" )
# @test   TS.is_frequency_unit_option( "GHz" )
# @test   TS.is_frequency_unit_option( "hz" )
# @test   TS.is_frequency_unit_option( "khz" )
# @test   TS.is_frequency_unit_option( "mhz" )
# @test   TS.is_frequency_unit_option( "ghz" )
# @test ! TS.is_frequency_unit_option( "uHz" )
#
# @test isapprox( TS.parse_frequency_unit_option( "Hz" ), 1e0 )
# @test isapprox( TS.parse_frequency_unit_option( "kHz" ), 1e3 )
# @test isapprox( TS.parse_frequency_unit_option( "MHz" ), 1e6 )
# @test isapprox( TS.parse_frequency_unit_option( "GHz" ), 1e9 )
# @test isapprox( TS.parse_frequency_unit_option( "hz" ), 1e0 )
# @test isapprox( TS.parse_frequency_unit_option( "khz" ), 1e3 )
# @test isapprox( TS.parse_frequency_unit_option( "mhz" ), 1e6 )
# @test isapprox( TS.parse_frequency_unit_option( "ghz" ), 1e9 )
#
# @test ! TS.is_parameter_option( "" )
# @test   TS.is_parameter_option( "S" )
# @test   TS.is_parameter_option( "Y" )
# @test   TS.is_parameter_option( "Z" )
# @test   TS.is_parameter_option( "H" )
# @test   TS.is_parameter_option( "G" )
# @test   TS.is_parameter_option( "s" )
# @test   TS.is_parameter_option( "y" )
# @test   TS.is_parameter_option( "z" )
# @test   TS.is_parameter_option( "h" )
# @test   TS.is_parameter_option( "g" )
# @test ! TS.is_parameter_option( "T" )
#
# @test ! TS.is_format_option( "" )
# @test   TS.is_format_option( "DB" )
# @test   TS.is_format_option( "MA" )
# @test   TS.is_format_option( "RI" )
# @test   TS.is_format_option( "db" )
# @test   TS.is_format_option( "ma" )
# @test   TS.is_format_option( "ri" )
# @test ! TS.is_format_option( "BLA" )

@test   TS.equ( TS.parse_option_line( "#" ),              TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle,    50.0 ) )
@test   TS.equ( TS.parse_option_line( "#kHz" ),           TS.Options( 1e3, :ScatteringParameters, :MagnitudeAngle,    50.0 ) )
@test   TS.equ( TS.parse_option_line( "# kHz" ),          TS.Options( 1e3, :ScatteringParameters, :MagnitudeAngle,    50.0 ) )
@test   TS.equ( TS.parse_option_line( "#MHz Y" ),         TS.Options( 1e6, :AdmittanceParameters, :MagnitudeAngle,    50.0 ) )
@test   TS.equ( TS.parse_option_line( "# GHz Z dB" ),     TS.Options( 1e9, :ImpedanceParameters,  :DecibelAngle,      50.0 ) )
@test   TS.equ( TS.parse_option_line( "#Hz H RI R 1" ),   TS.Options( 1.0, :HybridHParameters,    :RealImaginary,      1.0 ) )
@test   TS.equ( TS.parse_option_line( "# Hz G RI R 50" ), TS.Options( 1.0, :HybridGParameters,    :RealImaginary,     50.0 ) )

@test   TS.equ( TS.Comments( [ "a" ] ), TS.Comments( [ "a" ] ) )
@test   TS.equ( TS.Comments( [ "a", "b" ] ), TS.Comments( [ "a", "b" ] ) )
@test ! TS.equ( TS.Comments( [ "b", "a" ] ), TS.Comments( [ "a", "b" ] ) )
@test ! TS.equ( TS.Comments( [ "a" ] ), TS.Comments( [ "a", "b" ] ) )

@test   TS.equ( TS.Comments(), TS.Comments( [] ) )
@test   TS.equ( TS.Options(), TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50.0 ) )
@test   TS.equ( TS.TS( TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50.0 ), TS.Comments( [] ) ), TS.TS() )

@test   TS.equ( TS.parse_touchstone_file( "" ), TS.TS() )
@test   TS.equ( TS.parse_touchstone_file( """
    !Test
    """ ), TS.TS( TS.Options(), TS.Comments( [ "Test" ] ) ) )
@test   TS.equ( TS.parse_touchstone_file( """
        !Test1

        # Hz G RI R 50
        !Test2
        """ ), TS.TS(   TS.Options( 1.0, :HybridGParameters, :RealImaginary, 50.0 ),
                        TS.Comments( [ "Test1", "Test2" ] ) ) )
@test   TS.equ( TS.parse_touchstone_file( """
        # Hz G RI R 50

        !Test1
        # GHz Z dB
        !Test2
        """ ), TS.TS(   TS.Options( 1.0, :HybridGParameters, :RealImaginary, 50.0 ),
                        TS.Comments( [ "Test1", "Test2" ] ) ) )
@test   TS.equ( TS.parse_touchstone_file( """
        # GHz Z dB
        # Hz G RI R 50
        !Test1

        !Test2
        """ ), TS.TS(   TS.Options( 1e9, :ImpedanceParameters, :DecibelAngle, 50.0 ),
                        TS.Comments( [ "Test1", "Test2" ] ) ) )



TS.Data( [ TS.DataPoint( 1.0, [ 1 2; 3 4]) ] )







@test_throws MethodError TS.parse_touchstone_file( """
        # GHz Z dB
        # Hz G RI R 50
        !Test1
        !Test2
        [test]
        """ )
