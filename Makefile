test:
	cp crun.sh crun
	PATH=$$PWD:$$PATH ./test.c Koninchwa!

clean:
	rm crun

PHONY: test
