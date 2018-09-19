# V1.0
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


@test   TS.parse_touchstone_string( "" ) == TS.TS( DataPoint[] )

@test   TS.parse_touchstone_string( """
    !Test
    """ ) == TS.TS( DataPoint[], TS.Options(), [ "Test" ] )

@test   TS.parse_touchstone_string( """
  !Test1

  # Hz G RI R 50
  !Test2
  """, 2 ) == TS.TS( DataPoint[], TS.Options( 1.0, :HybridGParameters, :RealImaginary, 50.0 ), [ "Test1", "Test2" ]  )


# Example 9 (Version 1.0):
ts = TS.parse_touchstone_string( """
  !1-port Z-parameter file, multiple frequency points
  # MHz Z MA R 75
  !freq magZ11 angZ11
  100     0.99    -4  !Comment
  200     0.80    -22
  300     0.707   -45
  400     0.40    -62
  500     0.01    -89
  """ )

@test TS.freqs( ts ) ≈ collect( 1:5 ) * 100e6
@test TS.mags( ts ) ≈ [ 0.99, 0.80, 0.707, 0.4, 0.01 ]
@test TS.angs( ts ) ≈ [ -4, -22, -45, -62, -89 ]
@test ts.comments == [ "1-port Z-parameter file, multiple frequency points", "freq magZ11 angZ11", "Comment" ]
@test version( ts ) == "1.0"
@test ports( ts ) == 1
@test refs( ts ) == [ 75.0 ]

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

@test version( ts ) == "1.0"
@test ports( ts ) == 2
@test refs( ts ) == [ 50.0, 50.0 ]

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

@test version( ts ) == "1.0"
@test ports( ts ) == 2
@test refs( ts ) == [ 50.0, 50.0 ]

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

@test version( ts ) == "1.0"
@test ports( ts ) == 3
@test refs( ts ) == [ 50.0, 50.0, 50.0 ]

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

@test version( ts ) == "1.0"
@test ports( ts ) == 4
@test refs( ts ) == [ 50.0, 50.0, 50.0, 50.0 ]

ts = TS.parse_touchstone_string( """
  # GHz S RI R 50.0
  1.0 1.11 1.11 1.12 1.12 1.13 1.13 1.14 1.14
  1.15 1.15
  1.21 1.21 1.22 1.22 1.23 1.23 1.24 1.24
  1.25 1.25
  1.31 1.31 1.32 1.32 1.33 1.33 1.34 1.34
  1.35 1.35
  1.41 1.41 1.42 1.42 1.43 1.43 1.44 1.44
  1.45 1.45
  1.51 1.51 1.52 1.52 1.53 1.53 1.54 1.54
  1.55 1.55
  2.0 2.11 2.11 2.12 2.12 2.13 2.13 2.14 2.14
  2.15 2.15
  2.21 2.21 2.22 2.22 2.23 2.23 2.24 2.24
  2.25 2.25
  2.31 2.31 2.32 2.32 2.33 2.33 2.34 2.34
  2.35 2.35
  2.41 2.41 2.42 2.42 2.43 2.43 2.44 2.44
  2.45 2.45
  2.51 2.51 2.52 2.52 2.53 2.53 2.54 2.54
  2.55 2.55
  """, 5 )
@test ts == TS.TS(
    [
      TS.DataPoint( 1e9,  [
        1.11+1.11im 1.12+1.12im 1.13+1.13im 1.14+1.14im 1.15+1.15im;
        1.21+1.21im 1.22+1.22im 1.23+1.23im 1.24+1.24im 1.25+1.25im;
        1.31+1.31im 1.32+1.32im 1.33+1.33im 1.34+1.34im 1.35+1.35im;
        1.41+1.41im 1.42+1.42im 1.43+1.43im 1.44+1.44im 1.45+1.45im;
        1.51+1.51im 1.52+1.52im 1.53+1.53im 1.54+1.54im 1.55+1.55im;
      ] ),
      TS.DataPoint( 2e9,  [
        2.11+2.11im 2.12+2.12im 2.13+2.13im 2.14+2.14im 2.15+2.15im;
        2.21+2.21im 2.22+2.22im 2.23+2.23im 2.24+2.24im 2.25+2.25im;
        2.31+2.31im 2.32+2.32im 2.33+2.33im 2.34+2.34im 2.35+2.35im;
        2.41+2.41im 2.42+2.42im 2.43+2.43im 2.44+2.44im 2.45+2.45im;
        2.51+2.51im 2.52+2.52im 2.53+2.53im 2.54+2.54im 2.55+2.55im;
      ] ),
    ],
    TS.Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 )
  )
@test version( ts ) == "1.0"
@test ports( ts ) == 5
@test refs( ts ) == [ 50.0, 50.0, 50.0, 50.0, 50.0 ]

ts = TS.parse_touchstone_string( """
  # GHz S RI R 50.0
  1.0 1.11 1.11 1.12 1.12 1.13 1.13 1.14 1.14
  1.15 1.15 1.16 1.16 1.17 1.17 1.18 1.18
  1.19 1.19 1.11 1.11
  1.21 1.21 1.22 1.22 1.23 1.23 1.24 1.24
  1.25 1.25 1.26 1.26 1.27 1.27 1.28 1.28
  1.29 1.29 1.21 1.21
  1.31 1.31 1.32 1.32 1.33 1.33 1.34 1.34
  1.35 1.35 1.36 1.36 1.37 1.37 1.38 1.38
  1.39 1.39 1.31 1.31
  1.41 1.41 1.42 1.42 1.43 1.43 1.44 1.44
  1.45 1.45 1.46 1.46 1.47 1.47 1.48 1.48
  1.49 1.49 1.41 1.41
  1.51 1.51 1.52 1.52 1.53 1.53 1.54 1.54
  1.55 1.55 1.56 1.56 1.57 1.57 1.58 1.58
  1.59 1.59 1.51 1.51
  1.61 1.61 1.62 1.62 1.63 1.63 1.64 1.64
  1.65 1.65 1.66 1.66 1.67 1.67 1.68 1.68
  1.69 1.69 1.61 1.61
  1.71 1.71 1.72 1.72 1.73 1.73 1.74 1.74
  1.75 1.75 1.76 1.76 1.77 1.77 1.78 1.78
  1.79 1.79 1.71 1.71
  1.81 1.81 1.82 1.82 1.83 1.83 1.84 1.84
  1.85 1.85 1.86 1.86 1.87 1.87 1.88 1.88
  1.89 1.89 1.81 1.81
  1.91 1.91 1.92 1.92 1.93 1.93 1.94 1.94
  1.95 1.95 1.96 1.96 1.97 1.97 1.98 1.98
  1.99 1.99 1.91 1.91
  1.101 1.101 1.102 1.102 1.103 1.103 1.104 1.104
  1.105 1.105 1.106 1.106 1.107 1.107 1.108 1.108
  1.109 1.109 1.101 1.101
  """, 10 )
@test ts == TS.TS(
    [
    TS.DataPoint( 1e9,  [
      1.11+1.11im 1.12+1.12im 1.13+1.13im 1.14+1.14im 1.15+1.15im 1.16+1.16im 1.17+1.17im 1.18+1.18im 1.19+1.19im 1.110+1.110im;
      1.21+1.21im 1.22+1.22im 1.23+1.23im 1.24+1.24im 1.25+1.25im 1.26+1.26im 1.27+1.27im 1.28+1.28im 1.29+1.29im 1.210+1.210im;
      1.31+1.31im 1.32+1.32im 1.33+1.33im 1.34+1.34im 1.35+1.35im 1.36+1.36im 1.37+1.37im 1.38+1.38im 1.39+1.39im 1.310+1.310im;
      1.41+1.41im 1.42+1.42im 1.43+1.43im 1.44+1.44im 1.45+1.45im 1.46+1.46im 1.47+1.47im 1.48+1.48im 1.49+1.49im 1.410+1.410im;
      1.51+1.51im 1.52+1.52im 1.53+1.53im 1.54+1.54im 1.55+1.55im 1.56+1.56im 1.57+1.57im 1.58+1.58im 1.59+1.59im 1.510+1.510im;
      1.61+1.61im 1.62+1.62im 1.63+1.63im 1.64+1.64im 1.65+1.65im 1.66+1.66im 1.67+1.67im 1.68+1.68im 1.69+1.69im 1.610+1.610im;
      1.71+1.71im 1.72+1.72im 1.73+1.73im 1.74+1.74im 1.75+1.75im 1.76+1.76im 1.77+1.77im 1.78+1.78im 1.79+1.79im 1.710+1.710im;
      1.81+1.81im 1.82+1.82im 1.83+1.83im 1.84+1.84im 1.85+1.85im 1.86+1.86im 1.87+1.87im 1.88+1.88im 1.89+1.89im 1.810+1.810im;
      1.91+1.91im 1.92+1.92im 1.93+1.93im 1.94+1.94im 1.95+1.95im 1.96+1.96im 1.97+1.97im 1.98+1.98im 1.99+1.99im 1.910+1.910im;
      1.101+1.101im 1.102+1.102im 1.103+1.103im 1.104+1.104im 1.105+1.105im 1.106+1.106im 1.107+1.107im 1.108+1.108im 1.109+1.109im 1.1010+1.1010im;
    ] ),
    ],
    TS.Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 )
  )
@test version( ts ) == "1.0"
@test ports( ts ) == 10
@test refs( ts ) == [ 50.0, 50.0, 50.0, 50.0, 50.0, 50.0, 50.0, 50.0, 50.0, 50.0 ]

@test_throws ErrorException(
    "V1.0: more than four complex values in one parameter line."
  ) ts = TS.parse_touchstone_string( """
    # GHz S RI R 50.0
    1.0 1.11 1.11 1.12 1.12 1.13 1.13 1.14 1.14 1.15
    """, 5 )

@test_throws ErrorException(
    "V1.0: more than four complex values in one parameter line."
  ) ts = TS.parse_touchstone_string( """
    # GHz S RI R 50.0
    1.0 1.11 1.11 1.12 1.12 1.13 1.13 1.14 1.14
    1.15 1.15
    1.21 1.21 1.22 1.22 1.23 1.23 1.24 1.24 1.25 1.25
    """, 5 )

@test_throws ErrorException(
    "G parameter format for 1-port files not allowed."
  ) TS.parse_touchstone_string( """
    # GHz G RI R 50
    1.0 2.0 3.0
    """, 1
  )
@test_throws ErrorException(
    "H parameter format for 1-port files not allowed."
  ) TS.parse_touchstone_string( """
    # GHz H RI R 50
    1.0 2.0 3.0
    """, 1
  )

# V2.0
@test ! TS.is_keyword_line( "!" )
@test ! TS.is_keyword_line( "#" )
@test   TS.is_keyword_line( "[Version] 2.0" )
@test   TS.is_keyword_line( "[Number Of Ports] 17" )

@test TS.parse_keyword_line( "[Version] 2.0" ) == ( :Version, 2 )
@test TS.parse_keyword_line( "[Number Of Ports] 17" ) == ( :NumberOfPorts, 17 )

ts = TS.parse_touchstone_string( """
  [Version] 2.0
  # GHz S MA R 50
  [Number Of Ports] 1
  [Number Of Frequencies] 0
  """ )
@test ts == TS.TS(
    DataPoint[],
    TS.Options(),
    String[],
    Dict{ Symbol, Any }(
      :Version => 2,
      :NumberOfPorts => 1,
      :NumberOfFrequencies => 0,
    ),
  )
@test version( ts ) == "2.0"
@test ports( ts ) == 1
@test refs( ts ) == [ 50.0 ]

@test_throws ErrorException(
    "V2.0: [Version] 2.0 before option line expected."
  ) TS.parse_touchstone_string( """
    # GHz S MA R 50
    [Version] 2.0
    """
  )

@test_throws ErrorException(
    "V2.0: Option line before [Number of Ports] keyword expected."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    [Number Of Ports] 17
    # GHz S RI R 50
    """
  )

@test_throws ErrorException(
    "V2.0: [Version] keyword before [Two-Port Data Order] keyword expected."
  ) TS.parse_touchstone_string( """
    # GHz S RI R 50
    [Number Of Ports] 2
    [Two-Port Data Order] 12_21
    """
  )

@test_throws ErrorException(
    "V2.0: Option line before [Number of Frequencies] keyword expected."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    [Number Of Ports] 2
    [Number of Frequencies] 12
    """
  )

@test_throws ErrorException(
    "V2.0: [Number of Ports] keyword before [Number of Noise Frequencies] keyword expected."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz S RI R 50
    [Number of Noise Frequencies] 11
    """
  )

@test_throws ErrorException(
    "V2.0: [Network Data] keyword after [Reference] keyword expected."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz S RI R 50
    [Number Of Ports] 1
    [Number of Frequencies] 1
    [Network Data]
    [Reference] 11
    """
  )

@test_throws ErrorException(
    "V2.0: [Noise Data] keyword after [Network Data] keyword expected."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz S RI R 50
    [Number Of Ports] 2
    [Number of Frequencies] 1
    [Reference] 11 12
    [Noise Data]
    [Network Data]
    1 2 3 4 5 6 7 8 9
    [End]
    """
  )

@test_throws ErrorException(
    "V2.0: [Number of Frequencies] keyword before [Network Data] keyword expected."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz S RI R 50
    [Number Of Ports] 1
    [Reference] 11
    [Network Data]
    1.0 2.0 3.0
    [End]
    """
  )

ts = TS.parse_touchstone_string( """
    [Version] 2.0
    !1-port Z-parameter file, multiple frequency points
    # MHz Z MA R 75
    [Number of Ports] 1
    [Number of Frequencies] 5
    !freq magZ11 angZ11
    [Network Data]
    100     0.99    -4  !Comment
    200     0.80    -22
    300     0.707   -45
    400     0.40    -62
    500     0.01    -89
    [End]
    """ )
@test TS.freqs( ts ) ≈ collect( 1:5 ) * 100e6
@test TS.mags( ts ) ≈ [ 0.99, 0.80, 0.707, 0.4, 0.01 ]
@test TS.angs( ts ) ≈ [ -4, -22, -45, -62, -89 ]
@test ts.comments == [ "1-port Z-parameter file, multiple frequency points", "freq magZ11 angZ11", "Comment" ]
@test ts.keywordparams == Dict{ Symbol, Any }(
    :Version => 2,
    :NumberOfPorts => 1,
    :NumberOfFrequencies => 5,
    :NetworkData => [],
    :End  => [],
  )
@test version( ts ) == "2.0"
@test ports( ts ) == 1
@test refs( ts ) == [ 75.0 ]

@test_throws ErrorException(
    "V2.0: [Two-Port Data Order] keyword not allowed for 1 port data."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz S RI R 50
    [Number Of Ports] 1
    [Number of Frequencies] 1
    [Two-Port Data Order] 12_21
    [Reference] 11
    [Network Data]
    1.0 2.0 3.0
    [End]
    """
  )

@test_throws ErrorException(
    "V2.0: [Two-Port Data Order] expected for two port data."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz S RI R 50
    [Number Of Ports] 2
    [Number of Frequencies] 1
    [Network Data]
    1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0
    [End]
    """
  )

ts = TS.parse_touchstone_string( """
  [Version] 2.0
  # GHz S RI R 50
  [Number Of Ports] 1
  [Number of Frequencies] 1
  [Reference] 11
  [Network Data]
  1.0 2.0 3.0
  [End]
  """ )
@test ts == TS.TS(
    DataPoint[
      DataPoint(
        1.0e9,
        fill( 2.0 + 3.0im, 1, 1 )
      )
    ],
    Options( 1.0e9, :ScatteringParameters, :RealImaginary, 50.0 ),
    String[],
    Dict{Symbol,Any}(
      :NumberOfPorts => 1,
      :NumberOfFrequencies => 1,
      :Version => 2,
      :End => Any[],
      :NetworkData => Any[],
      :Reference => [ 11.0 ]
    )
  )
@test version( ts ) == "2.0"
@test ports( ts ) == 1
@test refs( ts ) == [ 11.0 ]

ts = TS.parse_touchstone_string( """
  [Version] 2.0
  # GHz S RI R 50
  [Number Of Ports] 2
  [Number of Frequencies] 1
  [Two-Port Data Order] 12_21
  [Reference] 11 12
  [Network Data]
  1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0
  [End]
  """ )
@test ts == TS.TS(
    DataPoint[
      DataPoint(
        1.0e9,
        [ 2.0 + 3.0im 6.0 + 7.0im; 4.0 + 5.0im 8.0 + 9.0im ]
      )
    ],
    Options( 1.0e9, :ScatteringParameters, :RealImaginary, 50.0 ),
    String[],
    Dict{Symbol,Any}(
      :NumberOfPorts => 2,
      :NumberOfFrequencies => 1,
      :Version => 2,
      :End => Any[],
      :NetworkData => Any[],
      :Reference => [ 11.0, 12.0 ],
      :TwoPortDataOrder => "12_21",
    )
  )
@test version( ts ) == "2.0"
@test ports( ts ) == 2
@test refs( ts ) == [ 11.0, 12.0 ]

@test_throws ErrorException(
    "V2.0: 1 parameters for [Reference] expected."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz S RI R 50
    [Number Of Ports] 1
    [Number of Frequencies] 1
    [Reference] 11 12
    [Network Data]
    1.0 2.0 3.0
    [End]
    """
  )

@test_throws ErrorException(
    "V2.0: 1 parameters for [Reference] expected."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz S RI R 50
    [Number Of Ports] 1
    [Number of Frequencies] 1
    [Reference]
    11 12
    [Network Data]
    1.0 2.0 3.0
    [End]
    """
  )

ts = TS.parse_touchstone_string( """
  [Version] 2.0
  # GHz S RI R 50
  [Number Of Ports] 2
  [Number of Frequencies] 1
  [Two-Port Data Order] 12_21
  [Reference]
  11 12
  [Network Data]
  1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0
  [End]
  """ )
@test ts == TS.TS(
    DataPoint[
      DataPoint(
        1.0e9,
        [ 2.0 + 3.0im 6.0 + 7.0im; 4.0 + 5.0im 8.0 + 9.0im ]
      )
    ],
    Options( 1.0e9, :ScatteringParameters, :RealImaginary, 50.0 ),
    String[],
    Dict{Symbol,Any}(
      :NumberOfPorts => 2,
      :NumberOfFrequencies => 1,
      :Version => 2,
      :End => Any[],
      :NetworkData => Any[],
      :Reference => [ 11.0, 12.0 ],
      :TwoPortDataOrder => "12_21",
    )
  )
@test version( ts ) == "2.0"
@test ports( ts ) == 2
@test refs( ts ) == [ 11.0, 12.0 ]

@test_throws ErrorException(
    "V2.0: Non empty or comment line found after [End] keyword."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz S RI R 50
    [Number Of Ports] 2
    [Number of Frequencies] 1
    [Two-Port Data Order] 12_21
    [Reference]
    11 12
    [Network Data]
    1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0
    [End]
    1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0
    """
  )

@test_throws ErrorException(
    "V2.0: [NoiseData] keyword not allowed for 1 port data."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz S RI R 50
    [Number Of Ports] 1
    [Number of Frequencies] 1
    [Network Data]
    1.0 2.0 3.0
    [Noise Data]
    1.0 2.0 3.0 4.0 5.0
    [End]
    """
  )

@test_throws ErrorException(
    "G parameter format for 1-port files not allowed."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz G RI R 50
    [Number Of Ports] 1
    [Number of Frequencies] 1
    [Network Data]
    1.0 2.0 3.0
    [End]
    """
  )
@test_throws ErrorException(
    "H parameter format for 1-port files not allowed."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz H RI R 50
    [Number Of Ports] 1
    [Number of Frequencies] 1
    [Network Data]
    1.0 2.0 3.0
    [End]
    """
  )

@test_throws ErrorException(
    "[Mixed-Mode Order] keyword for G parameter format not allowed."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz G RI R 50
    [Number Of Ports] 2
    [Two-Port Data Order] 12_21
    [Number of Frequencies] 1
    [Mixed-Mode Order] S1 S2
    [Network Data]
    1 2 3 4 5 6 7 8 9
    [End]
    """
  )
@test_throws ErrorException(
    "[Mixed-Mode Order] keyword for H parameter format not allowed."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz H RI R 50
    [Number Of Ports] 2
    [Two-Port Data Order] 12_21
    [Number of Frequencies] 1
    [Mixed-Mode Order] S1 S2
    [Network Data]
    1 2 3 4 5 6 7 8 9
    [End]
    """
  )

@test_throws ErrorException(
    "V2.0: Unknown parameter 'bla' for [Two-Port Data Order] keyword."
  ) TS.parse_touchstone_string( """
    [Version] 2.0
    # GHz H RI R 50
    [Number Of Ports] 2
    [Two-Port Data Order] bla
    [Number of Frequencies] 1
    [Network Data]
    1 2 3 4 5 6 7 8 9
    [End]
    """
  )


ts = TS.parse_touchstone_string( """
  [Version] 2.0
  # GHz S RI R 50
  [Number Of Ports] 2
  [Number of Frequencies] 1
  [Two-Port Data Order] 21_12
  [Network Data]
  1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0
  [End]
  """ )
@test ts == TS.TS(
    DataPoint[
      DataPoint(
        1.0e9,
        [ 2.0 + 3.0im 4.0 + 5.0im; 6.0 + 7.0im 8.0 + 9.0im ]
      )
    ],
    Options( 1.0e9, :ScatteringParameters, :RealImaginary, 50.0 ),
    String[],
    Dict{Symbol,Any}(
      :NumberOfPorts => 2,
      :NumberOfFrequencies => 1,
      :Version => 2,
      :End => Any[],
      :NetworkData => Any[],
      :TwoPortDataOrder => "21_12",
    )
  )
@test version( ts ) == "2.0"
@test ports( ts ) == 2
@test refs( ts ) == [ 50.0, 50.0 ]
