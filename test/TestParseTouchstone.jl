@test ! TS.is_comment_line( "" )
@test   TS.is_comment_line( "!" )
@test   TS.is_comment_line( "!comment" )

@test   TS.parse_comment_line( "!" ) == ""
@test   TS.parse_comment_line( "!comment" ) == "comment"

@test ! TS.is_option_line( "" )
@test   TS.is_option_line( "#" )
@test   TS.is_option_line( "#options" )

@test ! TS.is_frequency_unit_option( "" )
@test   TS.is_frequency_unit_option( "Hz" )
@test   TS.is_frequency_unit_option( "kHz" )
@test   TS.is_frequency_unit_option( "MHz" )
@test   TS.is_frequency_unit_option( "GHz" )
@test   TS.is_frequency_unit_option( "hz" )
@test   TS.is_frequency_unit_option( "khz" )
@test   TS.is_frequency_unit_option( "mhz" )
@test   TS.is_frequency_unit_option( "ghz" )
@test ! TS.is_frequency_unit_option( "uHz" )

@test TS.parse_frequency_unit_option( "Hz" )  ≈ 1e0
@test TS.parse_frequency_unit_option( "kHz" ) ≈ 1e3
@test TS.parse_frequency_unit_option( "MHz" ) ≈ 1e6
@test TS.parse_frequency_unit_option( "GHz" ) ≈ 1e9
@test TS.parse_frequency_unit_option( "hz" )  ≈ 1e0
@test TS.parse_frequency_unit_option( "khz" ) ≈ 1e3
@test TS.parse_frequency_unit_option( "mhz" ) ≈ 1e6
@test TS.parse_frequency_unit_option( "ghz" ) ≈ 1e9

@test ! TS.is_parameter_option( "" )
@test   TS.is_parameter_option( "S" )
@test   TS.is_parameter_option( "Y" )
@test   TS.is_parameter_option( "Z" )
@test   TS.is_parameter_option( "H" )
@test   TS.is_parameter_option( "G" )
@test   TS.is_parameter_option( "s" )
@test   TS.is_parameter_option( "y" )
@test   TS.is_parameter_option( "z" )
@test   TS.is_parameter_option( "h" )
@test   TS.is_parameter_option( "g" )
@test ! TS.is_parameter_option( "T" )

@test ! TS.is_format_option( "" )
@test   TS.is_format_option( "DB" )
@test   TS.is_format_option( "MA" )
@test   TS.is_format_option( "RI" )
@test   TS.is_format_option( "db" )
@test   TS.is_format_option( "ma" )
@test   TS.is_format_option( "ri" )
@test ! TS.is_format_option( "BLA" )

@test   TS.parse_option_line( "#" )               == TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle,    50.0 )
@test   TS.parse_option_line( "#kHz" )            == TS.Options( 1e3, :ScatteringParameters, :MagnitudeAngle,    50.0 )
@test   TS.parse_option_line( "# kHz" )           == TS.Options( 1e3, :ScatteringParameters, :MagnitudeAngle,    50.0 )
@test   TS.parse_option_line( "#MHz Y" )          == TS.Options( 1e6, :AdmittanceParameters, :MagnitudeAngle,    50.0 )
@test   TS.parse_option_line( "# GHz Z dB" )      == TS.Options( 1e9, :ImpedanceParameters,  :DecibelAngle,      50.0 )
@test   TS.parse_option_line( "#Hz H RI R 1" )    == TS.Options( 1.0, :HybridHParameters,    :RealImaginary,      1.0 )
@test   TS.parse_option_line( "# Hz G RI R 50" )  == TS.Options( 1.0, :HybridGParameters,    :RealImaginary,     50.0 )

@test   TS.parse_touchstone_string( "" ) == TS.TS()

@test   TS.parse_touchstone_string( """
    !Test
    """ ) == TS.TS( TS.Options(), [ "Test" ] )

@test   TS.parse_touchstone_string( """
    !Test1

    # Hz G RI R 50
    !Test2
    """ ) == TS.TS(   TS.Options( 1.0, :HybridGParameters, :RealImaginary, 50.0 ), [ "Test1", "Test2" ]  )


# Example 9 (Version 1.0):
ts = TS.parse_touchstone_string( """
    !1-port Z-parameter file, multiple frequency points
    # MHz Z MA R 75
    !freq magZ11 angZ11
    100     0.99    -4
    200     0.80    -22
    300     0.707   -45
    400     0.40    -62
    500     0.01    -89
    """ )

@test TS.freqs( ts ) ≈ collect( 1:5 ) * 100e6
@test TS.mags( ts ) ≈ [ 0.99, 0.80, 0.707, 0.4, 0.01 ]
@test TS.angs( ts ) ≈ [ -4, -22, -45, -62, -89 ]

# Example 13 (Version 1.0):
ts = TS.parse_touchstone_string( """
    !2-port S-parameter file, three frequency points
    # GHz S RI R 50.0
    !freq   ReS11   ImS11   ReS21   ImS21   ReS12   ImS12   ReS22   ImS22
    1.0000  0.3926  -0.1211 -0.0003 -0.0021 -0.0003 -0.0021 0.3926 -0.1211
    2.0000  0.3517  -0.3054 -0.0096 -0.0298 -0.0096 -0.0298 0.3517 -0.3054
    10.000  0.3419   0.3336 -0.0134  0.0379 -0.0134  0.0379 0.3419 0.3336
    """, 2 )

@test TS.freqs( ts ) ≈ [ 1e9, 2e9, 10e9 ]

@test TS.reals( ts, 1, 1 ) ≈ [ 0.3926, 0.3517, 0.3419 ]
@test TS.imags( ts, 1, 1 ) ≈ [ -0.1211, -0.3054, 0.3336 ]

@test TS.reals( ts, 2, 1 ) ≈ [ -0.0003, -0.0096, -0.0134 ]
@test TS.imags( ts, 2, 1 ) ≈ [ -0.0021, -0.0298, 0.0379 ]

@test TS.reals( ts, 1, 2 ) ≈ [ -0.0003, -0.0096, -0.0134 ]
@test TS.imags( ts, 1, 2 ) ≈ [ -0.0021, -0.0298, 0.0379 ]

@test TS.reals( ts, 2, 2 ) ≈ [ 0.3926, 0.3517, 0.3419 ]
@test TS.imags( ts, 2, 2 ) ≈ [ -0.1211, -0.3054, 0.3336 ]

ts = TS.parse_touchstone_string( """
    # GHz S RI R 50.0
    1 1.11 1.11 1.21 1.21 1.12 1.12 1.22 1.22
    2 2.11 2.11 2.21 2.21 2.12 2.12 2.22 2.22
    """, 2 )

@test TS.freqs( ts ) ≈ [ 1e9, 2e9 ]

@test TS.reals( ts, 1, 1 ) ≈ [ 1.11, 2.11 ]
@test TS.imags( ts, 1, 1 ) ≈ [ 1.11, 2.11 ]

@test TS.reals( ts, 2, 1 ) ≈ [ 1.21, 2.21 ]
@test TS.imags( ts, 2, 1 ) ≈ [ 1.21, 2.21 ]

@test TS.reals( ts, 1, 2 ) ≈ [ 1.12, 2.12 ]
@test TS.imags( ts, 1, 2 ) ≈ [ 1.12, 2.12 ]

@test TS.reals( ts, 2, 2 ) ≈ [ 1.22, 2.22 ]
@test TS.imags( ts, 2, 2 ) ≈ [ 1.22, 2.22 ]

ts = TS.parse_touchstone_string( """
    # GHz S RI R 50.0
    1   1.111 1.112 1.121 1.122 1.131 1.132
        1.211 1.212 1.221 1.222 1.231 1.232
        1.311 1.312 1.321 1.322 1.331 1.332
    2   2.111 2.112 2.121 2.122 2.131 2.132
        2.211 2.212 2.221 2.222 2.231 2.232
        2.311 2.312 2.321 2.322 2.331 2.332
    """, 3 )





#
# ts = TS.parse_touchstone_file( "test/Test_1_6.S2P", 2 )
# f = TS.freqs( ts )
# s21 = TS.dBmags( ts, 2, 1 )
#
# using Plots
#
# plot( f, s21 )
