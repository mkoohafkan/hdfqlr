devtools::load_all()
knitr::knit("vignettes/_quickstart.rmd", "vignettes/quickstart.rmd")
file.copy("vignettes/quickstart.rmd", "vignettes/quickstart.md")