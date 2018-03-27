%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is a class for LaTeX2e that should format a report as per
% the IITM Thesis guidelines.  The page layout is set using the
% geometry package.  The double/singlespacing is setup using
% setspace.  Figure captions are set using the hang option of
% caption2.  natbib is used to do the citation using an
% author-year format. I've made an iitm.bst file that formats 
% the references as per the IITM guidelines.
%
% To use this class do the following:
%  \documentclass[options]{iitmdiss} 
%
% Options:
%
%   PhD, MS, MTech or BTech -- generates the appropriate title page
%   and loads the report class.
%
%   synopsis -- Generates the title page for the synopsis.  This also
%   loads the article class instead of the report.
%  
% Example:
%
% \documentclass[PhD,synopsis]{iitmdiss}
% \documentclass[MS]{iitmdiss}
%
% IMPORTANT NOTICE:
% 
%   PLEASE DO NOT MESS WITH THE MARGINS AND GENERAL FORMATTING SETUP
%   IN THIS FILE UNLESS YOU ARE ABSOLUTELY SURE THAT THE FORMAT DOES NOT
%   MATCH WITH THE THESIS GUIDELINES.  FOR EXAMPLE, DO NOT CHANGE THE 
%   MARGINS AND SPACING JUST TO MAKE YOUR THESIS LARGER!
% 
% Notes:
%
%   * I am using as much of the Thesis guidelines for the spacing
%     and margins as I can.
%   * I have used newdiss.cls by R.~K.~Hariram, U.~V.~Ravindra et al. 
%     as a reference and a source for some of the macros.
%   * This class will assume a4paper with 12pt fonts.
%   * I am no TeXpert so feel free to clean up the mess.
%
% Prabhu Ramachandran <prabhu@ae.iitm.ac.in>
% March 2005.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{iitmdiss}[2005/03/09 Class for IIT-Madras Dissertations]

\newif\if@PhD
\newif\if@MS
\newif\if@MTech
\newif\if@BTech
\newif\if@Synopsis

\DeclareOption{PhD}{\@PhDtrue}
\DeclareOption{MS}{\@MStrue}
\DeclareOption{MTech}{\@MTechtrue}
\DeclareOption{BTech}{\@BTechtrue}
\DeclareOption{synopsis}{\@Synopsistrue}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Load the correct class.
\if@Synopsis
    \LoadClass[12pt,a4paper]{article}
\else
    \LoadClass[12pt,a4paper]{report}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Geometry and page layout
\RequirePackage[%compat2,
a4paper,left=1.5in,right=1in,top=1in,bottom=0.667in,
                nohead]{geometry}[2002/07/08]
\parskip 6pt

\renewcommand{\@pnumwidth}{2.5em}
\newcommand{\Rmnum}[1]{\expandafter\@slowromancap\romannumeral #1@}

%\renewcommand{\@tocrmarg}{2.5em}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Using setspace to do the single/double spacing.  Setspace also
%% makes all tables and figures have single spacing automatically.
\RequirePackage{setspace} 
\RequirePackage{atbeginend} % used to redefine the list environs
\setstretch{1.5}

\BeforeBegin{itemize}{\vspace*{-5ex}\begin{singlespace}}
\AfterEnd{itemize}{\end{singlespace}}

\BeforeBegin{enumerate}{\vspace*{-5ex}\begin{singlespace}}
\AfterEnd{enumerate}{\end{singlespace}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The figure captioning is done correctly via the hang option.
%%\RequirePackage[hang]{caption2}  -> TeX generates error
\RequirePackage[hang]{caption}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bibliography
% 
% natbib allows easy switching of citation style and using it along
% with the iitm.bst makes things perfect.
%\RequirePackage[authoryear,square]{natbib} 
\RequirePackage[numbers,square]{natbib}
%\nocite{*}
\bibliographystyle{iitm}

\newcommand{\bibstyle@iitm}{\bibpunct{(}{)}{;}{a}{,}{,}%
     \gdef\NAT@biblabel##1{##1. }}
%
\setlength{\bibhang}{0pt}
\citestyle{IEEEtran}
%\citestyle{unsrt_newen}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Other useful macros.  Many of these are modifications from newdiss.cls

% \department{department name} -- user macro to declare name of department.
\def\department#1{\gdef\@department{#1}}
\def\regno#1{\gdef\@regno{#1}}
\def\guide#1{\gdef\@guide{#1}}
\def\pos#1{\gdef\@pos{#1}}

%\RequirePackage[dvips]{graphicx}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The title page

\def\maketitle{%
  \pagenumbering{roman}
  \thispagestyle{empty}
  \newpage
  \null
  \setcounter{page}{0}
  \parskip=0pt
  \begin{center}%
  \let \footnote \thanks
  \vglue 0in % this makes top margin 2in
  \vskip -5ex%
  {\em A Mini Project Report on }\par
    \vskip 2ex%
    {\Large \bf \expandafter{\@title} \par}%
    {\normalsize
      \vskip 2ex%
           {\normalsize \em Submitted in partial fulfilment of the requirements for the \par award of the degree of \par}
           \vskip 4ex%
           {\bf MASTER OF TECHNOLOGY}
           \vskip 3ex%
           {\normalsize \em in \par}
           \vskip 3ex%
           {\bf \@department \par}
           {\bf Specialization : Network Engineering \par}
           \vskip 2ex%
           {\normalsize \em by \par}
		\vskip 2ex%           
           {\bf \large\MakeUppercase{\@author}\par\par}
		   {\bf (Reg.No : \@regno) \par}           
           \vskip 2ex%
           {\normalsize \em Under the guidance of \par}
           \vskip 2ex%
           {\bf Dr. \@guide }
    }
  \end{center}%

  \vspace*{0.2in}
  %\centerline{\psfig{figure=emblem.ps}}
%  \centerline{\includegraphics{iitm.eps}}
  \centerline{\includegraphics[scale=0.35]{geci}}
  \vspace*{-0.06in}
  \begin{center}
    {\bf \normalsize DEPARTMENT OF \@department\par}
    {\bf \large GOVERNMENT ENGINEERING COLLEGE IDUKKI \par}
    {\bf \large PAINAVU-685603}
    \vglue 0.50em
    {\bf \large \@date}\par
  \end{center}
  \parskip 8pt
}

\def\titlepage{\newpage\thispagestyle{empty}\c@page\z@}
\def\endtitlepage{\newpage}

\if@Synopsis
   \renewcommand\refname{REFERENCES}
\else
   % QUOTATIONS
   %
   \def\quotations{\chapter*{\centerline{QUOTATIONS}}
   %\addcontentsline{toc}{chapter}{QUOTATIONS}
   }

   % DEDICATION
   %
   \def\dedication{\chapter*{\centerline{DEDICATION}}
   %\addcontentsline{toc}{chapter}{DEDICATION}
   }

   % CERTIFICATE
   %
   %   - this produces a certificate page as per IITM Regulations
   %     comment the following lines out to get it working.
   %
   \def\certificate{%% A preliminary chapter
     \clearpage
     \vspace*{25pt}
      \centerline{\Large \bf GOVERNMENT ENGINEERING COLLEGE IDUKKI}
      \vskip 3pt
      \centerline{\Large \bf PAINAVU - 685603}
     \vskip 3pt
     \centerline{\bf DEPARTMENT OF \@department}
           \vskip 20pt
      \centerline{\includegraphics[scale=0.5]{geci}}
      \vskip 20pt
     \centerline{\Large \bf CERTIFICATE}
     \thispagestyle{empty}
     \typeout{Certificate}
     \setcounter{page}{0}
   }

   % ACKNOWLEDGEMENTS
   %
   \def\acknowledgements{\chapter*{\centerline{ACKNOWLEDGEMENTS}}
     \addcontentsline{toc}{chapter}{ACKNOWLEDGEMENTS}
   }

   % ABSTRACT
   %   - this produces pages suitable for an IITM Abstract
   \def\abstract{\chapter*{\centerline{ABSTRACT}}
   \addcontentsline{toc}{chapter}{ABSTRACT}
   }

   % GLOSSARY
   %
   \def\glossary{\chapter*{\centerline{GLOSSARY}}
   \addcontentsline{toc}{chapter}{GLOSSARY}
   }

   % ABBREVIATIONS
   %
   \def\abbreviations{\chapter*{\centerline{ABBREVIATIONS}}
   \addcontentsline{toc}{chapter}{ABBREVIATIONS}
   }

   % Use the nomencl package for the NOTATION section.

   % Makes the chapter heading
   \def\@makechapterhead#1{%
     {\parindent \z@ \raggedright \normalfont
       \ifnum \c@secnumdepth >\m@ne
       \begin{center}
         \Large\bfseries \@chapapp\space \thechapter
       \end{center}
       \nobreak
       \vspace*{-25\p@}
       \fi
       \interlinepenalty\@M
       \Large \bf
       \begin{center}
         #1\par\nobreak      
       \end{center}
       \vskip 20\p@
       \thispagestyle{fancy}
     }}

   % Makes the chapter heading for \chapter* commands
   \def\@makeschapterhead#1{%
     \vspace*{25\p@}%
     {\parindent \z@ \raggedright
       \normalfont
       \interlinepenalty\@M
       \Large \bfseries #1\par\nobreak
       \vskip 20\p@
     }}


   %LIST OF PAPERS
   \def\listofpapers{
           \normalbaselines
           \chapter*{\centerline{LIST OF PAPERS BASED ON THESIS}}
           \markboth{LIST OF PAPERS BASED ON THESIS}{LIST OF PAPERS BASED ON THESIS}
           %\addcontentsline{toc}{chapter}{LIST OF PAPERS BASED ON THESIS}
   }

   
   % CV
   \def\CV{\chapter*{\centerline{CURRICULUM VITAE}}}

   % Comittee
   \if@PhD
       \def\committee{\chapter*{\centerline{DOCTORAL COMMITTEE}}}
   \else
       \if@MS
          \def\committee{\chapter*{\centerline{GENERAL TEST COMITTEE}}}}
        \fi
   \fi


   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Renewed commands to set the titles of various pages correctly.
   \renewcommand\contentsname{\centering TABLE OF CONTENTS}
   \renewcommand\listfigurename{\centering LIST OF FIGURES}
   \renewcommand\listtablename{\centering LIST OF TABLES}
   \renewcommand{\chaptername}{CHAPTER}
   \renewcommand\bibname{\centering REFERENCES}
   \renewcommand\appendixname{APPENDIX}
\fi


