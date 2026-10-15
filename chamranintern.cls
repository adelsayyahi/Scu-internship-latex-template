%% ---------------------------------------------------------------------------
%%  chamranintern.cls
%%  LaTeX template for MSc internship reports at Shahid Chamran University of Ahvaz.
%%  Author  : A'adel sayyahi
%%  Version : 1.0  (2026/10/13)
%%  Engine  : LuaLaTeX  (TeX Live 2022 or newer, or Overleaf with LuaLaTeX)
%%  Font    : Vazirmatn (SIL OFL 1.1, bundled in fonts/)
%% ---------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{chamranintern}[2026/10/13 v1.0 Shahid Chamran University internship report (MSc IoT)]

\RequirePackage{iftex}
\ifluatex\else\ifxetex\else
  \ClassError{chamranintern}%
    {This class must be compiled with XeLaTeX or LuaLaTeX}%
    {Run: xelatex main.tex (or lualatex main.tex). On Overleaf choose the XeLaTeX or LuaLaTeX compiler.}
\fi\fi

%% ---------------------------------------------------------------- options
\newif\ifchamran@nologo
\DeclareOption{nologo}{\chamran@nologotrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\PassOptionsToClass{a4paper,11pt,oneside}{report}
\ProcessOptions\relax
\LoadClass{report}

%% ------------------------------------------------------------- packages
\RequirePackage{etoolbox}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{setspace}
\RequirePackage{fontspec}

%% Persian typesetting through babel (bidi=basic works with LuaLaTeX only)
\ifluatex
  \RequirePackage[bidi=basic,layout=sectioning.lists.captions.counters.tabular]{babel}
\else
  \RequirePackage[bidi=default,layout=sectioning.lists.captions.counters.tabular]{babel}
\fi
\babelprovide[import,main,mapdigits]{persian}
\babelprovide[import]{english}

%% ----------------------------------------------------------------- fonts
%% Change \chamranfontpath if you move the fonts folder.
\newcommand*\chamranfontpath{fonts/}
\babelfont{rm}[
  Path=\chamranfontpath, Extension=.ttf,
  UprightFont=*-Regular, BoldFont=*-Bold,
  ItalicFont=*-Regular, BoldItalicFont=*-Bold]{Vazirmatn-FD}
\babelfont{sf}[
  Path=\chamranfontpath, Extension=.ttf,
  UprightFont=*-Regular, BoldFont=*-Bold,
  ItalicFont=*-Regular, BoldItalicFont=*-Bold]{Vazirmatn-FD}
\babelfont[english]{rm}{TeX Gyre Termes}
\babelfont[english]{sf}{TeX Gyre Heros}
\babelfont{tt}{Latin Modern Mono}

%% Latin words (IoT, MQTT, ...) inside Persian text
\newcommand*\lat[1]{\foreignlanguage{english}{#1}}

%% --------------------------------------------------------------- geometry
\RequirePackage[a4paper,
  top=3.9cm, bottom=2.6cm, left=2.5cm, right=2.5cm,
  headheight=2.9cm, headsep=0.6cm, footskip=1.2cm]{geometry}
\linespread{1.45}
\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt plus 1pt}
\setlength{\emergencystretch}{2em}

%% ------------------------------------------------------------ metadata
\newcommand*\chamran@empty{}
\newcommand*\ReportTitle[1]{\gdef\chamran@title{#1}}
\newcommand*\StudentName[1]{\gdef\chamran@student{#1}}
\newcommand*\StudentID[1]{\gdef\chamran@sid{#1}}
\newcommand*\Supervisor[1]{\gdef\chamran@supervisor{#1}}
\newcommand*\IndustrySupervisor[1]{\gdef\chamran@indsup{#1}}
\newcommand*\Organization[1]{\gdef\chamran@org{#1}}
\newcommand*\InternPeriod[1]{\gdef\chamran@period{#1}}
\newcommand*\Department[1]{\gdef\chamran@dept{#1}}
\newcommand*\ReportDate[1]{\gdef\chamran@date{#1}}
\newcommand*\Keywords[1]{\gdef\chamran@keywords{#1}}
\ReportTitle{عنوان گزارش کارآموزی}
\StudentName{نام و نام خانوادگی دانشجو}
\StudentID{}
\Supervisor{}
\IndustrySupervisor{}
\Organization{}
\InternPeriod{}
\Department{}
\ReportDate{}
\Keywords{}

%% ------------------------------------------- header (logo) and footer
\RequirePackage{fancyhdr}
\newcommand*\chamran@logofile{logo/chamran-logo}
\newcommand*\chamran@header{%
  \parbox[b]{\textwidth}{\centering\linespread{1}\selectfont\setlength{\parskip}{0pt}%
    \ifchamran@nologo\else
      \includegraphics[height=1.75cm]{\chamran@logofile}\par\vspace{3pt}%
    \fi
    {\small گزارش کارآموزی کارشناسی ارشد -- \chamran@student\par}\vspace{2pt}}}

\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyhead[C]{\chamran@header}
  \fancyfoot[C]{\small\thepage}
  \renewcommand{\headrulewidth}{0.9pt}
  \renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{chamran@cover}{%
  \fancyhf{}
  \fancyhead[C]{\chamran@header}
  \renewcommand{\headrulewidth}{0.9pt}
  \renewcommand{\footrulewidth}{0pt}}
\pagestyle{plain}

%% -------------------------------------------------------------- headings
\RequirePackage{titlesec}
\renewcommand\thesection{\thechapter\textendash\arabic{section}}
\renewcommand\thesubsection{\thesection\textendash\arabic{subsection}}
\renewcommand\thesubsubsection{\thesubsection\textendash\arabic{subsubsection}}

\titleformat{\chapter}[block]
  {\normalfont\bfseries\fontsize{24}{30}\selectfont\raggedright}
  {\chaptername\ \thechapter:}{0.3em}{}
\titleformat{name=\chapter,numberless}[block]
  {\normalfont\bfseries\fontsize{24}{30}\selectfont}{}{0pt}{}
\titlespacing*{\chapter}{0pt}{-6pt}{1.1cm}
\titleformat{\section}[block]
  {\normalfont\bfseries\fontsize{17}{22}\selectfont}
  {\thesection\textendash}{0.5em}{}
\titlespacing*{\section}{0pt}{1.0cm plus 4pt}{0.35cm}
\titleformat{\subsection}[block]
  {\normalfont\bfseries\fontsize{14}{18}\selectfont}
  {\thesubsection\textendash}{0.5em}{}
\titlespacing*{\subsection}{0pt}{0.7cm plus 3pt}{0.25cm}
\titleformat{\subsubsection}[block]
  {\normalfont\bfseries\fontsize{12}{16}\selectfont}
  {\thesubsubsection\textendash}{0.5em}{}
\titlespacing*{\subsubsection}{0pt}{0.5cm plus 2pt}{0.2cm}

%% ------------------------------------------------------------------ lists
\RequirePackage{enumitem}
\setlist{nosep, topsep=3pt, itemsep=2pt}
\setlist[itemize]{label=\textbullet}

%% ----------------------------------------------- bibliography and captions
\setlocalecaption{persian}{bib}{منابع (References)}
\setlocalecaption{persian}{abstract}{چکیده}
\setlocalecaption{persian}{contents}{فهرست مطالب}
\setlocalecaption{persian}{listfigure}{فهرست شکل‌ها}
\setlocalecaption{persian}{listtable}{فهرست جداول}
\RequirePackage[nottoc,notlof,notlot]{tocbibind}
%% reference entries are mostly Latin: typeset them left-to-right
\let\chamran@thebib\thebibliography
\let\endchamran@thebib\endthebibliography
\renewenvironment{thebibliography}[1]{%
  \chamran@thebib{#1}\selectlanguage{english}\singlespacing}{\endchamran@thebib}
\captionsetup{font=small, labelfont=bf}

\RequirePackage[hidelinks, unicode]{hyperref}
\AtBeginDocument{%
  \hypersetup{pdftitle={\chamran@title}, pdfauthor={\chamran@student}}}

%% ------------------------------------------------------------ title page
\renewcommand\maketitle{%
  \begin{titlepage}%
    \thispagestyle{chamran@cover}%
    \begin{center}
      \singlespacing
      \vspace*{0.3cm}
      {\bfseries\fontsize{15}{20}\selectfont بسمه تعالی\par}
      \vspace{1.3cm}
      {\bfseries\fontsize{32}{44}\selectfont \chamran@title\par}
      \vspace{2.2cm}
      {\bfseries\fontsize{17}{26}\selectfont
        \chamran@student\par\vspace{0.55cm}
        \ifx\chamran@sid\chamran@empty\else
          شماره دانشجویی: \chamran@sid\par\vspace{0.55cm}\fi
        \ifx\chamran@dept\chamran@empty\else
          \chamran@dept\par\vspace{0.55cm}\fi
        \ifx\chamran@supervisor\chamran@empty\else
          استاد راهنما (کارآموزی): \chamran@supervisor\par\vspace{0.55cm}\fi
        \ifx\chamran@indsup\chamran@empty\else
          سرپرست صنعتی: \chamran@indsup\par\vspace{0.55cm}\fi
        \ifx\chamran@org\chamran@empty\else
          محل کارآموزی: \chamran@org\par\vspace{0.55cm}\fi
        \ifx\chamran@period\chamran@empty\else
          دوره زمانی کارآموزی: \chamran@period\par\fi}
      \vfill
      \ifx\chamran@date\chamran@empty\else
        {\bfseries\large \chamran@date\par}\fi
    \end{center}
  \end{titlepage}%
  \setcounter{page}{1}}

%% ------------------------------------------------------------- abstract
\renewenvironment{abstract}{%
  \clearpage\thispagestyle{plain}%
  \chapter*{\abstractname}%
  \begin{singlespace}\linespread{1.45}\selectfont\ignorespaces}{%
  \par\ifx\chamran@keywords\chamran@empty\else
    \vspace{0.4cm}{\bfseries کلیدواژه‌ها:} \chamran@keywords\par\fi
  \end{singlespace}\clearpage}

%% ---------------------------------------------------------- front matter
\newcommand*\chamranfrontmatter{\pagenumbering{arabic}}

%% ----------------------------------------------------- convenience macros
\newcommand*\placeholder[1]{{\color{gray}#1}}

\endinput
