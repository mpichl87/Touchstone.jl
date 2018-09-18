@test   TS.Options() == TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50.0 )
@test   TS.TS( DataPoint[], TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50.0 ) ) == TS.TS( DataPoint[] )

@test TS.DataPoint( 1.0, [ 1 2; 3 4 ] ) ==  TS.DataPoint( 1.0, [ 1 2; 3 4 ] )
@test TS.DataPoint( 2.0, [ 1 2; 3 4 ] ) !=  TS.DataPoint( 1.0, [ 1 2; 3 4 ] )
@test TS.DataPoint( 1.0, [ 2 2; 3 4 ] ) !=  TS.DataPoint( 1.0, [ 1 2; 3 4 ] )

@test TS.TS( [ TS.DataPoint( 1.0, [ 1 2; 3 4]) ] ) == TS.TS( [ TS.DataPoint( 1.0, [ 1 2; 3 4]) ] )
@test TS.TS( [ TS.DataPoint( 2.0, [ 1 2; 3 4]) ] ) != TS.TS( [ TS.DataPoint( 1.0, [ 1 2; 3 4]) ] )
@test TS.TS( [ TS.DataPoint( 1.0, [ 2 2; 3 4]) ] ) != TS.TS( [ TS.DataPoint( 1.0, [ 1 2; 3 4]) ] )

@test TS.TS( [
    TS.DataPoint( 1.0, [ 1 2; 3 4]),
    TS.DataPoint( 2.0, [ 1 2; 3 4])
  ] ) == TS.TS( [
    TS.DataPoint( 1.0, [ 1 2; 3 4]),
    TS.DataPoint( 2.0, [ 1 2; 3 4])
  ] )

@test_throws ErrorException(
    "Frequencies of data vector not in ascending order."
  ) TS.TS( [
    TS.DataPoint( 2.0, [ 1 2; 3 4]),
    TS.DataPoint( 1.0, [ 1 2; 3 4])
  ] )
