#!/bin/bash

contains_str ()
{
    SUBSTR=$1
    SEARCH_STR=$2
    LOWER=$(echo $SEARCH_STR | awk '{print tolower($0)}')
    if [[ "$LOWER" == *"$SUBSTR"* ]]; then
        echo 1
    else
        echo 0
    fi
}

# make sure presequisites are installed
if [ -z $(which mpost) ]; then
    echo "Build process requires mpost to be installed."
    echo "Try 'sudo apt-get install texlive-metapost'."
    exit 1
fi

if [ -z $(which pdflatex) ]; then
    echo "Build process requires latex to be installed."
    echo "Try 'sudo apt-get install texlive-metapost'."
    exit 1
fi

mkdir -p out log tmp

# render revisions template
MAJOR_VERSION=1
MINOR_VERSION=0
PATCH_VERSION=0
COUNT=0

COMMITS=$(git rev-list master --reverse)
rm -f tmp/revisions.tex
touch tmp/revisions.tex
cat src/templates/revisions-head.tex >> tmp/revisions.tex
while read -r COMMIT
do
    if [ "$COUNT" -ne "0" ]; then
        MSG=$(git --no-pager show $COMMIT --quiet --format=format:"%s")
        if [ $(contains_str major $MSG) == "1" ]; then
            ((MAJOR_VERSION++)) 
            MINOR_VERSION=0
            PATCH_VERSION=0
        elif [ $(contains_str minor $MSG) == "1" ]; then
            ((MINOR_VERSION++)) 
            PATCH_VERSION=0
        else
            ((PATCH_VERSION++)) 
        fi
    fi
    ((COUNT++))

    # compute attributes
    # date, author, version, hash, description
    TIMESTAMP=$(git --no-pager show $COMMIT --quiet --format=format:"%ct")
    DATE=$(date --date @$TIMESTAMP +"%m/%d/%Y")
    AUTHOR=$(git --no-pager show $COMMIT --quiet --format=format:"%cN")
    VERSION="$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION"
    HASH=$(git --no-pager show $COMMIT --quiet --format=format:"%h")
    DESCRIPTION=$(git --no-pager show $COMMIT --quiet --format=format:"%s")

    # render template
    cp src/templates/revisions-entry.tex tmp/revisions-entry.tex
    sed -i "s|DATE-STRING|$DATE|g" tmp/revisions-entry.tex 
    sed -i "s/AUTHOR-STRING/$AUTHOR/g" tmp/revisions-entry.tex 
    sed -i "s/VERSION-STRING/$VERSION/g" tmp/revisions-entry.tex 
    sed -i "s/HASH-STRING/$HASH/g" tmp/revisions-entry.tex 
    sed -i "s|DESCRIPTION-STRING|$DESCRIPTION|g" tmp/revisions-entry.tex 
    cat tmp/revisions-entry.tex >> tmp/revisions.tex
done <<< "$COMMITS"
cat src/templates/revisions-tail.tex >> tmp/revisions.tex

VERSION_NUMBER="$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION"

# render title page template
cp src/templates/title.tex tmp
sed -i "s/VERSION-STRING/$VERSION_NUMBER/g" tmp/title.tex

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
pdflatex src/tex/main.tex
mv *.log log
mv *.aux log
mv *.pdf out

mv out/main.pdf out/beacon-requirements-$VERSION_NUMBER.pdf
