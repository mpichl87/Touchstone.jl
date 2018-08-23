var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#Touchstone.jl-1",
    "page": "Home",
    "title": "Touchstone.jl",
    "category": "section",
    "text": "Parses and writes N-port Touchstone V1.0 files, streams and strings.See the Index for the complete list of documented functions and types."
},

{
    "location": "index.html#Library-Outline-1",
    "page": "Home",
    "title": "Library Outline",
    "category": "section",
    "text": "Pages = [\n  \"public.md\",\n  \"internals.md\"\n]"
},

{
    "location": "index.html#main-index-1",
    "page": "Home",
    "title": "Index",
    "category": "section",
    "text": "Pages = [\n  \"public.md\"\n]"
},

{
    "location": "public.html#",
    "page": "Public",
    "title": "Public",
    "category": "page",
    "text": ""
},

{
    "location": "public.html#Public-Documentation-1",
    "page": "Public",
    "title": "Public Documentation",
    "category": "section",
    "text": "Documentation for Touchstone.jl\'s public interface.See Internal Documentation for internal package docs covering all submodules."
},

{
    "location": "public.html#Contents-1",
    "page": "Public",
    "title": "Contents",
    "category": "section",
    "text": "Pages = [\n  \"public.md\"\n]"
},

{
    "location": "public.html#Index-1",
    "page": "Public",
    "title": "Index",
    "category": "section",
    "text": "Pages = [\n  \"public.md\"\n]"
},

{
    "location": "public.html#Touchstone.DataPoint",
    "page": "Public",
    "title": "Touchstone.DataPoint",
    "category": "type",
    "text": "Holds scalar frequency and parameter matrix for one data point.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.Options",
    "page": "Public",
    "title": "Touchstone.Options",
    "category": "type",
    "text": "Holds values from option line.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.TS",
    "page": "Public",
    "title": "Touchstone.TS",
    "category": "type",
    "text": "Holds data for Touchstone file.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.angs",
    "page": "Public",
    "title": "Touchstone.angs",
    "category": "function",
    "text": "angs( ts, p1, p2 )\n\nGets the vector of the angles in radians of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.dBmags",
    "page": "Public",
    "title": "Touchstone.dBmags",
    "category": "function",
    "text": "dBmags( ts, p1, p2 )\n\nGets the vector of the magnitudes in dB of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.freqs-Tuple{TS}",
    "page": "Public",
    "title": "Touchstone.freqs",
    "category": "method",
    "text": "freqs( ts )\n\nGets the frequency vector from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.imags",
    "page": "Public",
    "title": "Touchstone.imags",
    "category": "function",
    "text": "imags( ts, p1, p2 )\n\nGets the vector of the imaginary parts of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.mags",
    "page": "Public",
    "title": "Touchstone.mags",
    "category": "function",
    "text": "mags( ts, p1, p2 )\n\nGets the vector of the magnitudes of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.param",
    "page": "Public",
    "title": "Touchstone.param",
    "category": "function",
    "text": "param( ts, p1, p2 )\n\nGets the vector of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.params-Tuple{TS}",
    "page": "Public",
    "title": "Touchstone.params",
    "category": "method",
    "text": "params( ts )\n\nGets the vector of parameter matrices from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.parse_touchstone_file",
    "page": "Public",
    "title": "Touchstone.parse_touchstone_file",
    "category": "function",
    "text": "parse_touchstone_file( filename, [ ports ] )\n\nReturns a TS structure for a valid Touchstone data file. Works for ports = 1, 2, 3 or 4.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.parse_touchstone_stream",
    "page": "Public",
    "title": "Touchstone.parse_touchstone_stream",
    "category": "function",
    "text": "parse_touchstone_stream( stream, [ ports ] )\n\nReturns a TS structure for a valid Touchstone data stream.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.parse_touchstone_string",
    "page": "Public",
    "title": "Touchstone.parse_touchstone_string",
    "category": "function",
    "text": "parse_touchstone_string( in, [ ports ] )\n\nReturns a TS structure for a valid Touchstone data string. Works for ports = 1, 2, 3 or 4.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.reals",
    "page": "Public",
    "title": "Touchstone.reals",
    "category": "function",
    "text": "reals( ts, p1, p2 )\n\nGets the vector of the real parts of parameters with indices p1, p2 from Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.write_touchstone_file-Tuple{String,TS}",
    "page": "Public",
    "title": "Touchstone.write_touchstone_file",
    "category": "method",
    "text": "write_touchstone_file( filename, ts )\n\nWrites formated Touchstone data for a TS structure to a file.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.write_touchstone_stream-Tuple{IO,TS}",
    "page": "Public",
    "title": "Touchstone.write_touchstone_stream",
    "category": "method",
    "text": "write_touchstone_stream( stream, ts )\n\nWrites formated Touchstone data for a TS structure to a stream.\n\n\n\n\n\n"
},

{
    "location": "public.html#Touchstone.write_touchstone_string-Tuple{TS}",
    "page": "Public",
    "title": "Touchstone.write_touchstone_string",
    "category": "method",
    "text": "write_touchstone_string( ts )\n\nReturns a string with formated Touchstone data for a TS structure.\n\n\n\n\n\n"
},

{
    "location": "public.html#Public-Interface-1",
    "page": "Public",
    "title": "Public Interface",
    "category": "section",
    "text": "Modules = [\n  Touchstone\n]\nPrivate = false"
},

{
    "location": "internals.html#",
    "page": "Internals",
    "title": "Internals",
    "category": "page",
    "text": ""
},

{
    "location": "internals.html#Internal-Documentation-1",
    "page": "Internals",
    "title": "Internal Documentation",
    "category": "section",
    "text": "This page lists all the documented internals of the Documenter module and submodules."
},

{
    "location": "internals.html#Contents-1",
    "page": "Internals",
    "title": "Contents",
    "category": "section",
    "text": "Pages = [\n  \"internals.md\"\n]"
},

{
    "location": "internals.html#Index-1",
    "page": "Internals",
    "title": "Index",
    "category": "section",
    "text": "A list of all internal documentation.Pages = [\n  \"internals.md\"\n]"
},

{
    "location": "internals.html#Touchstone.ParseConversions",
    "page": "Internals",
    "title": "Touchstone.ParseConversions",
    "category": "constant",
    "text": "Holds conversion functions for parameter format symbols when parsing.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.WriteConversions",
    "page": "Internals",
    "title": "Touchstone.WriteConversions",
    "category": "constant",
    "text": "Holds conversion functions for parameter format symbols when writing.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.default_format",
    "page": "Internals",
    "title": "Touchstone.default_format",
    "category": "constant",
    "text": "The default data format, if not found in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.default_format_symbol",
    "page": "Internals",
    "title": "Touchstone.default_format_symbol",
    "category": "constant",
    "text": "Default data format symbol to use in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.default_parameter",
    "page": "Internals",
    "title": "Touchstone.default_parameter",
    "category": "constant",
    "text": "The default parameter format, if not found in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.default_parameter_symbol",
    "page": "Internals",
    "title": "Touchstone.default_parameter_symbol",
    "category": "constant",
    "text": "Defaoult parameter format symbo to use in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.default_resistance",
    "page": "Internals",
    "title": "Touchstone.default_resistance",
    "category": "constant",
    "text": "The default characteristic impedance, if not found in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.default_resistance_string",
    "page": "Internals",
    "title": "Touchstone.default_resistance_string",
    "category": "constant",
    "text": "Default characteristic iimpedance to use in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.default_unit_value",
    "page": "Internals",
    "title": "Touchstone.default_unit_value",
    "category": "constant",
    "text": "Default unit value to use in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.default_units",
    "page": "Internals",
    "title": "Touchstone.default_units",
    "category": "constant",
    "text": "The default unit, if not found in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.formats",
    "page": "Internals",
    "title": "Touchstone.formats",
    "category": "constant",
    "text": "Symbols for data format for strings found in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.formatstrings",
    "page": "Internals",
    "title": "Touchstone.formatstrings",
    "category": "constant",
    "text": "String for data format symbols in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.parameters",
    "page": "Internals",
    "title": "Touchstone.parameters",
    "category": "constant",
    "text": "Symbols for different parameter formats for strings found in option line\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.parameterstrings",
    "page": "Internals",
    "title": "Touchstone.parameterstrings",
    "category": "constant",
    "text": "Strings for parameter format symbols in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.units",
    "page": "Internals",
    "title": "Touchstone.units",
    "category": "constant",
    "text": "Values for units for strings found in option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.unitstrings",
    "page": "Internals",
    "title": "Touchstone.unitstrings",
    "category": "constant",
    "text": "String for unit multiplier in option line\n\n\n\n\n\n"
},

{
    "location": "internals.html#Base.:==-Tuple{Any,DataPoint}",
    "page": "Internals",
    "title": "Base.:==",
    "category": "method",
    "text": "Compares data points.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Base.:==-Tuple{Any,Options}",
    "page": "Internals",
    "title": "Base.:==",
    "category": "method",
    "text": "Compares Options.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Base.:==-Tuple{Any,TS}",
    "page": "Internals",
    "title": "Base.:==",
    "category": "method",
    "text": "Compares Touchstone data.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Base.:≈-Tuple{Any,DataPoint}",
    "page": "Internals",
    "title": "Base.:≈",
    "category": "method",
    "text": "Compares data points approximately.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.comp2da-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.comp2da",
    "category": "method",
    "text": "comp2da( z )\n\nReturns a pair with the magnitude in dB and angle in degrees of a complex number.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.comp2ma-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.comp2ma",
    "category": "method",
    "text": "comp2ma( z )\n\nReturns a pair with the linear magnitude and angle in degrees of a complex number.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.compstring-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.compstring",
    "category": "method",
    "text": "compstring( z )\n\nReturns a pair with the real and imaginary components of a complex number.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.da2comp-Tuple{Any,Any}",
    "page": "Internals",
    "title": "Touchstone.da2comp",
    "category": "method",
    "text": "da2comp( m, a )\n\nConverts a pair of values in dB / angle format to a complex number.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.dastring-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.dastring",
    "category": "method",
    "text": "dastring( z )\n\nReturns a string in dB / angle format of a complex number.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.is_comment_line-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.is_comment_line",
    "category": "method",
    "text": "is_commentline( line )\n\nChecks, if a line is a comment line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.is_empy_line-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.is_empy_line",
    "category": "method",
    "text": "is_empy_line( line )\n\nChecks, if a line is empty.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.is_format_option-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.is_format_option",
    "category": "method",
    "text": "is_format_option( option )\n\nChecks, if a string is a valid data format in an option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.is_frequency_unit_option-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.is_frequency_unit_option",
    "category": "method",
    "text": "is_frequency_unit_option( option )\n\nChecks, if a string is a valid unit in an option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.is_keyword_line-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.is_keyword_line",
    "category": "method",
    "text": "is_keyword_line( line )\n\nChecks, if a line is a valid keyword line.\n\nTODO: Needed for Version 2.0, which is not implemented for now.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.is_option_line-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.is_option_line",
    "category": "method",
    "text": "is_option_line( line )\n\nChecks, if a line is a option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.is_parameter_option-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.is_parameter_option",
    "category": "method",
    "text": "is_parameter_option( option )\n\nChecks, if a string is a valid parameter format in an option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.is_resistance_option-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.is_resistance_option",
    "category": "method",
    "text": "is_resistance_option( option )\n\nChecks, if a string is a valid resistance in an option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.ma2comp-Tuple{Any,Any}",
    "page": "Internals",
    "title": "Touchstone.ma2comp",
    "category": "method",
    "text": "ma2comp( m, a )\n\nConverts a pair of values in magnitude / angle format to a complex number.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.mastring-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.mastring",
    "category": "method",
    "text": "mastring( z )\n\nReturns a string in magnitude / angle format of a complex number.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.pairstring-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.pairstring",
    "category": "method",
    "text": "pairstring( pair )\n\nReturns a string combining the components of a pair.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.parse_comment_line-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.parse_comment_line",
    "category": "method",
    "text": "parse_comment_line( line )\n\nReturns the comment of a comment line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.parse_data",
    "page": "Internals",
    "title": "Touchstone.parse_data",
    "category": "function",
    "text": "parse_data( line, N, [ options ] )\n\nReturns a data point structure for a valid line of a one-port Touchstone file.\n\nFor 3 or more ports, the line should be the concatenation of 3 or more lines from the Touchstone file.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.parse_data",
    "page": "Internals",
    "title": "Touchstone.parse_data",
    "category": "function",
    "text": "parse_data( vals, N, [ options ] )\n\nReturns a data point structure for a vector of numbers from a one-port Touchstone file.\n\nFor 3 or more ports, the array should contain exactly 2N² + 1 values.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.parse_format_option-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.parse_format_option",
    "category": "method",
    "text": "parse_format_option( option )\n\nReturns the symbol for a valid data format string in an option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.parse_frequency_unit_option-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.parse_frequency_unit_option",
    "category": "method",
    "text": "parse_frequency_unit_option( option )\n\nReturns the multiplier for a unit string in an option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.parse_option_line-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.parse_option_line",
    "category": "method",
    "text": "parse_option_line( line )\n\nReturns the option structure for a valid option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.parse_parameter_option-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.parse_parameter_option",
    "category": "method",
    "text": "parse_parameter_option( option )\n\nReturns the symbol for a valid parameter format string in an option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.parse_resistance_option-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.parse_resistance_option",
    "category": "method",
    "text": "parse_resistance_option( option )\n\nReturns the value of the characteristic impedance for a valid resistance string in an option line.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.write_comment_line-Tuple{Any}",
    "page": "Internals",
    "title": "Touchstone.write_comment_line",
    "category": "method",
    "text": "write_comment_line( comment )\n\nReturns a comment line string for a comment.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.write_data",
    "page": "Internals",
    "title": "Touchstone.write_data",
    "category": "function",
    "text": "write_data( data, N [ options ] )\n\nReturns a string for N-port Touchstone formated lines for a data point.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.write_format_option",
    "page": "Internals",
    "title": "Touchstone.write_format_option",
    "category": "function",
    "text": "write_format_option( [ symbol ] )\n\nReturns an option line string for a valid data format symbol.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.write_frequency_unit_option",
    "page": "Internals",
    "title": "Touchstone.write_frequency_unit_option",
    "category": "function",
    "text": "write_frequency_unit_option( [ value ] )\n\nReturns an option line string for a valid frequency unit multiplier.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.write_option_line",
    "page": "Internals",
    "title": "Touchstone.write_option_line",
    "category": "function",
    "text": " write_option_line( [ options ] )\n\nReturns the option line string for an option structure.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.write_parameter_option",
    "page": "Internals",
    "title": "Touchstone.write_parameter_option",
    "category": "function",
    "text": "write_parameter_option( [ symbol ] )\n\nReturns an option line string for a valid parameter option symbol.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Touchstone.write_resistance_option",
    "page": "Internals",
    "title": "Touchstone.write_resistance_option",
    "category": "function",
    "text": "write_resistance_option( [ resistance ] )\n\nReturns an option line string for the characteristic impedance.\n\n\n\n\n\n"
},

{
    "location": "internals.html#Internal-Package-Docs-1",
    "page": "Internals",
    "title": "Internal Package Docs",
    "category": "section",
    "text": "Modules = [\n  Touchstone\n]\nPublic = false"
},

]}
