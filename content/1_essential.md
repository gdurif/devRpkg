---
title: "Developing an R package: a tutorial"
subtitle: "The essentials to write your package"
author: "Ghislain Durif"
institute: "CNRS -- IMAG (Montpellier, France)"
date: July 2021
output: 
  binb::metropolis:
    includes:
      in_header: ../.latex_style.sty
classoption: "aspectratio=169,12pt"
---

# Getting started

## R packages to help you create R packages

- [`usethis`](https://usethis.r-lib.org): to automate package and project creation/configuration/setup  \bigskip
- [`devtools`](https://devtools.r-lib.org): complete collection of development tools \bigskip
- [`roxygen2`](https://roxygen2.r-lib.org): to document your code and generate help pages \bigskip
- [`lintr`](https://cran.r-project.org/package=lintr) to review your code ("adherence to a given style, syntax errors and possible semantic issues") \bigskip

## Note

- If you are not working from Rstudio, you will not benefit from all its functionality but it is possible to do everything from the R command line. \bigskip

- In R: `pkg::fun()` refers to the function `fun()` defined in the package `pkg`.

## Setup your environment

- install R packages providing development tools^[`devtools` may require to install additional system libraries depending on your OS, a quick search on the web will help you if you encounter any error.]: `devtools`, `usethis`, `roxygen2`, `lintr`
```R
install.packages(c("devtools", "usethis", "roxygen2", "lintr"))
```

- for a more complete setup: see <https://r-pkgs.org/setup.html>

## Create a package

- Initialize a package template:
```R
usethis::create_package("mypkg")
```

- Directly from Rstudio (equivalent): File - New Project - New directory - R package \bigskip

- **Attention**: if you want to initialize an R package without initializing an Rstudio project\footnote{e.g. because you want to create your package in an existing Rstudio project, or you don't use Rstudio}, use:
```R
usethis::create_package("mypkg1", rstudio = FALSE, open = FALSE)
```

\medskip

## Rstudio project

- Project specific configuration, workspace, history \bigskip

- Isolated R environment for the project \bigskip

- RStudio project management feature (e.g. `git` management) \bigskip

- More information regarding Rstudio project at <https://r-pkgs.org/workflows101.html#projects>

## The "old-fashion" built-in R function to create package

(for more advanced users)

```R
## two functions and two "data sets" :
f <- function(x, y) x+y
g <- function(x, y) x-y
d <- data.frame(a = 1, b = 2)
e <- rnorm(1000)
## automatically "fill" the package
package.skeleton(list = c("f","g","d","e"), name = "mypkg2")
```

**Attention:** using `package.skeleton()` creates a package that is not ready "out-of-the-box", you will have to edit and fix the  help pages (e.g. by using `roxygen2`, c.f. later).

## Naming your package

- three formal requirements:
  - "The name can only consist of letters, numbers, and periods, i.e., .."
  - "It must start with a letter."
  - "It cannot end with a period." \bigskip

- Advice: use a catchy name or acronym with a link to your package functionality \bigskip

- Check if the name you chose is not already used to name a package with the [`available` package](https://cran.r-project.org/package=available) \bigskip

- More details on naming convention at <https://r-pkgs.org/workflows101.html#naming> \bigskip

## Always choose a license!

- It governs the possibility to use, modify or redistribute a software \bigskip
- It helps to identify clear authorship/copyright\footnote{depending on legal consideration, varying from one country to another} \bigskip
- Without a license: fuzzy and unclear (generally "all rights reserved" but you are never sure\footnote{"Was it forgotten or a deliberate choice?"}) \bigskip

## Different types of license

- Use a software-specific license for software and a content-specific license for data^[e.g. [Creative Commons license](https://creativecommons.org/licenses/) are for contents and not for software] \bigskip
- **Recommandation:** favor free\footnote{as in "\textit{libre}" and not as in "gratis" (proprietary software can be gratis)} and open-source licenses (versus proprietary or closed licenses), either **permissive** or **with copyleft** \bigskip

## How to choose a license?

See <https://r-pkgs.org/license.html> (and functions `usethis::use_XX_license()`^[e.g. `use_mit_license()` or `use_gpl_license()`] from the [`usethis` package](https://usethis.r-lib.org/reference/licenses.html)) \bigskip

Additional resources on software license:

- <https://choosealicense.com>
- <https://opensource.org/licenses>
- <https://www.gnu.org/licenses/license-list.en.html>

# R package structure

## Files and sub-directories (1)

:::::: {.columns}
::: {.column width="50%"}

Empty package:

```
mypkg
+-- DESCRIPTION
+-- NAMESPACE
+-- R
    +-- (empty)
```

:::
::: {.column width="50%"}

More complete package:

\scriptsize
```
mypkg2
+-- data
|   +-- d.rda
|   +-- e.rda
+-- DESCRIPTION
+-- man
|   +-- d.Rd
|   +-- e.Rd
|   +-- f.Rd
|   +-- g.Rd
|   +-- mypkg2-package.Rd
+-- NAMESPACE
+-- R
    +-- f.R
    +-- g.R
```

:::
::::::

## Files and sub-directories (2)

- Meta-data files: `DESCRIPTION` and `NAMESPACE` (c.f. later) \bigskip

- `R` sub-directory: where to store R source files implementing the function included in your package \bigskip

- `man` sub-directory: where to store the mandatory help pages \bigskip

- `src` sub-directory (optional): where to store code to be compiled (written in other languages, not in R) included in your package \bigskip

- `data` sub-directory (optional): where to store data files attached to your package \bigskip

## R source code (1)

The `R` sub-directory:

- Write your code as functions \bigskip

- Save your code implementing functions in R source code files^[with `.R` extension] \bigskip

- Group related functions in the same file \bigskip

- Create and edit source code files manually or with [`usethis::use_r("name")`](https://usethis.r-lib.org/reference/use_r.html) \bigskip

- See [R code formatting convention](https://style.tidyverse.org/index.html) \bigskip

- Check your code formatting with the [`lintr` package](https://cran.r-project.org/web/packages/lintr/readme/README.html) and `lintr::lint_package()` \bigskip

## R source code (2)

**Debugging-friendly advice:**

- Avoid very long functions (split long functions into several shorter ones) \bigskip

- Factorize re-used code into specific functions (avoid copying-pasting chunk of codes several time) \bigskip

## From R scripts to R functions

:::::: {.columns}
::: {.column width="50%"}

Scripting:
\scriptsize
```R
# data
a = 7
b = 3
# intermediate operations
tmp1 = 2 * a
tmp2 = b / 6
# final computations
c = tmp1 + tmp2
```
\normalsize


**Objective:** simplify your code by "hiding" intermediate steps into a function

:::
::: {.column width="50%"}

Implementing functions in your package:
\scriptsize
```R
myFun <- function(x, y) {
    tmp1 = 2 * x
    tmp2 = y / 6
    return(tmp1 + tmp2)
}
```
\normalsize

In a script using your package:
\scriptsize
```R
library(mypkg)
# data
a = 7
b = 3
# computations
c = myFun(a,b)
d = myFun(10, 3)
```

:::
::::::

## Meta-data files

- `DESCRIPTION`: a structured text file giving information about your package (title, [description](https://r-pkgs.org/description.html#pkg-description), [authors](https://r-pkgs.org/description.html#author), [license](https://r-pkgs.org/description.html#description-license), [dependencies](https://r-pkgs.org/description.html#dependencies), etc.) \bigskip

- `NAMESPACE`: a text file indicating^[and/or the name of the dynamic library related to compiled codes to be used in your package if relevant] names of R objects (functions, datasets) that are imported in your package (from other packages), and/or exported by your package (to be usable when you install your package)  \bigskip

## DESCRIPTION file (1)

- Can be edited manually, or created and modified with [`usethis::use_description()`](https://usethis.r-lib.org/reference/use_description.html) and other [`usethis::use_XXX()`](https://usethis.r-lib.org/reference/index.html) \bigskip

- Setup your package requirements and dependencies (c.f. later) \bigskip

- More details at https://r-pkgs.org/description.html \bigskip

- **Important**: [package versioning](https://semver.org/)

## DESCRIPTION file (2)

Example:
\tiny
```
Package: mypkg
Title: What the Package Does (One Line, Title Case)
Version: 0.0.0.9000
Authors@R: 
    person(given = "First",
           family = "Last",
           role = c("aut", "cre"),
           email = "first.last@example.com",
           comment = c(ORCID = "YOUR-ORCID-ID"))
Description: What the package does (one paragraph).
License: `use_mit_license()`, `use_gpl3_license()` or friends to pick a
    license
Encoding: UTF-8
LazyData: true
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.1.1
```

## NAMESPACE file

Can be created with [`usethis::use_namespace()`](https://usethis.r-lib.org/reference/use_namespace.html), or edited manually, or (better) **automatically updated** thanks to [`roxygen2` inline documentation](https://roxygen2.r-lib.org/articles/namespace.html) (c.f. later) \bigskip

Example:
\footnotesize
```
# Generated by roxygen2: do not edit by hand

importFrom(stats, runif)
export(my_function)
```

## Data in your package

- Binary R data file (`.Rda` or `.Rdata` file) can be stored in the `data` sub-directory \bigskip

- Raw data can be stored in the `inst` sub-directory and found after installation with the `system.file()` function^[any other file or sub-directory shipped with a package can be found likewise] (**important**: you do not need to search for the `inst` sub-directory, just anything in it)
```R
system.file(filename, package = "mypkg")
system.file(dirname, package = "mypkg")
system.file(package = "mypkg") # package root directory
```

- More at <https://r-pkgs.org/data.html> \bigskip

## help/man pages

- Available with the R commands `?function_name` (e.g. `?rnorm`) or `help(function_name)` \bigskip

- Content:
  - usage description and functioning details
  - input arguments and return value description
  - function authorship
  - link to related functions
  - bibliographic reference
  - minimum working examples \bigskip

- Encoded in `.Rd` files in the `man` sub-directory: structured text files with a specific syntax

## Document your code and generate help page at once

- Avoid creating and editing `.Rd` file manually (laborious) \bigskip

- Good practice: **DOCUMENT YOUR CODE** (with inline comments) for other and YOUR FUTURE SELF \bigskip

- Inline code documentation with [`roxygen2`](https://roxygen2.r-lib.org) based on tags identified with `@`

## Document your code and your package with roxygen2 (1)

:::::: {.columns}
::: {.column width="50%"}

Inline code documentation (identified with `#'` comment characters):
\scriptsize
```R
#' Add together two numbers
#'
#' @param x A number
#' @param y A number
#' @return The sum of \code{x} and \code{y}
#' @author Anonymous
#' @examples
#' add(1, 1)
#' add(10, 1)
#' @export
add <- function(x, y) {
  x + y
}
```

:::
::: {.column width="50%"}

Corresponding `.Rd` file:
\tiny
```
% Generated by roxygen2 (3.2.0): do not edit by hand
\name{add}
\alias{add}
\title{Add together two numbers}
\usage{
add(x, y)
}
\arguments{
  \item{x}{A number}

  \item{y}{A number}
}
\value{
The sum of \code{x} and \code{y}
}
\description{
Add together two numbers
}
\examples{
add(1, 1)
add(10, 1)
}
```

:::
::::::

## Document your code and your package with roxygen2 (2)

- **Generate the man pages** (and update `NAMESPACE` file) with [`devtools::document()`](https://devtools.r-lib.org/reference/document.html) or in Rstudio interface (Build panel - More - Document^[keyboard shortcut:
`CTRL + SHIFT + D`]) \bigskip

- Identify exported functions^[your functions that will be available to users] with the tag `@export` (automatically added to the `NAMESPACE` file) \bigskip

- Identify imported functions^[functions from other packages that you use] with the tag `@importFrom package function` (automatically added to the `NAMESPACE` file) \bigskip

## Document your code and your package with roxygen2 (4)

:::::: {.columns}
::: {.column width="35%"}

More complete example:

\tiny
```R
#' A function to do some stuff
#' @description
#' Do some stuff
#' @details
#' I do the stuff in a complicated way.
#' @param x A number
#' @param y A number
#' @return what the function is returning
#' @author Someone
#' @importFrom stats rnorm
#' @seealso [mypkg::my_other_fun()]
#' @examples
#' add(1, 1)
#' add(10, 1)
#' @export
my_fun <- function(x, y) {
    tmp = rnorm(7)
    ...
}
```

:::
::: {.column width="65%"}

Tips:

- add `Roxygen: list(markdown = TRUE)` to the `DESCRIPTION` file to use markdown syntax in documentation chunks or run [`usethis::use_roxygen_md()`](https://usethis.r-lib.org/reference/use_roxygen_md.html) (possible conversion from existing standard `roxygen2` syntax with [`roxygen2md`](https://roxygen2md.r-lib.org) package) \bigskip

- internal functions (only used by other functions in your package, and not to be available for users) can be tagged with `@keywords internal` and (and without `@export` tag)

:::
::::::

## Document your code and your package with roxygen2 (5)

References:

- More details at <https://r-pkgs.org/man.html> \bigskip
- [`roxygen2` cheat sheet](https://roxygen2.r-lib.org/articles/formatting.html)\bigskip
- Help to format your documentation chunks at <https://roxygen2.r-lib.org/articles/rd-formatting.html> and <https://roxygen2.r-lib.org/articles/rd.html>


## Manage your dependencies (1)

\footnotesize

Several fields in the `DESCRIPTION` file:

- `Depends: R (>= 3.1.0)`: the minimal R version required by your package \medskip

- `Imports: ...`: packages (with optional minimal versions) required for your package to work \medskip

- `Suggests: ...` (optional): additional packages (with optional minimal versions) that are not necessary for your package to work but that would improve the user experience with your package \medskip

- Additional (optional) fields: `LinkingTo` (useful if external codes needs to be compiled and linked against external library), `OS_type: unix` (to specify which OS are supported\footnote{here it means that Windows is not supported}), `SystemRequirements: C++11` (to specify additional external system requirements\footnote{here a C++ compiler compatible with C++11 standard}) \medskip

## Manage your dependencies (2)

Example:
```
Depends: R (>= 3.1.0)
LinkingTo:
    Rcpp (>= 1.0.1), 
    RcppEigen (>= 0.3.3.5)
Imports:
    Rcpp (>= 1.0.1),
    openssl
Suggests: 
    testthat (>= 2.1.0)
SystemRequirements: C++11
```


## Manage your dependencies (3)

- [`usethis::use_package()`](https://usethis.r-lib.org/reference/use_package.html) to update `Imports` or `Suggests` fields \bigskip

- More details at <https://r-pkgs.org/description.html#dependencies>

## Manage your dependencies (4)

Imported objects (functions, dataset) should be declared in the `NAMESPACE` file \bigskip

$\rightarrow$ automatically manage thanks to `roxygen2`

## Other (optional) files and sub-directories (1)

- `README`^[possible format: `.md` or `.Rmd` (Rmarkdown), see [`usethis::use_readme_md()` or `usethis::use_readme_rmd()`](https://usethis.r-lib.org/reference/use_readme_rmd.html)], `LICENSE` (depending on the license your choose), `COPYRIGHT` (to detail authorship, copyright associated to the package content) \bigskip

- [`src`](https://r-pkgs.org/src.html): source codes to be compiled (c.f. later) \bigskip

- [`inst`](https://r-pkgs.org/inst.html) to store additional files (e.g. required for tests, vignettes, etc.), raw data, etc. \bigskip

- [`tests`](https://r-pkgs.org/tests.html) to write automatic tests (c.f. later) \bigskip

## Other (optional) files and sub-directories (2)

- More details at <https://r-pkgs.org/misc.html> \bigskip

- Non-standard files can be present in your project but not shipped in your package: you should create a [`.Rbuildignore`](https://r-pkgs.org/package-structure-state.html#rbuildignore) file \bigskip

# Workflow

## Package state

- **source:** what you are writing \bigskip
- **bundled:** a single-file compressed version containing your package source (how package are shipped by the CRAN for installation) \bigskip
- **binary:** a single-file binary version of your package containing compiled library (if relevant), mainly used by the CRAN to ship package for installation on Windows\bigskip
- **installed:** available as a library on your system, i.e. the package files and sub-directories (along with library files if compilation was needed) have been copied somewhere on your computer \bigskip
- **in-memory:** loaded and ready to use (after calling `library(mypkg)`)

## Dev workflow (building and installing a package)

\centering
\includegraphics[width=\textwidth]{figs/install_r_pkg}

\tiny 
Ref: <https://r-pkgs.org/package-structure-state.html>

## Dev workflow (loading a package)

\centering
\includegraphics[width=\textwidth]{figs/load_r_pkg}

\tiny 
Ref: <https://r-pkgs.org/workflows101.html#load-all>

## load

**Load your package** for a test drive (manual test) without building/installing it

- [`devtools::load_all()`](https://devtools.r-lib.org/reference/load_all.html) \bigskip

- in Rstudio interface (Build panel - More - Load all^[keyboard shortcut:
`CTRL + SHIFT + L`])

**Development cycle:** write code, test it, correct your code, test it, etc.

## document (reminder)

**Generate the man pages** (and update `NAMESPACE` file)

- [`devtools::document()`](https://devtools.r-lib.org/reference/document.html) \bigskip

- in Rstudio interface (Build panel  More - Document^[keyboard shortcut:
`CTRL + SHIFT + D`])

## build

**Prepare your package for installation** (and distribution)

- [`devtools::build()`](https://devtools.r-lib.org/reference/build.html) \bigskip

- in Rstudio interface (Build panel - More - "Build source package") \bigskip

- R built-in shell command line tool^[`R.exe` on Windows]: `R CMD build mypkg` \bigskip

- Create a `.tar.gz` archive files containing the sources (or a `.zip` file if you use "Build binary package") ready for installation \bigskip

## check

**Verify** that your **package is functional** and that your **package structure is correct**

- [`devtools::check()`](https://devtools.r-lib.org/reference/check.html) \bigskip

- in Rstudio interface (Build panel - Check) \bigskip

- R built-in shell command line tool^[`R.exe` on Windows]: `R CMD check mypkg_1.0.0.tag.gz` \bigskip

- **Verbose output**: often clearly identify problems (and suggest fixes) \bigskip

- More details at <https://r-pkgs.org/r-cmd-check.html> \bigskip

## usethis (exhaustive tour)

See <https://usethis.r-lib.org/reference/index.html> \bigskip

Possible to write every files manually for more advanced users.

## devtools (exhaustive tour)

See <https://devtools.r-lib.org/reference/index.html> \bigskip

(`devtools` exports several functions from other development-oriented packages)

# The end

## {.standout}

Questions ?
