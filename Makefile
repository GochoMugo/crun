PATH := $(PWD):$(PWD)/clib:$(PATH)

test: clean
	cp crun.sh crun
	./test/args.c Koninchwa! | grep 'Koninchwa'
	./test/cflags.c 2>&1 | grep 'implicit declaration'
	./test/no-cflags.c
	CRUN_CACHE_DIR=/tmp/crun-cache ./test/cache.c

deps: clib
	clib install

clib:
	sudo apt-get install libcurl4-gnutls-dev -qq
	git clone https://github.com/clibs/clib.git
	cd clib && make

clean:
	rm -rf crun /tmp/crun*

.PHONY: clean test
