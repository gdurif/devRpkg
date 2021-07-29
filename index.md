---
title: "Developing an R package: a tutorial"
author: "Ghislain Durif"
institute: "CNRS -- IMAG (Montpellier, France)"
date: July 2021
output: 
  binb::metropolis:
    includes:
      in_header: .latex_style.sty
classoption: "aspectratio=169,12pt"
---

## Note for the reader

Many [**hyperlinks**](https://en.wikipedia.org/wiki/Hyperlink) are directly embedded in the slide contents.

## Requirements (1)

- [**R**](https://www.r-project.org/) (the latest version if possible\footnote{Keep your software up-to-date! If you need an older version of R for a specific project, use appropriate tools like containers, it should be an exception not a habit.}, `4.1.0` since 2021-05-18)\bigskip

- You can use the R command line combined with any text editor, but we recommend to use an R-oriented IDE\footnote{\href{https://en.wikipedia.org/wiki/Integrated_development_environment}{Integrated Development Environment}} like [**Rstudio**](https://www.rstudio.com/products/rstudio/) or [RKWard](https://rkward.kde.org/) \bigskip

- All content presented here have been tested on a Linux environment but should work on **any OS** \bigskip

- **Note for Windows users:** you can update R from within R with the [`installr`](https://www.r-project.org/nosvn/pandoc/installr.html) package and you will need to install [Rtools](https://cran.r-project.org/bin/windows/Rtools/) to enable all R development functionality \bigskip

## Requirements (2)

- See the script [`install_requirements.R`](./install_requirements.R) to install the packages that will be used in the tutorial \bigskip \bigskip

- To (re)generate the slides, see the scripts^[or the attached [`Makefile`](./Makefile) if you are confortable with using `make`] [`.setup.R`](./.setup.R) to install the requirement, [`.build.R`](./.build.R) to build the `pdf` slides

## References

- **Official R documentation**: [_Writing R Extensions_](https://cran.r-project.org/doc/manuals/R-exts.html) \bigskip
- [Karl Broman](https://kbroman.org/) **tutorial**: _R package primer_ ([web version](https://kbroman.org/pkg_primer/) and [sources](https://github.com/kbroman/pkg_primer/)) \bigskip
- [Hadley Wickham](http://had.co.nz/) and [Jenny Bryan](https://jennybryan.org/) **book**: _R packages_ ([web version](https://r-pkgs.org/) and [sources](https://github.com/hadley/r-pkgs)) \bigskip
- [Hilary Parker](https://hilaryparker.com)
[**tutorial** on writing R packages](https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/) \bigskip
- [Rstudio **cheatsheets**](https://github.com/rstudio/cheatsheets) on [package development](https://raw.githubusercontent.com/rstudio/cheatsheets/master/package-development.pdf) and [Rstudio IDE](https://raw.githubusercontent.com/rstudio/cheatsheets/master/rstudio-ide.pdf)

## What is an R package?

- a library containing a set of R functions (and possibly more) implementing functionality not available in default R functions\footnote{or reimplementing existing functionality in a different way} \bigskip

- a standardized way to distribute R codes (for other users) \bigskip

## Where can I find R packages?

- the [`CRAN`](https://cran.r-project.org/) (Comprehensive R Archive Network): official repository for R packages
```R
install.packages("devtools")
```

- [`bioconductor`](https://www.bioconductor.org/): bioinformatics-oriented package repository \bigskip

- any git forge: github, gitlab \bigskip

- on your colleagues' computers\footnote{if they develop in R} \bigskip

## Why R packages?

- The **best way** to write and distribute **R code** with **documentation**,  **examples**, **tests**, etc. \bigskip

- A good practice\footnote{even for codes you don't plan to publish/distribute} when coding in R: \medskip
  - your project is structured (code, data, doc), easier to use and re-use \smallskip
  - documentation is essential (including for your future self)  \smallskip
  - your code is standardized, you can check it and test your functions \smallskip
  - easy management of dependencies
  - etc.

## How to write an R package?

A wide variety of tools to help you:

- Rstudio IDE built-in development features \bigskip

- R base built-in tools: build (`R CMD build`), check (`R CMD check`) \bigskip

- Some packages to develop packages:\medskip
  - [`usethis`](https://usethis.r-lib.org): to automate package and project setup
  - [`devtools`](https://devtools.r-lib.org): complete collection of development tools 
  - [`roxygen2`](https://roxygen2.r-lib.org): to document your code and generate help pages
  - [`testthat`](https://testthat.r-lib.org/): to implement automatic tests of your functions
  - [`remotes`](https://remotes.r-lib.org): to install package from anywhere (integrated in `devtools`)
  - [`rmarkdown`](https://rmarkdown.rstudio.com) and [`knitr`](https://yihui.org/knitr): to create detailed documentation materials and notebooks (code showcase)


## Outline

\footnotesize

1. The essentials to write your package ([`.md`](.content/1_essential.md) and [`.pdf`](.content/1_essential.pdf))

- Getting started
- R package structure
- Workflow


2. Going further with your R package development ([`.md`](.content/2_additonal.md) and [`.pdf`](.content/2_additonal.pdf))

- Getting started
- Digression: Good practice for software development and programming (not just in R)
- Test your functions
- Sharing (your code) is caring
- Advanced documentation
- Non R code
- Control your R environment
