PATH := $(PWD):$(PATH)

test: clean
	cp crun.sh crun
	./test/args.c Koninchwa! | grep 'Koninchwa'
	./test/cflags.c 2>&1 | grep 'implicit declaration'
	./test/no-cflags.c

clean:
	rm -rf crun /tmp/crun/

.PHONY: clean test
