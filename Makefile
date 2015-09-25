all: src/tex/* src/uml/*
	./build.sh

clean:
	rm -rf out log tmp
	rm -f *.toc *.lof
