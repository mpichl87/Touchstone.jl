@test   TS.write_comment_line( "" ) == "!"
@test   TS.write_comment_line( "comment" ) == "!comment"

@test   TS.write_option_line( TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50   ) ) == "# GHz S MA R 50.0"
@test   TS.write_option_line( TS.Options( 1e3, :ScatteringParameters, :MagnitudeAngle, 50.0 ) ) == "# kHz S MA R 50.0"
@test   TS.write_option_line( TS.Options( 1e6, :AdmittanceParameters, :MagnitudeAngle, 50.0 ) ) == "# MHz Y MA R 50.0"
@test   TS.write_option_line( TS.Options( 1e9, :ImpedanceParameters,  :DecibelAngle,   50.0 ) ) == "# GHz Z dB R 50.0"
@test   TS.write_option_line( TS.Options( 1.0, :HybridHParameters,    :RealImaginary,   1.0 ) ) == "# Hz H RI R 1.0"
@test   TS.write_option_line( TS.Options( 1.0, :HybridGParameters,    :RealImaginary,  50.0 ) ) == "# Hz G RI R 50.0"

@test TS.write_one_port_data(
    TS.DataPoint( 1.0, fill( 2.0 + 3im, 1, 1 ) ),
    TS.Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
) == "1.0 2.0 3.0"

@test TS.write_one_port_data(
    TS.DataPoint( 1e9, fill( cis( π / 2 ), 1, 1 ) ),
    TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 1.0 )
) == "1.0 1.0 90.0"

@test TS.write_one_port_data(
    TS.DataPoint( 1e9, fill( 10cis( π / 2 ), 1, 1 ) ),
    TS.Options( 1e9, :ScatteringParameters, :DecibelAngle, 1.0 )
) == "1.0 20.0 90.0"

@test TS.write_two_port_data(
    TS.DataPoint( 1.0, [ 2.0 3.0; 4.0 5.0 ] ),
    TS.Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
) == "1.0 2.0 0.0 4.0 0.0 3.0 0.0 5.0 0.0"

@test TS.write_three_port_data(
    TS.DataPoint( 1.0, [ 2.0 3.0 4.0; 5.0 6.0 7.0; 8.0 9.0 10.0 ] ),
    TS.Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
) ==  [
    "1.0 2.0 0.0 3.0 0.0 4.0 0.0",
    "5.0 0.0 6.0 0.0 7.0 0.0",
    "8.0 0.0 9.0 0.0 10.0 0.0"
]

@test TS.write_four_port_data(
    TS.DataPoint( 1.0, [ 2.0 3.0 4.0 5.0; 6.0 7.0 8.0 9.0; 10.0 11.0 12.0 13.0; 14.0 15.0 16.0 17.0 ] ),
    TS.Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
) ==  [
    "1.0 2.0 0.0 3.0 0.0 4.0 0.0 5.0 0.0",
    "6.0 0.0 7.0 0.0 8.0 0.0 9.0 0.0",
    "10.0 0.0 11.0 0.0 12.0 0.0 13.0 0.0",
    "14.0 0.0 15.0 0.0 16.0 0.0 17.0 0.0"
]
