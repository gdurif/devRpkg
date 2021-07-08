---
title: "Developing an R package: a tutorial"
subtitle: "Going further with your R package development"
author: "Ghislain Durif"
institute: "CNRS -- IMAG (Montpellier, France)"
date: July 2021
output: 
  binb::metropolis:
    includes:
      in_header: ../.latex_style.sty
classoption: "aspectratio=169,12pt"
---

# Note

## Setup your environment

- install additional R packages providing development tools: `testthat`, `remotes`^[not necessary if you already installed `devtools`]
```R
install.packages(c("testthat"))
```

## Additional references regarding R programing

- [Hadley Wickham](http://had.co.nz/) **book**: _Advanced R_ ([web version](https://adv-r.hadley.nz) and [sources](https://github.com/hadley/adv-r))

# Digression: Good practice for software development and programming

## Good practice (1)

- The code should be **human readable**^[being machine readable is necessary for the code to work but not sufficient] and **easily understandable** (use comments, code presentation and formatting)
  - Experiment: read your (5 weeks/months/years) old codes, are you sure that you will understand it? (worst with code written by others) \bigskip

- Use a **versioning system** (e.g. [`git`](https://git-scm.com/book/) to manage your code evolution/version and for collaborative development \bigskip

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
- issue, feedback, bug reports
- software release/publication
- continuous integration
- possibility to get a publication identification like a DOI^[eventually externally with [Zenodo](https://zenodo.org/), c.f. later]
- etc.

## Software forge (2)

Examples of software forge

- `gitlab`: **free and open-source `git` forge hosting software** (different hosts are available: in the academic world^[e.g. <https://plmlab.math.cnrs.fr>, <https://gitlab.inria.fr>, etc.] or abroad^[e.g. <https:gitlab.com>] \medskip
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

- To enable `testthat` in your package, run [`usethis::use_testthat()`](https://usethis.r-lib.org/reference/use_testthat.html) \bigskip

- To create [`usethis::use_test()`](https://usethis.r-lib.org/reference/use_r.html) (e.g. ``usethis::use_test("feature1")`) \bigskip

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

# Sharing is caring

## Publish and distribute your package

- Others can use your work, collaborate with you to improve it (collaborative development) \bigskip

- Many repositories: the [CRAN](https://cran.r-project.org/) (official), [bioconductor](https://www.bioconductor.org/) (bioinformatics-oriented package repository) \bigskip

- the [`remotes` package](https://remotes.r-lib.org/) (exported by `devtools`) can be used to install packages stored almost anywhere on the Internet (`CRAN`, `bioconductor`, `git` forges, etc.) \bigskip

## CRAN

- [Strict policy to accept a package}(https://cran.r-project.org/web/packages/policies.html) \bigskip

- Pipeline
  1. [`devtools::build()`](https://devtools.r-lib.org//reference/build.html) (or `R CMD build`)
  2, [`devtools::check()`](https://devtools.r-lib.org//reference/check.html) (or `R CMD check --as-cran`)
  3. upload it to <https://cran.r-project.org/submit.html> \bigskip

- [`devtools::release()`](https://devtools.r-lib.org//reference/release.html) can help you to prepare the release (i.e. the version of your package that will be publish) \bigskip

## Reverse dependencies

- **Important**: if you are releasing a new version of existing package, it is your responsability to check that it does not break downstream dependencies^[called "reverse dependencies"] (i.e. all packages that list your package in the `Depends`, `Imports`, `Suggests` or `LinkingTo fields`) \bigskip

- [`usethis::use_revdep()`](https://usethis.r-lib.org/reference/use_revdep.html) can help you in that task

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

- `github`: [`remotes::install_github()](https://remotes.r-lib.org/reference/install_github.html)
- any `git` forge: [`remotes::install_git()](https://remotes.r-lib.org/reference/install_git.html)

Possibility to specify the branch, the sub-directory where to find the package, etc.

```R
remotes::install_github("RcppCore/Rcpp")`

devtools::install_git(
    "https://github.com/getkeops/keops",
    subdir = "rkeops", branch = "dev" args="--recursive"
)
```

## Organize your package project

- Package root directory = Rstudio project/git repository root directory (default behavior when using `usethis::create_package()` or Rstudio new project package) \bigskip

- The package root directory is a sub-directory of the Rstudio project/git repository
  - you can specify the path to your package directory to `devtools` functions
  - Rstudio project setup: Tools - Project Options - Build tools - Package directory

# Advanced documentation

## writing a vignette

https://r-pkgs.org/vignettes.html

`usethis::use_vignette("my-vignette")`

https://rmarkdown.rstudio.com/

https://raw.githubusercontent.com/rstudio/cheatsheets/master/rmarkdown-2.0.pdf

## website

build a website with `https://pkgdown.r-lib.org/`

## continuous integration

use_gitlab_ci()

use_github_actions()

# Non R code

## Rcpp

## reticulate (python)

# control your R environment

## setup your environment

controler l'installation de package (.Renviron, .Rprofile)


