---
title: "Developing an R package: a tutorial"
subtitle: "Going further with your R package development"
author: "Ghislain Durif (https://gdurif.perso.math.cnrs.fr/)"
institute: "CNRS -- LBMC (Lyon, France)"
date: July 2022
output: 
  binb::metropolis:
    includes:
      in_header: ../.latex_style.sty
classoption: "aspectratio=169,12pt"
---

# Getting started

## Additional R packages to help you create R packages

- [`testthat`](https://testthat.r-lib.org/) to implement automatic tests of your functions \bigskip
- [`remotes`](https://remotes.r-lib.org) to install package from anywhere (integrated in `devtools`) \bigskip
- [`rmarkdown`](https://rmarkdown.rstudio.com) and [`knitr`](https://yihui.org/knitr) to create detailed documentation materials and notebooks (code showcase) \bigskip
- [`pkgdown`](https://pkgdown.r-lib.org/) to create a website for your package \bigskip

## Setup your environment

- install additional R packages providing development tools: `testthat`, `remotes`^[not necessary if you already installed `devtools`]
```R
install.packages(c("testthat"))
```

## Additional references regarding R programming

- [Hadley Wickham](http://had.co.nz/) **book**: _Advanced R_ ([web version](https://adv-r.hadley.nz) and [sources](https://github.com/hadley/adv-r))

# Digression: Good practice for software development and programming (not just in R)

## Good practice (1)

- The code should be **human readable**^[being machine readable is necessary for the code to work but not sufficient] and **easily understandable** (use comments, code presentation and formatting)
  - Experiment: read your (5 weeks/months/years) old codes, are you sure that you will understand it? (worst with code written by others) \bigskip

- Use a **versioning system** (e.g. [`git`](https://git-scm.com/book/)) to manage your code evolution/version and for collaborative development \bigskip

## Good practice (2)

- Implement **automatic tests** (e.g. unit tests) for each new function/module/etc. (and not afterward) to **verify your implementation and results** and avoid breaking your code^[never trust yourself, you will implement bugs] \bigskip

- Use **continuous integration**^[software forge offers such service like [`gitlab CI/CD`](https://docs.gitlab.com/ee/ci/) or [`github` actions](https://github.com/features/actions)]: to automatically run build, check, tests as your package development progresses (e.g. commit after commit if you are using a versioning system like `git`)

## Good practice (3)

- Write a **documentation** for your code/package/library, including explained code showcases/demos \bigskip

- **Publish** your source codes (preferably on a software forge), so that other can continue your work, especially when you move on to other projects, carreer path \bigskip

- **Archive** your source codes (because your software forge or webpage can disappear) \bigskip

## Software forge (1)

An online server and/or website offering code/software development and management functionality

- versioning
- collaborative work and planning
- issue, feedback, bug reports, feature requests
- software release/publication
- continuous integration
- possibility to get a publication identification like a DOI^[eventually externally with [Zenodo](https://zenodo.org/), c.f. later]
- etc.

## Software forge (2)

Examples of software forge

- `gitlab`: **free and open-source `git` forge hosting software** (different hosts are available: in the academic world^[e.g. <https://plmlab.math.cnrs.fr>, <https://gitlab.inria.fr>, etc.] or abroad^[e.g. <https://gitlab.com>]) \medskip
- [`github`](https://github.com): **very popular**^[but owned by Microsoft] `git` forge with gratis and commercial solutions to host development projects (maybe more simple to reach outside the french academic community) \medskip
- other: [`bitbucket`](https://bitbucket.org) \medskip

**Discontinued forges:** `gitorious`, `Google code`, `Inria Gforge` (It happens!) \bigskip


## Archive your code (publication $\ne$ archiving)

- What happens if your software forge (or the webpage where you host your code) disappear ? \bigskip

- The [**Software Heritage** initiative](https://www.softwareheritage.org)
  - "Our ambition is to collect, preserve, and share all software that is publicly available in source code form. On this foundation, a wealth of applications can be built, ranging from cultural heritage to industry and research."
  - Simple deposit procedure from a software forge^[See <https://archive.softwareheritage.org/save/>]

## Get a DOI for your code with Zenodo

- a DOI^[[Digital Object Identifier](https://en.wikipedia.org/wiki/Digital_object_identifier)] to facilitate your software identification and citation (e.g. in publication using it) \bigskip

- Upload your codes to [Zenodo](https://zenodo.org/) and get a unique DOI for the current version (possible integration with `github` to directly generate identification for the different versions of your code) \bigskip

- Possible to identify codes, datasets, creative contents \bigskip

- More at <https://help.zenodo.org/features/> and in the [FAQ](https://help.zenodo.org/) \bigskip


# Test your functions

## Implement automatic tests with testthat (1)

- [`testthat`](https://testthat.r-lib.org) provides a seamless (and user-friendly) workflow to implement automatic tests for your package \bigskip

- **Good practice:**
  - write tests when you code functions (and not after)
  - as soon as you create/modify a function, verify if tests are passing
  
## Implement automatic tests with testthat (2)

\footnotesize

:::::: {.columns}
::: {.column width="50%"}

- To enable `testthat` in your package: [`usethis::use_testthat()`](https://usethis.r-lib.org/reference/use_testthat.html) \bigskip

- To create a test case: [`usethis::use_test()`](https://usethis.r-lib.org/reference/use_r.html) (e.g. `usethis::use_test("feature1")`) \bigskip

- Test file example:
```R
test_that("multiplication works", {
    res <- my_multiplication(2, 2)
    expect_equal(res, 4)
})
```

:::
::: {.column width="50%"}

`tests` sub-directory structure after initialization
```
tests
+-- testthat
+-- testthat.R
```

`tests` sub-directory structure after creating a test
```
tests
+-- testthat
|   +-- test-feature1.R
+-- testthat.R
```

:::
::::::


## Implement automatic tests with testthat (3)

- Tests use `expect_XX()` functions to verify conditions of any type on any R expression \bigskip

- Unit tests (i.e. test regarding a single function/functionality) can be grouped into `test_that("id", {})` chunks \bigskip

- You have to enumerate and write yourself all test cases \bigskip

- More details at <https://r-pkgs.org/tests.html> and [`testthat` exhaustive tour](https://testthat.r-lib.org/reference/index.html)

## test 

**Verify** that the **test you write are passing** (e.g. your code is doing what you want)

- [`devtools::test()`](https://devtools.r-lib.org/reference/test.html) \bigskip

- in Rstudio interface (Build panel - More - Test package^[keyboard shortcut:
`CTRL + SHIFT + T`]) \bigskip

- **Note:** tests will be run during package check

# Sharing (your code) is caring

## Publish and distribute your package

- Others can use your work, collaborate with you to improve it (collaborative development) \bigskip

- Many repositories: the [CRAN](https://cran.r-project.org/) (official), [bioconductor](https://www.bioconductor.org/) (bioinformatics-oriented package repository) \bigskip

- the [`remotes` package](https://remotes.r-lib.org/) (exported by `devtools`) can be used to install packages stored almost anywhere on the Internet (`CRAN`, `bioconductor`, `git` forges, etc.) or locally \bigskip

## CRAN

- [Strict policy to accept a package](https://cran.r-project.org/web/packages/policies.html) (**READ IT!**) \bigskip

- Pipeline
  1. [`devtools::build()`](https://devtools.r-lib.org//reference/build.html) (or `R CMD build`)
  2. [`devtools::check()`](https://devtools.r-lib.org//reference/check.html) (or `R CMD check --as-cran`)
  3. upload it^[in bundle state] to <https://cran.r-project.org/submit.html> \bigskip

- [`devtools::release()`](https://devtools.r-lib.org//reference/release.html) can help you to prepare the release (i.e. the version of your package that will be publish) \bigskip

## Reverse dependencies

- **Important**: if you are releasing a new version of existing package, it is your responsibility to check that it does not break downstream dependencies^[called "reverse dependencies"] (i.e. all packages that list your package in the `Depends`, `Imports`, `Suggests` or `LinkingTo` fields) \bigskip

- [`usethis::use_revdep()`](https://usethis.r-lib.org/reference/use_revdep.html) to enable the [`revdepcheck` package](https://r-lib.github.io/revdepcheck/) that can help you in that task

## git

- versioning system: see the [`official website`](https://git-scm.com/) and the [`book`](https://git-scm.com/book/)
  - manage evolution of your code
  - branch-base system for production/development code cohabitation
  - decentralized system: if you lose your remote, you do not lose the project history
  - easy to distribute (with `git clone`) and to move from remote to remote \bigskip

- Command line tool or possible to manage everything from R/Rstudio:
  - [`usethis::use_git()`](https://usethis.r-lib.org/reference/use_git.html) to initialize a repository in your project
  - Git panel in Rstudio to manage your local repository and interact with remote (ssh key generation, etc.) \bigskip

- More detail at <https://r-pkgs.org/git.html> \bigskip

## Distribute your package on a git repository

To install packages hosted on:

- `github`: [`remotes::install_github()`](https://remotes.r-lib.org/reference/install_github.html)
- any `git` forge: [`remotes::install_git()`](https://remotes.r-lib.org/reference/install_git.html)

Possibility to specify the branch, the sub-directory where to find the package, etc.

```R
remotes::install_github("RcppCore/Rcpp")

remotes::install_git(
    "https://github.com/getkeops/keops",
    subdir = "rkeops", branch = "dev", args="--recursive"
)
```

## Organize your package project

- Package root directory = Rstudio project/git repository root directory (default behavior when using `usethis::create_package()` or Rstudio new project package) \bigskip

- The package root directory is a sub-directory of the Rstudio project/git repository
  - you can specify the path to your package directory to `devtools` functions
  - Rstudio project setup: Tools - Project Options - Build tools - Package directory

# Advanced documentation

## Writing a "vignette"

\small

- A document^[See <https://r-pkgs.org/vignettes.html>] presenting/detailing your package (or a functionality in your package), included in the package (and visible on CRAN) \medskip

- Written in a markup language: [`Rmarkdown`](https://rmarkdown.rstudio.com/)^[See also this [cheat sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/master/rmarkdown-2.0.pdf)] to integrate R code chunks, or LaTeX or Markdown \medskip

- To create a vignette: `usethis::use_vignette("my-vignette")` \medskip

- Possible to write multiple vignettes (e.g. [`Rcpp`](https://cran.r-project.org/package=Rcpp) package) \medskip

- **Rendering** (in pdf/html/etc.) with the package [`knitr`](https://yihui.org/knitr) \bigskip

## Create a website

\small

- Create and build a _standardized_ website for your package with [`pkgdown`](https://pkgdown.r-lib.org/)^[See also <https://github.com/r-lib/pkgdown>] \bigskip

- Hostable on Github or Gitlab pages, or on your own webpage \bigskip

- To create the website template: `usethis::use_pkgdown()` \bigskip

- To build the website^[`README.md` become the homepage, `man` documentation are used to generate  function references, and vignettes are rendered into `articles`] (e.g. generate the HTML source): `pkgdown::build_site()` \bigskip

- More details in the `pkgdown` [vignette](https://cran.r-project.org/web/packages/pkgdown/vignettes/pkgdown.html) \bigskip

## Continuous Integration

- Automate package testing and checking when you modify it \bigskip

- Generally associated with a software forge \bigskip

- See [`usethis::use_gitlab_ci()`](https://usethis.r-lib.org/reference/ci.html) or [`usethis::use_github_actions()`](https://usethis.r-lib.org/reference/github_actions.html) \bigskip

- You define a set of actions (e.g. tests and checks) that are run after each commit, or before any pull/merge request (configurable)

# Non R code

## interfacing language

## Rcpp: Seamless R and C++ Integration

- See the [**Rcpp webpage**](https://github.com/RcppCore/Rcpp) and the [**introduction vignette**](https://cran.r-project.org/web/packages/Rcpp/vignettes/Rcpp-introduction.pdf) \medskip

- C++ API to use R types and R like functions^[See the ["Rcpp-sugar" vignette](https://cran.r-project.org/web/packages/Rcpp/vignettes/Rcpp-sugar.pdf)] in C++ \medskip

- Automatic export of C++ functions to R^[See the ["Rcpp-attributes" vignette](https://cran.r-project.org/web/packages/Rcpp/vignettes/Rcpp-attributes.pdf)] in particular when creating/building a package \medskip

- Expose C++ functions and classes to R^[See the ["Rcpp-modules" vignette](https://cran.r-project.org/web/packages/Rcpp/vignettes/Rcpp-modules.pdf)] \medskip

- Conversion from C++ to R and back^[See the ["Rcpp-extending" vignette](https://cran.r-project.org/web/packages/Rcpp/vignettes/Rcpp-extending.pdf)] \bigskip

## Rcpp: compilation on the fly

:::::: {.columns}
::: {.column width="50%"}

In `convolve.cpp` file:

\scriptsize
```C++
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector convolveCpp(
    NumericVector a, NumericVector b
) {
    int na = a.size(), nb = b.size();
    int nab = na + nb - 1;
    NumericVector xab(nab);
    for (int i = 0; i < na; i++)
        for (int j = 0; j < nb; j++)
            xab[i + j] += a[i] * b[j];
    return xab;
}
```

:::
::: {.column width="50%"}

Compilation on the fly in R:
```R
sourceCpp("convolve.cpp")
convolveCpp(x, y)
```
:::
::::::

## Rcpp in a package (1)

- Create a Rcpp-based package template:

```R
Rcpp::Rcpp.package.skeleton("NewPackage", attributes = TRUE)
```

- All `C++` codes should be in the `src` sub-directory \bigskip

- Add the comment `// [[Rcpp::export]]` before every C++ functions that should be exported to R \bigskip

- Add `LinkingTo: Rcpp` in `DESCRIPTION` file \bigskip

## Rcpp in a package (2)

- To generate the C++ to R wrappers: `devtools::load_all()`^[Reminder: `CTRL + SHIFT + L`] or `devtools::build()` will call `Rcpp::compileAttributes()`^[or you can call it yourself] \bigskip

- The files `src/RcppExports.cpp` and `R/RcppExports.R` are automatically created (or updated) and contain the code necessary to expose your C++ functions in R \bigskip

- You C++ code will be compiled during your package installation \bigskip

## Rcpp in a package (3)

:::::: {.columns}
::: {.column width="50%"}

- Compatible with `roxygen2` doc generation \bigskip

- `Rcpp::compileAttributes()` converts `//'` C++ doc comment chunks to `#'` `roxygen2` doc comment chunks in the `R/RcppExports.R` file


:::
::: {.column width="50%"}

\tiny
```C++
#include <Rcpp.h>

using namespace Rcpp;

//' Do something
//' @author someone
//' @description
//' This function does something
//'
//' @param x An integer vector
//' @export
// [[Rcpp::export]]
void my_fun(IntegerVector a) {
    // do something...
}
```

:::
::::::

## The Rcpp ecosystem (1)

- [`RcppEigen`](https://cran.r-project.org/package=RcppEigen): 'Rcpp' Integration for the [`Eigen`](https://eigen.tuxfamily.org) Templated Linear Algebra Library \bigskip

- [`RcppArmadillo`](https://cran.r-project.org/package=RcppArmadillo): 'Rcpp' Integration for the [`Armadillo`](http://arma.sourceforge.net/) Templated Linear Algebra Library \bigskip

- [`RcppGSL`](https://cran.r-project.org/package=RcppGSL): Rcpp Integration for [`GNU GSL`](https://www.gnu.org/software/gsl/) Vectors and Matrices \bigskip

- [`BH`](https://cran.r-project.org/package=BH): [`Boost`](https://www.boost.org/) C++ Header Files ("a set of libraries providing support for tasks and structures such as linear algebra, pseudo-random number generation, multi-threading, image processing, regular expressions, and unit testing") \bigskip

- and more...

## The Rcpp ecosystem (2)

How to use the previous C++ libraries in your package ? \bigskip

1. Install the corresponding R package (with `install.packages("<pkg>")`) \bigskip

2. Add `LinkingTo: <pkg>` in your `DESCRIPTION` file \bigskip

3. Add the comment `// [[Rcpp::depends(<pkg>)]]` when including the corresponding library in your C++ code, e.g.:

```C++
#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
```

4. Use the C++ corresponding library in a standard way in your C++ code


## reticulate: R Interface to Python

[CRAN page](https://cran.r-project.org/package=reticulate) and [webpage](https://rstudio.github.io/reticulate/) \bigskip

- Calling Python from R ([dedicated vignette](https://rstudio.github.io/reticulate/articles/package.html))

```R
library(reticulate)
scipy <- import("scipy")
scipy$amin(c(1,3,5,7))
```

- Conversion from R to Python matrix/array ([dedicated vignette](https://rstudio.github.io/reticulate/articles/arrays.html)) \bigskip

- Python code chunks in Rmarkdown ([dedicated vignette](https://rstudio.github.io/reticulate/articles/r_markdown.html)])

## Managing Python from R

- Python Version Configuration ([dedicated vignette](https://rstudio.github.io/reticulate/articles/versions.html) and [help page](https://rstudio.github.io/reticulate/reference/use_python.html)) \bigskip

- Use virtual environment with `reticulate::use_virtualenv()` and `reticulate::use_condaenv()` \bigskip

## Using Python code in an R package

- Using `reticulate` in a R package ([dedicated vignette](https://rstudio.github.io/reticulate/articles/package.html)) \bigskip

- Configuring Python dependencies of your R
package ([dedicated vignette](https://rstudio.github.io/reticulate/articles/python_dependencies.html)) \bigskip


# Control your R environment

## renv

https://rstudio.github.io/renv/articles/renv.html



## Configuring R

- References: [here](https://support.rstudio.com/hc/en-us/articles/360047157094-Managing-R-with-Rprofile-Renviron-Rprofile-site-Renviron-site-rsession-conf-and-repos-conf) and [here](https://rstats.wtf/r-startup.html) \bigskip

- Configure where you install packages and from where you load packages (i.e. in which directory on your system) \bigskip

- Setup a default CRAN mirror for package installation \bigskip

- Define default R objects, functions that will be available without additional file sourcing \bigskip

- Modify R global options (see the functions `options()` and `getOption()` to check R global options)

## .Renviron: configure the environment where R is run (1)

`.Renviron` = a file defining environment variables (as in `bash`) with the following syntax  (**!!not R code!!**):

```
Key1=value1
Key2=value2
...
```

To edit your `.Renviron` file, you can use `usethis::edit_r_environ()`.

## .Renviron: configure the environment where R is run (2)

- To modify the directory where packages are installed^[by `install.package()`, `devtools::install()`, `remotes::install_from_xxx()`] and loaded from^[by `library()` or `require()`]: you can set^[default value is ``R_LIBS_USER=~/R/%p/%v`] `R_LIBS_USER=/path/to/my/lib/dir` (useful to have project-specific package installation^[to avoid package version conflict between project]) \bigskip

- Define environment variables (e.g. `MYVAR=5`) that will be available in R (with `Sys.getenv("MYVAR")`) or have an effect an your R code behavior \bigskip

## Where storing the .Renviron file

R tries to use an `.Renviron` file in the following order:

1. in the working directory where R is started (if existing), e.g. in your RStudio project root directory \medskip

2. in your home directory (if existing) \medskip

**Note:** You can modify this behavior by setting (outside of R/RStudio^[as in your bash environment]) the following environment variable: `R_ENVIRON_USER=/path/to/my/.Renviron` \medskip

**Anyway:** R has a global `Renviron.site` file that is read first. Using your own `.Renviron` file allows you to modify the default environment defined in this file. \medskip

## .Rprofile: configure and modify your R session

- `.Rprofile` = an R source file that will be run at R startup (after `.Renviron` was read) \bigskip

- What for ?
  - define your own default R objects/functions
  - write a startup message
  - modify R global options
  - etc. \bigskip

To edit your `.Rprofile` file, you can use `usethis::edit_r_profile()`.

## .Rprofile: an example

```R
# setup a default CRAN repository
options(repos = c(CRAN = "https://cran.rstudio.org"))

# modify an option only in interactive mode
if(interactive()) {
    options(width = 120)
}
```

**Note:** interactive mode = as in R console^[versus script mode (like scripts run by `Rscript`)] (in RStudio or in a terminal) \bigskip


## Where storing the .Rprofile file

R tries to use an `.profile` file in the following order:

1. in the working directory where R is started (if existing), e.g. in your RStudio project root directory \medskip

2. in your home directory (if existing) \medskip

**Note:** You can modify this behavior by setting (outside of R/RStudio^[as in your bash environment]) the following environment variable: `R_PROFILE_USER=/path/to/my/.Renviron` \medskip

**Anyway:** R has a global `Rprofile.site` file that is read first and using your own `.Rprofile` file allows you to modify the default R session defined in this file. \medskip

## .Renviron/.Rprofile and reproducibility

**Attention:** you should be careful that your code is usable without your `.Renviron` and `.Rprofile` files \bigskip

- `.Renviron` and `.Rprofile` files are personal files, another user may configure its environment differently \bigskip

- **Example:** charging packages or modifying (global or packages) options that have an impact on output values^[e.g. `options(stringsAsFactors = FALSE)`] in your `.Rprofile` file may affect the reproducibility of your code (i.e. the results can be different or you code can be broken without your `.Rprofile` file) \bigskip

# The end

## {.standout}

Questions ?
