@test   TS.write_comment_line( "" ) == "!"
@test   TS.write_comment_line( "comment" ) == "!comment"

@test   TS.write_option_line( Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 50   ) ) == "# GHz S MA R 50.0"
@test   TS.write_option_line( Options( 1e3, :ScatteringParameters, :MagnitudeAngle, 50.0 ) ) == "# kHz S MA R 50.0"
@test   TS.write_option_line( Options( 1e6, :AdmittanceParameters, :MagnitudeAngle, 50.0 ) ) == "# MHz Y MA R 50.0"
@test   TS.write_option_line( Options( 1e9, :ImpedanceParameters,  :DecibelAngle,   50.0 ) ) == "# GHz Z dB R 50.0"
@test   TS.write_option_line( Options( 1.0, :HybridHParameters,    :RealImaginary,   1.0 ) ) == "# Hz H RI R 1.0"
@test   TS.write_option_line( Options( 1.0, :HybridGParameters,    :RealImaginary,  50.0 ) ) == "# Hz G RI R 50.0"

@test TS.write_data(
  DataPoint( 1.0, fill( 2.0 + 3im, 1, 1 ) ), 1,
  Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
  ) == "1.0 2.0 3.0\n"

@test TS.write_data(
  DataPoint( 1e9, fill( cis( π / 2 ), 1, 1 ) ), 1,
  Options( 1e9, :ScatteringParameters, :MagnitudeAngle, 1.0 )
  ) == "1.0 1.0 90.0\n"

@test TS.write_data(
  DataPoint( 1e9, fill( 10cis( π / 2 ), 1, 1 ) ), 1,
  Options( 1e9, :ScatteringParameters, :DecibelAngle, 1.0 )
  ) == """
  1.0 20.0 90.0
  """

@test TS.write_data(
  DataPoint( 1.0, [ 2.0 3.0; 4.0 5.0 ] ), 2,
  Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
  ) == """
  1.0 2.0 0.0 4.0 0.0 3.0 0.0 5.0 0.0
  """

@test TS.write_data(
  DataPoint( 1.0, [ 2.0 3.0 4.0; 5.0 6.0 7.0; 8.0 9.0 10.0 ] ), 3,
  Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
  ) == """
  1.0 2.0 0.0 3.0 0.0 4.0 0.0
  5.0 0.0 6.0 0.0 7.0 0.0
  8.0 0.0 9.0 0.0 10.0 0.0
  """

@test TS.write_data(
  DataPoint( 1.0, [ 2.0 3.0 4.0 5.0; 6.0 7.0 8.0 9.0; 10.0 11.0 12.0 13.0; 14.0 15.0 16.0 17.0 ] ), 4,
  Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
  ) == """
  1.0 2.0 0.0 3.0 0.0 4.0 0.0 5.0 0.0
  6.0 0.0 7.0 0.0 8.0 0.0 9.0 0.0
  10.0 0.0 11.0 0.0 12.0 0.0 13.0 0.0
  14.0 0.0 15.0 0.0 16.0 0.0 17.0 0.0
  """


@test TS.write_data(
  DataPoint( 1.0, [
    4.0+6.0im   12.0+14.0im;
    8.0+10.0im  16.0+18.0im;
  ] ),
  2,
  Options( 1.0, :ImpedanceParameters, :RealImaginary, 2.0 )
  ) == """
  1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0
  """

@test TS.write_data(
  DataPoint( 1.0, [
    4.0+6.0im   12.0+14.0im;
    8.0+10.0im  16.0+18.0im;
  ] ),
  2,
  Options( 1.0, :AdmittanceParameters, :RealImaginary, 0.5 )
  ) == """
  1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0
  """

@test TS.write_data(
  DataPoint( 1.0, [
    1          6.0+7.0im;
    4.0+5.0im  1;
  ] ),
  2,
  Options( 1.0, :HybridGParameters, :RealImaginary, 2 )
  ) == """
  1.0 2.0 0.0 4.0 5.0 6.0 7.0 0.5 0.0
  """

@test TS.write_data(
  DataPoint( 1.0, [
    1          6.0+7.0im;
    4.0+5.0im  1;
  ] ),
  2,
  Options( 1.0, :HybridHParameters, :RealImaginary, 2 )
  ) == """
  1.0 0.5 0.0 4.0 5.0 6.0 7.0 2.0 0.0
  """

@test TS.writeNoiseData( NoiseDataPoint( 1e9, 10, im, 50 ) ) == "1.0 20.0 1.0 90.0 1.0\n"

@test TS.writeNoiseData(
  NoiseDataPoint( 1, 10, im, 1 ),
  Options( 1.0, :ScatteringParameters, :RealImaginary, 1.0 )
  ) == "1.0 20.0 1.0 90.0 1.0\n"

@test write_touchstone_string(
  TouchstoneData(
    [ DataPoint( 100e6, fill( 0.99cis(   -4π / 180 ), 1, 1 ) ) ],
    [
      NoiseDataPoint( 100e6, 10, im, 50 ),
      NoiseDataPoint( 200e6, 10, im, 50 ),
    ],
    Options( 1e6, :ScatteringParameters, :MagnitudeAngle, 50.0 ),
    [],
  )
  ) == """
  # MHz S MA R 50.0
  100.0 0.9899999999999999 -4.0
  100.0 20.0 1.0 90.0 1.0
  200.0 20.0 1.0 90.0 1.0
  """

@test write_touchstone_string( TouchstoneData( DataPoint[] ) ) == """
  # GHz S MA R 50.0
  """

@test write_touchstone_string( TouchstoneData( DataPoint[], NoiseDataPoint[], Options(), [ "Test" ] ) ) == """
  !Test
  # GHz S MA R 50.0
  """

@test write_touchstone_string(
  TouchstoneData(
    [
      DataPoint( 100e6, fill( 0.99cis(   -4π / 180 ), 1, 1 ) ),
      DataPoint( 200e6, fill( 0.80cis(  -22π / 180 ), 1, 1 ) ),
      DataPoint( 300e6, fill( 0.707cis( -45π / 180 ), 1, 1 ) ),
      DataPoint( 400e6, fill( 0.40cis(  -62π / 180 ), 1, 1 ) ),
      DataPoint( 500e6, fill( 0.01cis(  -89π / 180 ), 1, 1 ) ),
    ],
    NoiseDataPoint[],
    Options( 1e6, :ScatteringParameters, :MagnitudeAngle, 75.0 ),
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

@test write_touchstone_string(
  TouchstoneData(
    [
      DataPoint( 1e9,  [
        0.3926-0.1211im -0.0003-0.0021im;
        -0.0003-0.0021im 0.3926-0.1211im
      ] ),
      DataPoint( 2e9,  [
        0.3517-0.3054im -0.0096-0.0298im;
        -0.0096-0.0298im 0.3517-0.3054im
      ] ),
      DataPoint( 10e9, [
        0.3419+0.3336im -0.0134+0.0379im;
        -0.0134+0.0379im 0.3419+0.3336im
      ] ),
    ],
    NoiseDataPoint[],
    Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 ),
    [
      "2-port S-parameter file, three frequency points",
      "freq   ReS11   ImS11   ReS21   ImS21   ReS12   ImS12   ReS22   ImS22",
    ],
  ) ) == """
  !2-port S-parameter file, three frequency points
  !freq   ReS11   ImS11   ReS21   ImS21   ReS12   ImS12   ReS22   ImS22
  # GHz S RI R 50.0
  1.0 0.3926 -0.1211 -0.0003 -0.0021 -0.0003 -0.0021 0.3926 -0.1211
  2.0 0.3517 -0.3054 -0.0096 -0.0298 -0.0096 -0.0298 0.3517 -0.3054
  10.0 0.3419 0.3336 -0.0134 0.0379 -0.0134 0.0379 0.3419 0.3336
  """

@test write_touchstone_string(
  TouchstoneData(
    [
      DataPoint( 1e9,  [
        1.11+1.11im 1.12+1.12im;
        1.21+1.21im 1.22+1.22im
      ] ),
      DataPoint( 2e9,  [
        2.11+2.11im 2.12+2.12im;
        2.21+2.21im 2.22+2.22im
      ] ),
    ],
    NoiseDataPoint[],
    Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 )
  )
  ) == """
  # GHz S RI R 50.0
  1.0 1.11 1.11 1.21 1.21 1.12 1.12 1.22 1.22
  2.0 2.11 2.11 2.21 2.21 2.12 2.12 2.22 2.22
  """

@test write_touchstone_string(
  TouchstoneData(
    [
      DataPoint( 1e9,  [
        1.11+1.11im 1.12+1.12im 1.13+1.13im;
        1.21+1.21im 1.22+1.22im 1.23+1.23im;
        1.31+1.31im 1.32+1.32im 1.33+1.33im;
      ] ),
      DataPoint( 2e9,  [
        2.11+2.11im 2.12+2.12im 2.13+2.13im;
        2.21+2.21im 2.22+2.22im 2.23+2.23im;
        2.31+2.31im 2.32+2.32im 2.33+2.33im;
      ] ),
    ],
    NoiseDataPoint[],
    Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 )
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

@test write_touchstone_string(
  TouchstoneData(
    [
      DataPoint( 1e9,  [
        1.11+1.11im 1.12+1.12im 1.13+1.13im 1.14+1.14im;
        1.21+1.21im 1.22+1.22im 1.23+1.23im 1.24+1.24im;
        1.31+1.31im 1.32+1.32im 1.33+1.33im 1.34+1.34im;
        1.41+1.41im 1.42+1.42im 1.43+1.43im 1.44+1.44im;
      ] ),
      DataPoint( 2e9,  [
        2.11+2.11im 2.12+2.12im 2.13+2.13im 2.14+2.14im;
        2.21+2.21im 2.22+2.22im 2.23+2.23im 2.24+2.24im;
        2.31+2.31im 2.32+2.32im 2.33+2.33im 2.34+2.34im;
        2.41+2.41im 2.42+2.42im 2.43+2.43im 2.44+2.44im;
      ] ),
    ],
    NoiseDataPoint[],
    Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 )
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

@test write_touchstone_string(
  TouchstoneData(
    [
      DataPoint( 1e9,  [
        1.11+1.11im 1.12+1.12im 1.13+1.13im 1.14+1.14im 1.15+1.15im;
        1.21+1.21im 1.22+1.22im 1.23+1.23im 1.24+1.24im 1.25+1.25im;
        1.31+1.31im 1.32+1.32im 1.33+1.33im 1.34+1.34im 1.35+1.35im;
        1.41+1.41im 1.42+1.42im 1.43+1.43im 1.44+1.44im 1.45+1.45im;
        1.51+1.51im 1.52+1.52im 1.53+1.53im 1.54+1.54im 1.55+1.55im;
      ] ),
      DataPoint( 2e9,  [
        2.11+2.11im 2.12+2.12im 2.13+2.13im 2.14+2.14im 2.15+2.15im;
        2.21+2.21im 2.22+2.22im 2.23+2.23im 2.24+2.24im 2.25+2.25im;
        2.31+2.31im 2.32+2.32im 2.33+2.33im 2.34+2.34im 2.35+2.35im;
        2.41+2.41im 2.42+2.42im 2.43+2.43im 2.44+2.44im 2.45+2.45im;
        2.51+2.51im 2.52+2.52im 2.53+2.53im 2.54+2.54im 2.55+2.55im;
      ] ),
    ],
    NoiseDataPoint[],
    Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 )
  )
  ) == """
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
  """

@test write_touchstone_string(
  TouchstoneData(
    [
      DataPoint( 1e9,  [
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
    NoiseDataPoint[],
    Options( 1e9, :ScatteringParameters, :RealImaginary, 50.0 )
  ) ) == """
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
  """
