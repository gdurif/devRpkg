.PHONY: default
default:
	Rscript build.R

.PHONY: setup
setup:
	Rscript setup.R

.PHONY: clean
clean:
	Rscript clean.R
