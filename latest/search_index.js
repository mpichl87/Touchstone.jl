var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.jl Documentation",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#Touchstone.jl-Documentation-1",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.jl Documentation",
    "category": "section",
    "text": ""
},

{
    "location": "index.html#Touchstone.DataPoint",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.DataPoint",
    "category": "type",
    "text": "Holds scalar frequency and parameter matrix for one data point.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.Options",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.Options",
    "category": "type",
    "text": "Holds values from option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.TS",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.TS",
    "category": "type",
    "text": "Holds data for Touchstone file.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.angs",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.angs",
    "category": "function",
    "text": "angs( ts, p1, p2 )\n\nGets the vector of the angles in radians of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.dBmags",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.dBmags",
    "category": "function",
    "text": "dBmags( ts, p1, p2 )\n\nGets the vector of the magnitudes in dB of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.freqs-Tuple{TS}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.freqs",
    "category": "method",
    "text": "freqs( ts )\n\nGets the frequency vector from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.imags",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.imags",
    "category": "function",
    "text": "imags( ts, p1, p2 )\n\nGets the vector of the imaginary parts of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.mags",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.mags",
    "category": "function",
    "text": "mags( ts, p1, p2 )\n\nGets the vector of the magnitudes of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.param",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.param",
    "category": "function",
    "text": "param( ts, p1, p2 )\n\nGets the vector of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.params-Tuple{TS}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.params",
    "category": "method",
    "text": "params( ts )\n\nGets the vector of parameter matrices from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_touchstone_file",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_touchstone_file",
    "category": "function",
    "text": "parse_touchstone_file( filename, [ ports ] )\n\nReturns a TS structure for a valid Touchstone data file. Works for ports = 1, 2, 3 or 4.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_touchstone_stream",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_touchstone_stream",
    "category": "function",
    "text": "parse_touchstone_stream( stream, [ ports ] )\n\nReturns a TS structure for a valid Touchstone data stream. Works for ports = 1, 2, 3 or 4.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_touchstone_string",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_touchstone_string",
    "category": "function",
    "text": "parse_touchstone_string( in, [ ports ] )\n\nReturns a TS structure for a valid Touchstone data string. Works for ports = 1, 2, 3 or 4.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.reals",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.reals",
    "category": "function",
    "text": "reals( ts, p1, p2 )\n\nGets the vector of the real parts of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_touchstone_file-Tuple{String,TS}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_touchstone_file",
    "category": "method",
    "text": "write_touchstone_file( filename, ts )\n\nWrites formated Touchstone data for a TS structure to a file.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_touchstone_stream-Tuple{IO,TS}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_touchstone_stream",
    "category": "method",
    "text": "write_touchstone_stream( stream, ts )\n\nWrites formated Touchstone data for a TS structure to a stream.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_touchstone_string-Tuple{TS}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_touchstone_string",
    "category": "method",
    "text": "write_touchstone_string( ts )\n\nReturns a string with formated Touchstone data for a TS structure.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.default_format",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.default_format",
    "category": "constant",
    "text": "The default data format, if not found in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.default_format_symbol",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.default_format_symbol",
    "category": "constant",
    "text": "Default data format symbol to use in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.default_parameter",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.default_parameter",
    "category": "constant",
    "text": "The default parameter format, if not found in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.default_parameter_symbol",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.default_parameter_symbol",
    "category": "constant",
    "text": "Defaoult parameter format symbo to use in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.default_resistance",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.default_resistance",
    "category": "constant",
    "text": "The default characteristic impedance, if not found in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.default_resistance_string",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.default_resistance_string",
    "category": "constant",
    "text": "Default characteristic iimpedance to use in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.default_unit_value",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.default_unit_value",
    "category": "constant",
    "text": "Default unit value to use in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.default_units",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.default_units",
    "category": "constant",
    "text": "The default unit, if not found in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.formats",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.formats",
    "category": "constant",
    "text": "Symbols for data format for strings found in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.formatstrings",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.formatstrings",
    "category": "constant",
    "text": "String for data format symbols in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parameters",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parameters",
    "category": "constant",
    "text": "Symbols for different parameter formats for strings found in option line\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parameterstrings",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parameterstrings",
    "category": "constant",
    "text": "Strings for parameter format symbols in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.units",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.units",
    "category": "constant",
    "text": "Values for units for strings found in option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.unitstrings",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.unitstrings",
    "category": "constant",
    "text": "String for unit multiplier in option line\n\n\n\n\n\n"
},

{
    "location": "index.html#Base.:==-Tuple{Any,DataPoint}",
    "page": "Touchstone.jl Documentation",
    "title": "Base.:==",
    "category": "method",
    "text": "Compares data points.\n\n\n\n\n\n"
},

{
    "location": "index.html#Base.:==-Tuple{Any,Options}",
    "page": "Touchstone.jl Documentation",
    "title": "Base.:==",
    "category": "method",
    "text": "Compares Options.\n\n\n\n\n\n"
},

{
    "location": "index.html#Base.:==-Tuple{Any,TS}",
    "page": "Touchstone.jl Documentation",
    "title": "Base.:==",
    "category": "method",
    "text": "Compares Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "index.html#Base.:≈-Tuple{Any,DataPoint}",
    "page": "Touchstone.jl Documentation",
    "title": "Base.:≈",
    "category": "method",
    "text": "Compares data points approximately.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.comp2da-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.comp2da",
    "category": "method",
    "text": "comp2da( z )\n\nReturns a pair with the magnitude in dB and angle in degrees of a complex number.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.comp2ma-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.comp2ma",
    "category": "method",
    "text": "comp2ma( z )\n\nReturns a pair with the linear magnitude and angle in degrees of a complex number.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.compstring-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.compstring",
    "category": "method",
    "text": "compstring( z )\n\nReturns a pair with the real and imaginary components of a complex number.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.da2comp-Tuple{Any,Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.da2comp",
    "category": "method",
    "text": "da2comp( m, a )\n\nConverts a pair of values in dB / angle format to a complex number.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.dastring-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.dastring",
    "category": "method",
    "text": "dastring( z )\n\nReturns a string in dB / angle format of a complex number.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.is_comment_line-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.is_comment_line",
    "category": "method",
    "text": "is_commentline( line )\n\nChecks, if a line is a comment line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.is_empy_line-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.is_empy_line",
    "category": "method",
    "text": "is_empy_line( line )\n\nChecks, if a line is empty.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.is_format_option-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.is_format_option",
    "category": "method",
    "text": "is_format_option( option )\n\nChecks, if a string is a valid data format in an option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.is_frequency_unit_option-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.is_frequency_unit_option",
    "category": "method",
    "text": "is_frequency_unit_option( option )\n\nChecks, if a string is a valid unit in an option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.is_keyword_line-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.is_keyword_line",
    "category": "method",
    "text": "is_keyword_line( line )\n\nChecks, if a line is a valid keyword line.\n\nTODO: Needed for Version 2.0, which is not implemented for now.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.is_option_line-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.is_option_line",
    "category": "method",
    "text": "is_option_line( line )\n\nChecks, if a line is a option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.is_parameter_option-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.is_parameter_option",
    "category": "method",
    "text": "is_parameter_option( option )\n\nChecks, if a string is a valid parameter format in an option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.is_resistance_option-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.is_resistance_option",
    "category": "method",
    "text": "is_resistance_option( option )\n\nChecks, if a string is a valid resistance in an option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.ma2comp-Tuple{Any,Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.ma2comp",
    "category": "method",
    "text": "ma2comp( m, a )\n\nConverts a pair of values in magnitude / angle format to a complex number.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.mastring-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.mastring",
    "category": "method",
    "text": "mastring( z )\n\nReturns a string in magnitude / angle format of a complex number.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.pairstring-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.pairstring",
    "category": "method",
    "text": "pairstring( pair )\n\nReturns a string combining the components of a pair.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_comment_line-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_comment_line",
    "category": "method",
    "text": "parse_comment_line( line )\n\nReturns the comment of a comment line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_format_option-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_format_option",
    "category": "method",
    "text": "parse_format_option( option )\n\nReturns the symbol for a valid data format string in an option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_four_port_data",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_four_port_data",
    "category": "function",
    "text": "parse_four_port_data( line, [ options ] )\n\nReturns a data point structure for a valid line of a four-port Touchstone file.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_frequency_unit_option-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_frequency_unit_option",
    "category": "method",
    "text": "parse_frequency_unit_option( option )\n\nReturns the multiplier for a unit string in an option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_one_port_data",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_one_port_data",
    "category": "function",
    "text": "parse_one_port_data( line, [ options ] )\n\nReturns a data point structure for a valid line of a one-port Touchstone file.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_option_line-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_option_line",
    "category": "method",
    "text": "parse_option_line( line )\n\nReturns the option structure for a valid option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_parameter_option-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_parameter_option",
    "category": "method",
    "text": "parse_parameter_option( option )\n\nReturns the symbol for a valid parameter format string in an option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_resistance_option-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_resistance_option",
    "category": "method",
    "text": "parse_resistance_option( option )\n\nReturns the value of the characteristic impedance for a valid resistance string in an option line.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_three_port_data",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_three_port_data",
    "category": "function",
    "text": "parse_three_port_data( line, [ options ] )\n\nReturns a data point structure for a valid line of a three-port Touchstone file.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.parse_two_port_data",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.parse_two_port_data",
    "category": "function",
    "text": "parse_two_port_data( line, [ options ] )\n\nReturns a data point structure for a valid line of a two-port Touchstone file.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_comment_line-Tuple{Any}",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_comment_line",
    "category": "method",
    "text": "write_comment_line( comment )\n\nReturns a comment line string for a comment.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_format_option",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_format_option",
    "category": "function",
    "text": "write_format_option( [ symbol ] )\n\nReturns an option line string for a valid data format symbol.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_four_port_data",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_four_port_data",
    "category": "function",
    "text": "write_four_port_data( data, [ options ] )\n\nReturns a string for a four-port Touchstone formated line for a data point.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_frequency_unit_option",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_frequency_unit_option",
    "category": "function",
    "text": "write_frequency_unit_option( [ value ] )\n\nReturns an option line string for a valid frequency unit multiplier.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_one_port_data",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_one_port_data",
    "category": "function",
    "text": "write_one_port_data( data, [ options ] )\n\nReturns a string for a one-port Touchstone formated line for a data point.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_option_line",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_option_line",
    "category": "function",
    "text": " write_option_line( [ options ] )\n\nReturns the option line string for an option structure.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_parameter_option",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_parameter_option",
    "category": "function",
    "text": "write_parameter_option( [ symbol ] )\n\nReturns an option line string for a valid parameter option symbol.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_resistance_option",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_resistance_option",
    "category": "function",
    "text": "write_resistance_option( [ resistance ] )\n\nReturns an option line string for the characteristic impedance.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_three_port_data",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_three_port_data",
    "category": "function",
    "text": "write_three_port_data( data, [ options ] )\n\nReturns a string for a three-port Touchstone formated line for a data point.\n\n\n\n\n\n"
},

{
    "location": "index.html#Touchstone.write_two_port_data",
    "page": "Touchstone.jl Documentation",
    "title": "Touchstone.write_two_port_data",
    "category": "function",
    "text": "write_two_port_data( data, [ options ] )\n\nReturns a string for a two-port Touchstone formated line for a data point.\n\n\n\n\n\n"
},

{
    "location": "index.html#Types-and-Methods-1",
    "page": "Touchstone.jl Documentation",
    "title": "Types and Methods",
    "category": "section",
    "text": "Modules = [ Touchstone ]"
},

{
    "location": "index.html#Index-1",
    "page": "Touchstone.jl Documentation",
    "title": "Index",
    "category": "section",
    "text": ""
},

]}
