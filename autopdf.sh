#!/bin/sh

git remote update

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
    git pull
    pdflatex --jobname=AlexLiuResume resume.tex
    pdflatex --jobname=AlexLiuResumeShort resumeShort.tex
    pdflatex --jobname=AlexLiuCV cv.tex
    git add .
    git commit -m "Updated PDFs"
    git push origin master
    echo "Pulled latest version of remote, made PDFs"
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
    git push
    echo "Pushed local version of repo"
else
    echo "Diverged"
fi
