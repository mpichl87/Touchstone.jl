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
