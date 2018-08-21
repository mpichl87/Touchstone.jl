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
#
@test TS.parse_data( "100 0.99 -4", 1, TS.Options( 1, :ScatteringParameters, :RealImaginary, 1 ) ).parameter ==
  fill( 0.99 -4im, 1, 1 )

@test TS.parse_data( "100 0.99 -4", 1, TS.Options( 1, :ScatteringParameters, :MagnitudeAngle, 1 ) ).parameter ==
  fill( 0.987588409757226 - 0.06905890900668404im, 1, 1 )

@test TS.parse_data( "100 0.99 -4", 1, TS.Options( 1, :ScatteringParameters, :DecibelAngle, 1 ) ).parameter ==
  fill( 1.117997390454142 - 0.07817799327562218im, 1, 1 )


@test TS.parse_data( "1 2 3 4 5 6 7 8 9", 2, TS.Options( 1, :ScatteringParameters, :RealImaginary, 1 ) ).parameter ==
  [
    2.0+3im 6.0+7im;
    4.0+5im 8.0+9im
  ]

@test TS.parse_data( "1 2 3 4 5 6 7 8 9", 2, TS.Options( 1, :ScatteringParameters, :MagnitudeAngle, 1 ) ).parameter ==
  [
    1.9972590695091477 + 0.10467191248588767im  5.955276909847932 + 0.7312160604308848im;
    3.984778792366982 + 0.34862297099063266im   7.901506724761102 + 1.251475720321847im
  ]

@test TS.parse_data( "1 2 3 4 5 6 7 8 9", 2, TS.Options( 1, :ScatteringParameters, :DecibelAngle, 1 ) ).parameter ==
  [
    1.2572000982707197 + 0.06588706526478959im  1.9803899322373166 + 0.2431613082462919im;
    1.5788621953714619 + 0.1381325433646555im   2.4809609413011393 + 0.39294561015501567im
  ]

@test TS.parse_data(
  "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19", 3,
  TS.Options( 1, :ScatteringParameters, :RealImaginary, 1 ) ).parameter ==
  [
    2.0 + 3.0im   4.0 + 5.0im   6.0 + 7.0im;
    8.0 + 9.0im   10.0 + 11.0im 12.0 + 13.0im;
    14.0 + 15.0im 16.0 + 17.0im 18.0 + 19.0im
  ]

@test TS.parse_data(
  "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19", 3,
  TS.Options( 1, :ScatteringParameters, :MagnitudeAngle, 1 ) ).parameter ==
  [
    1.9972590695091477 + 0.10467191248588767im 3.984778792366982 + 0.34862297099063266im 5.955276909847932 + 0.7312160604308848im;
    7.901506724761102 + 1.251475720321847im 9.81627183447664 + 1.908089953765448im 11.692440777422823 + 2.69941265212638im;
    13.522961568046956 + 3.6234666314352904im 15.300876095408567 + 4.677947275563788im 17.019334360787703 + 5.860226780228821im
  ]


@test TS.parse_data(
  "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19", 3,
  TS.Options( 1, :ScatteringParameters, :DecibelAngle, 1 ) ).parameter ==
  [
    1.2572000982707197 + 0.06588706526478959im 1.5788621953714619 + 0.1381325433646555im 1.9803899322373166 + 0.2431613082462919im;
    2.4809609413011393 + 0.39294561015501567im 3.1041777128305554 + 0.6033910234384192im 3.879037095636778 + 0.8955462775786209im;
    4.841096927669552 + 1.2971680122498457im 6.033875093362162 + 1.8447407441300518im 7.510521010548225 + 2.5860797741239554im
  ]

@test TS.parse_data(
     "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33", 4,
     TS.Options( 1, :ScatteringParameters, :RealImaginary, 1 ) ).parameter ==
  [
    2.0 + 3.0im 4.0 + 5.0im 6.0 + 7.0im 8.0 + 9.0im;
    10.0 + 11.0im 12.0 + 13.0im 14.0 + 15.0im 16.0 + 17.0im;
    18.0 + 19.0im 20.0 + 21.0im 22.0 + 23.0im 24.0 + 25.0im;
    26.0 + 27.0im 28.0 + 29.0im 30.0 + 31.0im 32.0 + 33.0im
  ]

@test TS.parse_data(
     "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33", 4,
     TS.Options( 1, :ScatteringParameters, :MagnitudeAngle, 1 ) ).parameter ==
  [
    1.9972590695091477 + 0.10467191248588767im 3.984778792366982 + 0.34862297099063266im 5.955276909847932 + 0.7312160604308848im 7.901506724761102 + 1.251475720321847im;
    9.81627183447664 + 1.908089953765448im 11.692440777422823 + 2.69941265212638im 13.522961568046956 + 3.6234666314352904im 15.300876095408567 + 4.677947275563788im;
    17.019334360787703 + 5.860226780228821im 18.671608529944034 + 7.167358990906005im 20.251106775953687+ 8.596084826764024im 21.751386888879598 + 10.142838281776786im;
    23.166169628897567 + 11.803752993228215im 24.48935179990308 + 13.574669366897437im 25.71501902106337 + 15.451142247301625im 26.83745817425357 + 17.428449120480867im
  ]

@test TS.parse_data(
     "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33", 4,
     TS.Options( 1, :ScatteringParameters, :DecibelAngle, 1 ) ).parameter ==
  [
    1.2572000982707197 + 0.06588706526478959im 1.5788621953714619 + 0.1381325433646555im 1.9803899322373166 + 0.2431613082462919im 2.4809609413011393 + 0.39294561015501567im;
    3.1041777128305554 + 0.6033910234384192im 3.879037095636778 + 0.8955462775786209im 4.841096927669552 + 1.2971680122498457im 6.033875093362162 + 1.8447407441300518im;
    7.510521010548225 + 2.5860797741239554im 9.335804264972017 + 3.5836794954530027im 11.588469516911433 + 4.919013468341587im 14.36401041948883 + 6.698048060425835im;
    17.77791740104458 + 9.058301354842067im 21.969453750943302 + 12.17786706962086im 27.106010060371215 + 16.286933984241927im 33.388076683124744 + 21.68247052028196im
  ]


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

@test TS.freqs( ts ) ≈ [ 1e9, 2e9 ]

@test TS.reals( ts, 1, 1 ) ≈ [ 1.111, 2.111 ]
@test TS.imags( ts, 1, 1 ) ≈ [ 1.112, 2.112 ]

@test TS.reals( ts, 1, 2 ) ≈ [ 1.121, 2.121 ]
@test TS.imags( ts, 1, 2 ) ≈ [ 1.122, 2.122 ]

@test TS.reals( ts, 1, 3 ) ≈ [ 1.131, 2.131 ]
@test TS.imags( ts, 1, 3 ) ≈ [ 1.132, 2.132 ]

@test TS.reals( ts, 2, 1 ) ≈ [ 1.211, 2.211 ]
@test TS.imags( ts, 2, 1 ) ≈ [ 1.212, 2.212 ]

@test TS.reals( ts, 2, 2 ) ≈ [ 1.221, 2.221 ]
@test TS.imags( ts, 2, 2 ) ≈ [ 1.222, 2.222 ]

@test TS.reals( ts, 2, 3 ) ≈ [ 1.231, 2.231 ]
@test TS.imags( ts, 2, 3 ) ≈ [ 1.232, 2.232 ]

@test TS.reals( ts, 3, 1 ) ≈ [ 1.311, 2.311 ]
@test TS.imags( ts, 3, 1 ) ≈ [ 1.312, 2.312 ]

@test TS.reals( ts, 3, 2 ) ≈ [ 1.321, 2.321 ]
@test TS.imags( ts, 3, 2 ) ≈ [ 1.322, 2.322 ]

@test TS.reals( ts, 3, 3 ) ≈ [ 1.331, 2.331 ]
@test TS.imags( ts, 3, 3 ) ≈ [ 1.332, 2.332 ]

ts = TS.parse_touchstone_string( """
    # GHz S RI R 50.0
    1   1.111 1.112 1.121 1.122 1.131 1.132 1.141 1.142
        1.211 1.212 1.221 1.222 1.231 1.232 1.241 1.242
        1.311 1.312 1.321 1.322 1.331 1.332 1.341 1.342
        1.411 1.412 1.421 1.422 1.431 1.432 1.441 1.442
    2   2.111 2.112 2.121 2.122 2.131 2.132 2.141 2.142
        2.211 2.212 2.221 2.222 2.231 2.232 2.241 2.242
        2.311 2.312 2.321 2.322 2.331 2.332 2.341 2.342
        2.411 2.412 2.421 2.422 2.431 2.432 2.441 2.442
    """, 4 )

@test TS.freqs( ts ) ≈ [ 1e9, 2e9 ]

@test TS.reals( ts, 1, 1 ) ≈ [ 1.111, 2.111 ]
@test TS.imags( ts, 1, 1 ) ≈ [ 1.112, 2.112 ]

@test TS.reals( ts, 1, 2 ) ≈ [ 1.121, 2.121 ]
@test TS.imags( ts, 1, 2 ) ≈ [ 1.122, 2.122 ]

@test TS.reals( ts, 1, 3 ) ≈ [ 1.131, 2.131 ]
@test TS.imags( ts, 1, 3 ) ≈ [ 1.132, 2.132 ]

@test TS.reals( ts, 1, 4 ) ≈ [ 1.141, 2.141 ]
@test TS.imags( ts, 1, 4 ) ≈ [ 1.142, 2.142 ]

@test TS.reals( ts, 2, 1 ) ≈ [ 1.211, 2.211 ]
@test TS.imags( ts, 2, 1 ) ≈ [ 1.212, 2.212 ]

@test TS.reals( ts, 2, 2 ) ≈ [ 1.221, 2.221 ]
@test TS.imags( ts, 2, 2 ) ≈ [ 1.222, 2.222 ]

@test TS.reals( ts, 2, 3 ) ≈ [ 1.231, 2.231 ]
@test TS.imags( ts, 2, 3 ) ≈ [ 1.232, 2.232 ]

@test TS.reals( ts, 2, 4 ) ≈ [ 1.241, 2.241 ]
@test TS.imags( ts, 2, 4 ) ≈ [ 1.242, 2.242 ]

@test TS.reals( ts, 3, 1 ) ≈ [ 1.311, 2.311 ]
@test TS.imags( ts, 3, 1 ) ≈ [ 1.312, 2.312 ]

@test TS.reals( ts, 3, 2 ) ≈ [ 1.321, 2.321 ]
@test TS.imags( ts, 3, 2 ) ≈ [ 1.322, 2.322 ]

@test TS.reals( ts, 3, 3 ) ≈ [ 1.331, 2.331 ]
@test TS.imags( ts, 3, 3 ) ≈ [ 1.332, 2.332 ]

@test TS.reals( ts, 3, 4 ) ≈ [ 1.341, 2.341 ]
@test TS.imags( ts, 3, 4 ) ≈ [ 1.342, 2.342 ]

@test TS.reals( ts, 4, 1 ) ≈ [ 1.411, 2.411 ]
@test TS.imags( ts, 4, 1 ) ≈ [ 1.412, 2.412 ]

@test TS.reals( ts, 4, 2 ) ≈ [ 1.421, 2.421 ]
@test TS.imags( ts, 4, 2 ) ≈ [ 1.422, 2.422 ]

@test TS.reals( ts, 4, 3 ) ≈ [ 1.431, 2.431 ]
@test TS.imags( ts, 4, 3 ) ≈ [ 1.432, 2.432 ]

@test TS.reals( ts, 4, 4 ) ≈ [ 1.441, 2.441 ]
@test TS.imags( ts, 4, 4 ) ≈ [ 1.442, 2.442 ]

# ts = TS.parse_touchstone_file( "test/Test_1_6.S2P", 2 )
# f = TS.freqs( ts )
# s21 = TS.dBmags( ts, 2, 1 )
#
# using Plots
#
# plot( f, s21 )
