# make sure presequisites are installed
if [ -z $(which mpost) ]; then
    echo "Build process requires mpost to be installed."
    echo "Try 'sudo apt-get install texlive-metapost'."
    exit 1
fi

if [ -z $(which pdflatex) ]; then
    echo "Build process requires mpost to be installed."
    echo "Try 'sudo apt-get install texlive-metapost'."
    exit 1
fi

mkdir out log tmp

# compile intermediary forms for uml diagrams
for file in src/uml/*
do
    mpost $file
done

# move intermediary files to appropriate directories
mv *.log log
mv *.1 tmp

# compile latex
pdflatex src/tex/main.tex
mv *.log log
mv *.aux log
mv *.pdf out
