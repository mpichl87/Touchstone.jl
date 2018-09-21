# Touchstone

[![Build Status Linux](https://travis-ci.org/mpichl87/Touchstone.jl.svg?branch=master)](https://travis-ci.org/mpichl87/Touchstone.jl)
[![Build Status Windows](https://ci.appveyor.com/api/projects/status/github/mpichl87/Touchstone.jl?svg=true)](https://ci.appveyor.com/project/mpichl87/touchstone-jl?svg=true)
[![Coverage Status](https://coveralls.io/repos/github/mpichl87/Touchstone.jl/badge.svg?branch=master)](https://coveralls.io/github/mpichl87/Touchstone.jl?branch=master)
[![codecov](https://codecov.io/gh/mpichl87/Touchstone.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/mpichl87/Touchstone.jl)
[![Stable Doc](https://img.shields.io/badge/docs-stable-blue.svg)](https://mpichl87.github.io/Touchstone.jl/stable)
[![Latest Doc](https://img.shields.io/badge/docs-latest-blue.svg)](https://mpichl87.github.io/Touchstone.jl/latest)


## Changelog

### v1.0.3

- Move exception to inner constructors. 
- Write 1.0 files: Noise Data added.

### v1.0.2

- Only 2 port G- or H-parameters in V1.0 files allowed.
- Check limit of four complex parameters per line for V1.0 data.
- Checks for ascending frequencies.
- Parses Noise Data for V1.0 files.

### v1.0.1

Version 2.0 parser works in most cases.

TODO:

- Parse Noise Data
- Parse [Matrix Format) and implement upper and lower triangular datasets.
- Check [Mixed-Mode Order] parameters.
- Write Version 2.0 format.


### v1.0.0

Version 1.0 works in most cases.

TODO:

- Normalization for Z, Y, G and H parameters.
- Check limit of four complex parameters per line.
- Check for ascending frequencies.

Comments at end of line work now.

### v0.1.6

parse_touchstone_file interpretes file extension .

### v0.1.5

Parses and writes N-port Touchstone V1.0 files, streams and strings.

### v0.1.4

Parsing and writing refactored, better Tests.

### v0.1.3

Added documentation with Documenter.jl.

### v0.1.2

Reads and writes 1 - 4 port Touchstone V1.0 files.

### v0.1.1

Parses one, two, three or four port Touchstone V1.0 data.

### v0.1.0

Parses one, or two port Touchstone V1.0 data.
