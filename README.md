# hdfqlr <a href='https://github.com/mkoohafkan/hdfqlr'><img src='man/figures/logo.png' align="right" height="139" /></a>
<!-- badges: start -->
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/hdfqlr)](http://cran.r-project.org/package=hdfqlr)
[![Project Status: Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![R-CMD-check](https://github.com/mkoohafkan/hdfqlr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mkoohafkan/hdfqlr/actions/workflows/R-CMD-check.yaml)
[![CRAN_Download_Badge](https://cranlogs.r-pkg.org/badges/grand-total/hdfqlr)](http://cran.r-project.org/package=hdfqlr)
<!-- badges: end -->

The `hdfqlr` package for R provides an API for HDF file access using 
[HDFql](http://www.hdfql.com/). In order to use this package, you will 
need to [download HDFql](http://www.hdfql.com/#download) for your 
system. See the [Quick Start](vignettes/quickstart.md) vignette to 
get started.

**NOTE 7/10/2019: The HDFql 2.1.0 release contains a
minor but necessary change in the R wrapper, specifically in
the `.Call()` specifications for accessing C functions in
the HDFql library. `hdfqlr` will not correctly load prior 
versions of HDFql.**
