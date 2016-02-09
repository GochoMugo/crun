PATH := $(PWD):$(PWD)/bats/bin:$(PWD)/clib:$(PATH)

test: clean
	cp crun.sh crun
	@echo " !! testing passing arguments to script"
	./test/args.c Koninchwa! | grep 'Koninchwa'
	@echo " !! testing use of CC_FLAGS in script"
	./test/cflags.c 2>&1 | grep 'implicit declaration'
	@echo " !! testing missing CC_FLAGS in script"
	./test/no-cflags.c
	@echo " !! testing using bats"
	bats ./test/create.sh
	CRUN_CACHE_DIR=/tmp/crun-cache ./test/cache.c

deps: bats clib
	clib install

bats:
	git clone https://github.com/sstephenson/bats.git

clib:
	sudo apt-get install libcurl4-gnutls-dev -qq
	git clone https://github.com/clibs/clib.git
	cd clib && make

clean:
	rm -rf crun /tmp/crun*

.PHONY: clean test
