# Make `crun` command available.
PATH := $(PWD):$(PATH)
PREFIX := $(HOME)

export CRUN_DO_EVAL=1

help:
	@echo
	@echo " clean        Clean working directory"
	@echo " deps         Install deps"
	@echo " install      Install crun"
	@echo " test         Run tests"

clean:
	rm -rf crun /tmp/crun*

deps:
	git submodule init
	git submodule update

install:
	cp crun.sh ${PREFIX}/bin/crun

test: clean
	cp crun.sh crun

	@echo " !! testing passing arguments to script"
	@./test/args.c Koninchwa! | grep 'Koninchwa' >/dev/null 2>&1
	@./test/args.c --version | grep -- --version >/dev/null 2>&1

	@echo " !! testing use of CC_FLAGS in script"
	@./test/cflags.c 2>&1 | grep 'implicit declaration' >/dev/null 2>&1

	@echo " !! testing missing CC_FLAGS in script"
	@./test/no-cflags.c

	@echo " !! testing using CRUN_CACHE_DIR"
	@CRUN_CACHE_DIR=/tmp/crun-cache ./test/cache.c

	@echo " !! testing compiling CPP code"
	@./test/cpp.cc | grep 'compiled using g++' >/dev/null 2>&1

	@echo " !! testing using bats"
	./deps/bats/bin/bats --timing ./test/*.sh

	rm crun

.PHONY: clean deps help install test
