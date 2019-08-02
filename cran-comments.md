Submission of hdfqlr 0.6-0

This is a resubmission to address CRAN comments:

* Added web references for the 'HDFql' API in your
  Description text in the form <http:...>. Note that
  https is not currently supported on the HDFql web site.

## Test environments
* local Windows 10 install, R 3.6.1
* ubuntu 14.04 (on travis-ci), R-oldrel, R-release, R-devel

Because the package requires the external program HDFql, examples 
are only run on build if HDFql is available. In my test environments, 
I installed HDFql and created the environment variable HDFQL_DIR 
to run the examples on build.


## R CMD check results

0 errors | 0 warnings | 0 notes
