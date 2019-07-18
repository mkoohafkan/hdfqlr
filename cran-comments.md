Submission of hdfqlr 0.6-0

This is a resubmission to address CRAN comments:

* Package names, software names and API names are now in single quotes 
(e.g. 'HDFql') in title and description.
* All examples/tests/vignettes write files to tempdir() to conform to
CRAN policies specifying that functions do not write by default or in your
examples/vignettes/tests in the user's home filespace (including the
package directory and getwd()). 

## Test environments
* local Windows 10 install, R 3.6.0
* ubuntu 14.04 (on travis-ci), R-oldrel, R-release, R-devel

Because the package requires the external program HDFql, examples 
are only run on build if HDFql is available. In my test environments, 
I installed HDFql and created the environment variable HDFQL_DIR 
to run the examples on build.


## R CMD check results

0 errors | 0 warnings | 0 notes
