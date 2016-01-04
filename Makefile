test:
	cp crun.sh crun
	PATH=$$PWD:$$PATH ./test.c

clean:
	rm crun

PHONY: test
