@test   TS.write_comment_line( "" ) == "!"
@test   TS.write_comment_line( "comment" ) == "!comment"

@test   TS.write_option_line( TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50   ) ) == "# GHz S MA R 50.0"
@test   TS.write_option_line( TS.Options( 1e3, :ScatteringParameters, :MagnitudeAngle, 50.0 ) ) == "# kHz S MA R 50.0"
@test   TS.write_option_line( TS.Options( 1e6, :AdmittanceParameters, :MagnitudeAngle, 50.0 ) ) == "# MHz Y MA R 50.0"
@test   TS.write_option_line( TS.Options( 1e9, :ImpedanceParameters,  :DecibelAngle,   50.0 ) ) == "# GHz Z dB R 50.0"
@test   TS.write_option_line( TS.Options( 1.0, :HybridHParameters,    :RealImaginary,   1.0 ) ) == "# Hz H RI R 1.0"
@test   TS.write_option_line( TS.Options( 1.0, :HybridGParameters,    :RealImaginary,  50.0 ) ) == "# Hz G RI R 50.0"

@test TS.write_data(
  TS.DataPoint( 1.0, fill( 2.0 + 3im, 1, 1 ) ), 1,
  TS.Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
) == [ "1.0 2.0 3.0" ]

@test TS.write_data(
  TS.DataPoint( 1e9, fill( cis( π / 2 ), 1, 1 ) ), 1,
  TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 1.0 )
) == [ "1.0 1.0 90.0" ]

@test TS.write_data(
  TS.DataPoint( 1e9, fill( 10cis( π / 2 ), 1, 1 ) ), 1,
  TS.Options( 1e9, :ScatteringParameters, :DecibelAngle, 1.0 )
) == [ "1.0 20.0 90.0" ]

@test TS.write_data(
  TS.DataPoint( 1.0, [ 2.0 3.0; 4.0 5.0 ] ), 2,
  TS.Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
) == [ "1.0 2.0 0.0 4.0 0.0 3.0 0.0 5.0 0.0" ]

@test TS.write_data(
  TS.DataPoint( 1.0, [ 2.0 3.0 4.0; 5.0 6.0 7.0; 8.0 9.0 10.0 ] ), 3,
  TS.Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
) ==  [
  "1.0 2.0 0.0 3.0 0.0 4.0 0.0",
  "5.0 0.0 6.0 0.0 7.0 0.0",
  "8.0 0.0 9.0 0.0 10.0 0.0"
]

@test TS.write_data(
  TS.DataPoint( 1.0, [ 2.0 3.0 4.0 5.0; 6.0 7.0 8.0 9.0; 10.0 11.0 12.0 13.0; 14.0 15.0 16.0 17.0 ] ), 4,
  TS.Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
) ==  [
  "1.0 2.0 0.0 3.0 0.0 4.0 0.0 5.0 0.0",
  "6.0 0.0 7.0 0.0 8.0 0.0 9.0 0.0",
  "10.0 0.0 11.0 0.0 12.0 0.0 13.0 0.0",
  "14.0 0.0 15.0 0.0 16.0 0.0 17.0 0.0"
]

@test TS.write_touchstone_string( TS.TS() ) == """
  # GHz S MA R 50.0
  """

@test TS.write_touchstone_string( TS.TS( TS.Options(), [ "Test" ] ) ) == """
  !Test
  # GHz S MA R 50.0
  """

@test TS.write_touchstone_string( TS.TS(
  TS.Options( 1.0, :HybridGParameters, :RealImaginary, 50.0 ), [ "Test1", "Test2" ] ) ) == """
  !Test1
  !Test2
  # Hz G RI R 50.0
  """

@test TS.write_touchstone_string(
  TS.TS(
    [
      TS.DataPoint( 100e6, fill( 0.99cis(   -4π / 180 ), 1, 1 ) ),
      TS.DataPoint( 200e6, fill( 0.80cis(  -22π / 180 ), 1, 1 ) ),
      TS.DataPoint( 300e6, fill( 0.707cis( -45π / 180 ), 1, 1 ) ),
      TS.DataPoint( 400e6, fill( 0.40cis(  -62π / 180 ), 1, 1 ) ),
      TS.DataPoint( 500e6, fill( 0.01cis(  -89π / 180 ), 1, 1 ) ),
    ],
    TS.Options( 1e6, :ScatteringParameters, :MagnitudeAngle, 75.0 ),
    [ "Test1", "freq magZ11 angZ11" ]
  )
) == """
  !Test1
  !freq magZ11 angZ11
  # MHz S MA R 75.0
  100.0 0.9899999999999999 -4.0
  200.0 0.8000000000000002 -21.999999999999996
  300.0 0.707 -44.99999999999999
  400.0 0.4000000000000001 -62.0
  500.0 0.010000000000000002 -89.00000000000001
  """

  @test TS.write_touchstone_string(
    TS.TS(
      [
        TS.DataPoint( 1e9,  [
          0.3926-0.1211im -0.0003-0.0021im;
          -0.0003-0.0021im 0.3926-0.1211im
        ] ),
        TS.DataPoint( 2e9,  [
          0.3517-0.3054im -0.0096-0.0298im;
          -0.0096-0.0298im 0.3517-0.3054im
        ] ),
        TS.DataPoint( 10e9, [
          0.3419+0.3336im -0.0134+0.0379im;
          -0.0134+0.0379im 0.3419+0.3336im
        ] ),
      ],
      TS.Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 ),
      [
        "2-port S-parameter file, three frequency points",
        "freq   ReS11   ImS11   ReS21   ImS21   ReS12   ImS12   ReS22   ImS22",
      ],
    )
  ) == """
  !2-port S-parameter file, three frequency points
  !freq   ReS11   ImS11   ReS21   ImS21   ReS12   ImS12   ReS22   ImS22
  # GHz S RI R 50.0
  1.0 0.3926 -0.1211 -0.0003 -0.0021 -0.0003 -0.0021 0.3926 -0.1211
  2.0 0.3517 -0.3054 -0.0096 -0.0298 -0.0096 -0.0298 0.3517 -0.3054
  10.0 0.3419 0.3336 -0.0134 0.0379 -0.0134 0.0379 0.3419 0.3336
  """

@test TS.write_touchstone_string(
  TS.TS(
    [
      TS.DataPoint( 1e9,  [
        1.11+1.11im 1.12+1.12im;
        1.21+1.21im 1.22+1.22im
      ] ),
      TS.DataPoint( 2e9,  [
        2.11+2.11im 2.12+2.12im;
        2.21+2.21im 2.22+2.22im
      ] ),
    ],
    TS.Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 )
  )
) == """
  # GHz S RI R 50.0
  1.0 1.11 1.11 1.21 1.21 1.12 1.12 1.22 1.22
  2.0 2.11 2.11 2.21 2.21 2.12 2.12 2.22 2.22
  """


@test TS.write_touchstone_string(
  TS.TS(
    [
      TS.DataPoint( 1e9,  [
        1.11+1.11im 1.12+1.12im 1.13+1.13im;
        1.21+1.21im 1.22+1.22im 1.23+1.23im;
        1.31+1.31im 1.32+1.32im 1.33+1.33im;
      ] ),
      TS.DataPoint( 2e9,  [
        2.11+2.11im 2.12+2.12im 2.13+2.13im;
        2.21+2.21im 2.22+2.22im 2.23+2.23im;
        2.31+2.31im 2.32+2.32im 2.33+2.33im;
      ] ),
    ],
    TS.Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 )
  )
) == """
  # GHz S RI R 50.0
  1.0 1.11 1.11 1.12 1.12 1.13 1.13
  1.21 1.21 1.22 1.22 1.23 1.23
  1.31 1.31 1.32 1.32 1.33 1.33
  2.0 2.11 2.11 2.12 2.12 2.13 2.13
  2.21 2.21 2.22 2.22 2.23 2.23
  2.31 2.31 2.32 2.32 2.33 2.33
  """

@test TS.write_touchstone_string(
  TS.TS(
    [
      TS.DataPoint( 1e9,  [
        1.11+1.11im 1.12+1.12im 1.13+1.13im 1.14+1.14im;
        1.21+1.21im 1.22+1.22im 1.23+1.23im 1.24+1.24im;
        1.31+1.31im 1.32+1.32im 1.33+1.33im 1.34+1.34im;
        1.41+1.41im 1.42+1.42im 1.43+1.43im 1.44+1.44im;
      ] ),
      TS.DataPoint( 2e9,  [
        2.11+2.11im 2.12+2.12im 2.13+2.13im 2.14+2.14im;
        2.21+2.21im 2.22+2.22im 2.23+2.23im 2.24+2.24im;
        2.31+2.31im 2.32+2.32im 2.33+2.33im 2.34+2.34im;
        2.41+2.41im 2.42+2.42im 2.43+2.43im 2.44+2.44im;
      ] ),
    ],
    TS.Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 )
  )
) == """
  # GHz S RI R 50.0
  1.0 1.11 1.11 1.12 1.12 1.13 1.13 1.14 1.14
  1.21 1.21 1.22 1.22 1.23 1.23 1.24 1.24
  1.31 1.31 1.32 1.32 1.33 1.33 1.34 1.34
  1.41 1.41 1.42 1.42 1.43 1.43 1.44 1.44
  2.0 2.11 2.11 2.12 2.12 2.13 2.13 2.14 2.14
  2.21 2.21 2.22 2.22 2.23 2.23 2.24 2.24
  2.31 2.31 2.32 2.32 2.33 2.33 2.34 2.34
  2.41 2.41 2.42 2.42 2.43 2.43 2.44 2.44
  """
