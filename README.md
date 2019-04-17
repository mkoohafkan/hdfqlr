# hdfqlr <a href='https://github.com/mkoohafkan/hdfqlr'><img src='man/figures/logo.png' align="right" height="139" /></a>
[![Build Status](https://travis-ci.org/mkoohafkan/hdfqlr.svg?branch=master)](https://travis-ci.org/mkoohafkan/hdfqlr)

The `hdfqlr` package for R provides an API for HDF file access using 
[HDFql](http://www.hdfql.com/). In order to use this package, you will 
need to [download HDFql](http://www.hdfql.com/#download) for your 
system. See the [Quick Start](vignettes/quickstart.md) vignette to 
get started.

**NOTE 4/17/2019: The HDFql Q3 release (probably 2.0.2) will contain a
minor but necessary change in the R wrapper, specifically in
the `.Call()` specifications for accessing C functions in
the HDFql library. If you want to use this package before the
Q3 release, overwrite the contents of HDFql.R in the HDFql
install directory with the contents of [HDFql-mod.R](HDFql-mod.R).**
