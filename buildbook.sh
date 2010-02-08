#!/bin/bash

if [ $# -lt 1 ];
then
	echo "Usage:"
	echo "	$0 <latex source file>";
	exit;
fi

cat $1 | ./expandAuthors.pl > book_expanded.tex

latex book_expanded.tex
latex book_expanded.tex
makeindex -s aamasabstracts.ist book_expanded
latex book_expanded.tex
