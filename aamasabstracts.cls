\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{aamasabstracts}[2010/02/01 v1.0 LaTeX document class]


\renewcommand{\normalsize}{\fontsize{10pt}{12pt}\selectfont}
\setlength{\textwidth}{6.5in}
\setlength{\textheight}{8in}

\DeclareOption{onecolumn}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions\relax
\LoadClass[letterpaper,oneside]{book}

\newcommand*{\conferenceyear}[1]{\def\aamasyear{#1}}
\newcommand*{\conferencenumber}[1]{\def\aamasnumber{#1}}
\newcommand*{\location}[1]{\def\aamaslocation{#1}}
\newcommand*{\dates}[1]{\def\aamasdates{#1}}
\newcommand*{\isbn}[1]{\def\aamasisbn{#1}}

\newcommand{\paperprefix}[1]{\def\aamaspaperprefix{#1}}
\paperprefix{}

\let\chapter\section
\def\dayrulewidth{0.1mm}
\def\sessionrulewidth{0.1mm}
\def\forceonecol{0}

\parindent 0pt

\usepackage{setspace}
\usepackage{multicol}
\usepackage{xifthen}
\usepackage{url}
\usepackage{hyperref}
\usepackage{fancyhdr}
\usepackage{vmargin}
%\usepackage{xstring}
%\usepackage{index} 
\usepackage{makeidx}
\makeindex
\renewcommand{\indexname}{Authors Index}

\setmarginsrb           { 0.8in}  % left margin
                        { 0.8in}  % top margin
                        { 0.8in}  % right margin
                        { 1.5in}  % bottom margin
                        {  30pt}  % head height
                        {0.25in}  % head sep
                        {  20pt}  % foot height
                        { 0.3in}  % foot sep

\newcounter{inmulticol}
\setcounter{inmulticol}{0}

\pagestyle{fancy}
\lhead{AAMAS \aamasyear\ abstracts\hfill\sectionmark}
\chead{}
\rhead{\sectionmark}

\renewcommand{\maketitle}{%

	\begin{titlepage}
		\pagestyle{empty}
		\begin{centering}
		{\Huge\textsf{AAMAS \aamasyear}}
		\rule{\linewidth}{0.3mm}
		\vskip 2cm
			\begin{spacing}{2}
				{\Huge\textbf\textsf{The \aamasnumber\ International Conference on Autonomous Agents and Multiagent Systems}}
			\end{spacing}
		{\Large \aamasdates\ $\bullet$\ \aamaslocation}
		\vfill
		\center{\huge Abstracts}
		\vfill
		%ifaamas logo
		\end{centering}
		\begin{flushright}
			\includegraphics[width=4cm]{ifaamaslogo}
		\end{flushright}
		\pagebreak
		\textbf{IFAAMAS}\\
		International Foundation for Autonomous Agents and Multiagent Systems\\
		\url{www.ifaamas.org}
		\vskip 2cm

		Copyright \copyright\ \aamasyear\ by the International Foundation for Autonomous Agents and Multiagent Systems (IFAAMAS).  Permissions
		to make digital or hard copues of portions of this work for personal or classroom use is granted without fee provided that the copies are not 
		made or distributed for profit or commercial advantage and that the copies bear the full citation on the first page.  Copyrigts for
		components of this work owned by others than IFAAMAS must be honoured.  Abstracting with credit is permitted.

		To copy otherwise, to republish, to post on servers or to redistribute to lists, requires prior specific permission and/or fee.  Request
		permission to republish from the IFAAMAS board of directors via \url{info@ifaamas.org}

		\vfill
		ISBN \aamasisbn
	\end{titlepage}
}

\newcounter{sessionctr}

\setcounter{sessionctr}{1}
\newcounter{paperctr}
\setcounter{paperctr}{1}


\renewcommand{\day}[1]{
	\begin{center}
		\begin{spacing}{0.5}
			\rule{\linewidth}{\dayrulewidth}\nopagebreak
				\hfill{\textbf{\large #1}}\hfill\nopagebreak
			\rule{\linewidth}{\dayrulewidth}\nopagebreak
		\end{spacing}\nopagebreak
	\end{center}\nopagebreak
	%\setcounter{sessionctr}{1}
}
\makeatletter
\let\OldSection\section
\renewcommand{\section}[1]{
	\ifthenelse{\value{inmulticol} > 0}{\end{multicols*}}{}{}
	\addcontentsline{toc}{section}{\textbf{#1}}
	\begin{centering}
	\OldSection*{#1}\nopagebreak
	\end{centering}
	\ifthenelse{\forceonecol = 0}{
	\begin{multicols*}{2}
	\setcounter{inmulticol}{1}}{}
}
\makeatother

\makeatletter
\newcommand{\session}{ 
	\@ifstar
		\sessionstar
		\sessionnostar
}
\makeatother

\newcommand{\sessionstar}[2]{
	\vskip 1em
	\textbf{\large #1}\nopagebreak\\\nopagebreak
	\rule{\linewidth}{\sessionrulewidth}\nopagebreak
	\def\aamaspaperprefix{#2}
	\addcontentsline{toc}{subsection}{#1}
	\setcounter{paperctr}{1}
}

\newcommand{\skiptopaper}[1]{
	\setcounter{paperctr}{#1}
}

\newcommand{\sessionnostar}[2]{
	\vskip 1em
	\textbf{\large Session \arabic{sessionctr}}\nopagebreak\\\nopagebreak
	\textbf{\large #1}\nopagebreak\\\nopagebreak
	\rule{\linewidth}{\sessionrulewidth}\nopagebreak
	\addcontentsline{toc}{subsection}{Session \arabic{sessionctr} -- #1} %
	Chair: \emph{#2}%\nopagebreak
	\addtocounter{sessionctr}{1}
}

\newcommand*{\paper}[2]{ %title, authors
	\vskip 0.5em	
	\ifthenelse{\not\equal{\aamaspaperprefix}{}}{\textbf{\aamaspaperprefix--}}{}\textbf{\arabic{paperctr}\\#1}\nopagebreak\\\nopagebreak
	\emph{#2}\nopagebreak\par\nopagebreak
	\addtocounter{paperctr}{1}
}
		
\let\oldbackmatter\backmatter

\renewcommand{\backmatter}{
	\ifthenelse{\value{inmulticol} > 0}{
		\end{multicols*}}{}
	\oldbackmatter
}

\newcommand{\printauthorsindex}{
	\printindex
}
