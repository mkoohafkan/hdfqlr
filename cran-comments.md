Submission of hdfqlr 0.6-2

This patch release adds `package:rmarkdown` to the SUGGESTS
list following a change to `package:knitr` dependencies.

## Test environments
* local Windows 10 install, R 4.1.0
* R-CMD Check via GitHub Actions with macOS-latest 

Because the package requires the external program HDFql, examples 
are only run on build if HDFql is available. In my test environments, 
I installed HDFql and created the environment variable HDFQL_DIR 
to run the examples on build.


## R CMD check results

0 errors | 0 warnings | 0 notes
