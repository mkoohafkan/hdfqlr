Submission of hdfqlr 0.5-0

This is a new release.

## Test environments
* local Windows 10 install, R 3.6.0
* ubuntu 14.04 (on travis-ci), R-oldrel, R-release, R-devel

Because the package requires the external program HDFql, examples 
are only run on build if HDFql is available. In my test environments, 
I created the environment variable CIMIS_APPKEY with my personal 
key to run the examples on build.


## R CMD check results

0 errors | 0 warnings | 1 note
