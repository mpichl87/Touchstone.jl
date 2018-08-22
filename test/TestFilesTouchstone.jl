fourportstring = """
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

fourportdata = TS.TS(
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

# String:
@test TS.write_touchstone_string( TS.parse_touchstone_string( fourportstring, 4 ) ) == fourportstring
@test TS.parse_touchstone_string( TS.write_touchstone_string( fourportdata ), 4 ) == fourportdata

# Stream:
buffer = PipeBuffer()
write_touchstone_stream( buffer, fourportdata )
@test parse_touchstone_stream( buffer, 4 ) == fourportdata
close( buffer )

# File:
filename = joinpath( tempdir(), "test.s4p" )
write_touchstone_file( filename, fourportdata )
@test parse_touchstone_file( filename, 4 ) == fourportdata
