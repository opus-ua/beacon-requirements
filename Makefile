all: src/tex/* src/uml/*
	./build.sh

clean:
	rm -rf out
	rm -rf log
	rm -rf tmp
