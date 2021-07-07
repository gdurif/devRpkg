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

## Note

If you are not working from Rstudio, you will not benefit from all its functionality but it is possible to do everything from the R command line.

## Setup your environment

- install R packages providing development tools^[`devtools` may require to install additional system libraries depending on your OS, a quick search on the web will help you if you encounter any error.]: `devtools`, `usethis`, `roxygen2`
```R
install.packages(c("devtools", "usethis", "roxygen2"))
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

```
mypkg
+-- DESCRIPTION
+-- NAMESPACE
+-- R
    +-- (empty)
```

:::
::: {.column width="50%"}

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

- meta-data files: `DESCRIPTION` and `NAMESPACE` (c.f. later) \bigskip

- `R` sub-directory: where to store R source files implementing the function included in your package \bigskip

- `man` sub-directory: where to store the mandatory help pages \bigskip

- `src` sub-directory (optional): where to store code to be compiled (written in other languages, not in R) included in your package \bigskip

- `data` sub-directory (optional): where to store data files attached to your package \bigskip

## Source code

The `R` sub-directory:

- Write your code as functions \bigskip

- Save your code implementing functions in R source code files^[with `.R` extension] \bigskip

- Group related functions in the same file \bigskip

**Debugging-friendly advice:**

- Avoid very long functions (split long functions into several shorter ones) \bigskip

- Factorize re-used code into specific functions (avoid copying-pasting chunk of codes several time) \bigskip

## Meta-data files

- `DESCRIPTION`: a structured text file giving information about your package (title, [description](https://r-pkgs.org/description.html#pkg-description), [authors](https://r-pkgs.org/description.html#author), [license](https://r-pkgs.org/description.html#description-license), [dependencies](https://r-pkgs.org/description.html#dependencies), etc.) \bigskip

- `NAMESPACE`: a text file indicating names of R objects (functions, datasets) that are imported in your package (from other packages), and/or exported by your package (to be usable when you install your package), and/or the name of dynamic library related to compiled code to be used in your package  \bigskip

## DESCRIPTION file

Can be edited manually, or created and modified with [`usethis::use_description()`](https://usethis.r-lib.org/reference/use_description.html) and other [`usethis::use_XXX()`](https://usethis.r-lib.org/reference/index.html) \bigskip

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

Can be created with [`usethis::use_namespace()`](https://usethis.r-lib.org/reference/use_namespace.html), or edited manually, or (better) automatically updated thanks to [`roxygen2` inline documentation](https://roxygen2.r-lib.org/articles/namespace.html) (c.f. later) \bigskip

Example:
\footnotesize
```
# Generated by roxygen2: do not edit by hand

importFrom(stats, runif)
export(my_function)
```

## data in your package

## help pages and documentation

inline code documentation with `roxygen2`

https://roxygen2.r-lib.org/articles/rd-formatting.html

https://roxygen2.r-lib.org/articles/rd.html

cheat cheet https://roxygen2.r-lib.org/articles/formatting.html

## other files, directories

- `src`: c.f. later

- non-standard files (use `.Rbuildignore`)

# Workflow

## document

## build

## check

## usethis 101

https://usethis.r-lib.org/reference/index.html

## Devtools 101

create, build, check, load_all, install, document, test

## package state

- source
- bundled
- binary
- installed
- in-memory

https://r-pkgs.org/package-structure-state.html
