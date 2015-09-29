This repository houses the requirements document for the beacon frontend
and backend applications. It is written mainly in LaTeX, with UML diagrams
encoded in metapost, using the metauml library.

Supported environments are Debian and Ubuntu only.

Install latex and metapost by doing the following.

    sudo apt-get install texlive texlive-metapost texlive-latex-extra


This project has the following file structure:

```
beacon-requirements
|-- build.sh
|-- log
|-- Makefile
|-- out
    `-- example.pdf
|-- README.md
|-- src
|   |-- tex
|   |   `-- example.tex
|   `-- uml
|       `-- example.mp
`-- tmp
```

LaTeX source is stored in src/tex. These documents reference UML
diagrams stored in src/uml. These documents are written in mpost.

The UML diagrams written in metapost are first compiled to a format
useable by LaTeX. This intermediary file is then referenced by
a LaTeX document.

For example, if you would like to include the uml diagram 
src/uml/test.mp within a latex document, you should use the command

```latex
\includegraphics{tmp/test.1}
```

The file extension ```.1``` is added automatically by metapost compilation.
This project moves intermediary files to the ```tmp``` directory.

Finally, a pdf is output in the out directory.

This project uses the content of git commit messages to construct a revision
history to embed within the document.

* A commit message containing the string "ignore" (not case-sensitive) will not
be included in the revision history or calculation of the revision number.
* A commit message containing the string "major" (not case-sensitive) will
cause the major version number to be incremented.
* A commit message containing the string "minor" (not case-sensitive) will
cause the minor version number to be incremented.
* A commit message not satisfying any of the above conditions will be considered
a patch and will cause the patch number to be incremented.
