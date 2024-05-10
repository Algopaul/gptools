#!/bin/bash
function pdf_with_labels() {
  TMPST=$1_tmp
  TMPFILE=$TMPST.tex
  echo "\\\\documentclass{standalone}" >> $TMPFILE
  echo "\\\\usepackage{graphicx}" >> $TMPFILE
  echo "\\\\usepackage{xcolor}" >> $TMPFILE
  echo "\\\\begin{document}" >> $TMPFILE
  echo "\\\\input{$1}" >> $TMPFILE
  echo "\\\\end{document}" >> $TMPFILE
  EXTRADIR=${HOME}/tmp/.extraFiles
  mkdir -p $EXTRADIR
  pdflatex -interaction=nonstopmode --output-dir=${HOME}/tmp/.extraFiles -auxdir=~/tmp/.extraFiles $TMPFILE
  mv $EXTRADIR/$(basename $TMPST).pdf $1_labels.pdf
  rm $TMPFILE
}

function colnames() {
  awk -F',' 'NR==1 {for (i=1; i<=NF; i++) print i, $i}' ${1}
}
