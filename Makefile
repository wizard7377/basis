DUNE ?= dune
.PHONY: all
all: build

.PHONY: build
build:
	$(DUNE) build
