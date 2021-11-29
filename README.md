# Developing an R package: a tutorial

## Author

Ghislain Durif (https://gdurif.perso.math.cnrs.fr/), CNRS -- IMAG (Montpellier, France)

License: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)

## Content

See the introduction in the `index` file ([md](./index.md) or [pdf](./index.pdf)).

All other contents are available in the [`content`](./content) directory.

## Summary

R packages are a great way to write and structure your R codes, to facilitate the use, re-use and evolution of your codes, for others but also for your future self. Through an R package, you can write and distribute R codes with documentation, examples, automatic tests, etc., and it gives you a framework to follow development and coding good practices.

In this tutorial, we will first see the key points and recipe to construct a working R package: the structure of the package, the documentation of the code, the workflow for the package creation and validation. The R ecosystem now provides versatile tools, such as the packages devtools, usethis, roxygen2 and lintr, in combination with the Rstudio IDE (Integrated Development Environment), that can help you develop R packages seamlessly.

In a second part, we will cover (with more or less details) more advanced tools and frameworks to bring your R package to the next level, including quality control and validation of your code based on automatic testing of your code, sharing and publication of your code (through official repositories, git repositories, a dedicated website), more complete documentation of your codes with article or notebook-like document, using other programming languages in R, etc.
