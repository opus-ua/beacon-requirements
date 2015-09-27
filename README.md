Supported environments are Debian and Ubuntu only.

Install latex and metauml by doing the following.

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

The UML diagrams encoded in mpost are first compiled to a format
useable by latex. This intermediary file is then referenced by
a latex document.

Finally, a pdf is output in the out directory.
