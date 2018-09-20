@test   Options() == Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50.0 )
@test   TouchstoneData( DataPoint[], NoiseDataPoint[], Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50.0 ) ) == TouchstoneData( DataPoint[] )

@test DataPoint( 1.0, [ 1 2; 3 4 ] ) ==  DataPoint( 1.0, [ 1 2; 3 4 ] )
@test DataPoint( 2.0, [ 1 2; 3 4 ] ) !=  DataPoint( 1.0, [ 1 2; 3 4 ] )
@test DataPoint( 1.0, [ 2 2; 3 4 ] ) !=  DataPoint( 1.0, [ 1 2; 3 4 ] )

@test TouchstoneData( [ DataPoint( 1.0, [ 1 2; 3 4] ) ] ) == TouchstoneData( [ DataPoint( 1.0, [ 1 2; 3 4]) ] )
@test TouchstoneData( [ DataPoint( 2.0, [ 1 2; 3 4] ) ] ) != TouchstoneData( [ DataPoint( 1.0, [ 1 2; 3 4]) ] )
@test TouchstoneData( [ DataPoint( 1.0, [ 2 2; 3 4] ) ] ) != TouchstoneData( [ DataPoint( 1.0, [ 1 2; 3 4]) ] )

@test TouchstoneData( [
    DataPoint( 1.0, [ 1 2; 3 4]),
    DataPoint( 2.0, [ 1 2; 3 4])
  ] ) == TouchstoneData( [
    DataPoint( 1.0, [ 1 2; 3 4]),
    DataPoint( 2.0, [ 1 2; 3 4])
  ] )

@test TouchstoneData( [
    DataPoint( 1.0, [ 1 2; 3 4]),
    DataPoint( 2.0, [ 1 2; 3 4])
  ] ) != TouchstoneData( [
    DataPoint( 1.0, [ 1 2; 3 4]),
    DataPoint( 3.0, [ 1 2; 3 4])
  ] )

@test_throws ErrorException(
    "Frequencies of data vector not in ascending order."
  ) TouchstoneData( [
    DataPoint( 2.0, [ 1 2; 3 4]),
    DataPoint( 1.0, [ 1 2; 3 4])
  ] )

@test NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 ) ==  NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 )

@test NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 ) !=  NoiseDataPoint( 2.0, 2.0, 3.0 + 4im, 5.0 )
@test NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 ) !=  NoiseDataPoint( 2.0, 2.0, 3.0 + 4im, 5.0 )
@test NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 ) !=  NoiseDataPoint( 2.0, 1.0, 3.0 + 4im, 5.0 )
@test NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 ) !=  NoiseDataPoint( 2.0, 2.0, 5.0 + 4im, 5.0 )
@test NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 ) !=  NoiseDataPoint( 2.0, 2.0, 3.0 + 4im, 4.0 )

@test TouchstoneData( [
    DataPoint( 1.0, [ 1 2; 3 4])
  ], [
    NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 ),
    NoiseDataPoint( 2.0, 2.0, 3.0 + 4im, 5.0 )
  ] ) == TouchstoneData( [
    DataPoint( 1.0, [ 1 2; 3 4])
  ], [
    NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 ),
    NoiseDataPoint( 2.0, 2.0, 3.0 + 4im, 5.0 )
  ] )

@test TouchstoneData( [
    DataPoint( 2.0, [ 1 2; 3 4])
  ], [
    NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 )
  ] ) != TouchstoneData( [
    DataPoint( 2.0, [ 1 2; 3 4])
  ], [
    NoiseDataPoint( 2.0, 2.0, 3.0 + 4im, 5.0 )
  ] )


@test_throws ErrorException(
    "Frequencies of noise data vector not in ascending order."
  ) TouchstoneData( [
    DataPoint( 2.0, [ 1 2; 3 4])
  ], [
    NoiseDataPoint( 2.0, 2.0, 3.0 + 4im, 5.0 ),
    NoiseDataPoint( 1.0, 2.0, 3.0 + 4im, 5.0 )
  ] )

@test_throws ErrorException(
    "Last frequency of data vector is smaller than first frequency of noise data vector."
  ) TouchstoneData( [
    DataPoint( 1.0, [ 1 2; 3 4])
  ], [
    NoiseDataPoint( 2.0, 2.0, 3.0 + 4im, 5.0 )
  ] )
