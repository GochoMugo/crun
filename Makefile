# Make `crun` command available.
PATH := $(PWD):$(PATH)

export CRUN_DO_EVAL=1

test: clean
	cp crun.sh crun

	@echo " !! testing passing arguments to script"
	@./test/args.c Koninchwa! | grep 'Koninchwa' >/dev/null 2>&1

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

clean:
	rm -rf crun /tmp/crun*

.PHONY: clean test
