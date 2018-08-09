@test   TS.Options() == TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50.0 )
@test   TS.TS( TS.Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50.0 ) ) == TS.TS()

@test TS.DataPoint( 1.0, [ 1 2; 3 4 ] ) ==  TS.DataPoint( 1.0, [ 1 2; 3 4 ] )
@test TS.DataPoint( 2.0, [ 1 2; 3 4 ] ) !=  TS.DataPoint( 1.0, [ 1 2; 3 4 ] )
@test TS.DataPoint( 1.0, [ 2 2; 3 4 ] ) !=  TS.DataPoint( 1.0, [ 1 2; 3 4 ] )

@test TS.TS( [ TS.DataPoint( 1.0, [ 1 2; 3 4]) ] ) == TS.TS( [ TS.DataPoint( 1.0, [ 1 2; 3 4]) ] )
@test TS.TS( [ TS.DataPoint( 2.0, [ 1 2; 3 4]) ] ) != TS.TS( [ TS.DataPoint( 1.0, [ 1 2; 3 4]) ] )
@test TS.TS( [ TS.DataPoint( 1.0, [ 2 2; 3 4]) ] ) != TS.TS( [ TS.DataPoint( 1.0, [ 1 2; 3 4]) ] )
