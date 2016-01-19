test:
	cp crun.sh crun
	PATH=$$PWD:$$PATH ./test.c 66

clean:
	rm crun

PHONY: test
