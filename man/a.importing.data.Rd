\name{Importing the data}
\alias{Importing the data}

\title{A simple way to import the data}

\description{
R/eqtl needs to import some data in addition to those necessary for R/qtl package: the physical data of the genetic markers and the physical coordinates of the probes used to measure the expression traits.
}

\section{The physical data of the genetic map}{
This is a simple data frame with columns \command{"Marker"},\command{"chr"} and \command{"PP"} as described for \command{BSpgmap} dataset. You can import this data any way you prefer to obtain the data frame. Described here is one simple way to import it from a file:

\itemize{\item \bold{The file format:}}
The first line contains the headings of the columns separated by coma. The following lines contains the informations needed (coma separated). This file could be created as CSV file from Excel or a simple text editor. Of course, this information describes the map of the experiment stored as \command{cross} object (here \command{seed10}). The markers must appear in the same order as the markers and chromosomes in the \command{cross} object (in the same order of the map !).\cr

\bold{Take a look on the sample file:}
\preformatted{"Marker","chr","PP"
"MSAT100008",1,8639
"T1G11",1,1243250
"F21M12",1,3212191
"IND4992",1,4992444
"IND6375",1,6375557
"MSAT1.10",1,7296649
"MSAT108193",1,8192951
etc\dots}

\bold{Take a look within R to the \command{cross} object:}
\preformatted{seed10.clean$geno$'1'$map
seed10.clean$geno$'2'$map
seed10.clean$geno$'3'$map
etc\dots}

\itemize{\item \bold{The R command to import the data within R:}}
\preformatted{a_new_pgmap <- read.table("./fileName",header=TRUE,sep=",");}

The code should work if it is placed within the R working directory. If not replace \command{"./fileName"} with the correct directory ( Windows users must use either foward slashe \command{"/"} or double backslashes \command{"\\"}.
}

\section{The coordinates of the expression traits}{
This is a simple data frame with columns \command{"etrait.name"},\command{"chr"}, \command{"start"} and \command{"stop"} as described for \command{ATH.coord}. By the same way as the map data importation, you can do by the way you wanted. The importation process is quite similar. Here the file can describe more expression trait than the phenotypes described in \command{cross} object. Of course all etraits described in \command{cross} object must have coordinates in the file.

\itemize{\item \bold{The file format:}}
\preformatted{"etrait.name","chr","start","stop"
"CATMA1A00010",1,4707,4972
"CATMA1A00020",1,6442,6653
"CATMA1C71002",1,7579,7791
"CATMA1A00030",1,12268,12486
"CATMA1A00035",1,30923,31142
"CATMA1A00040",1,31232,31381
"CATMA1A00045",1,33814,34211
"CATMA1A00050",1,38785,38971
etc\dots}

\bold{Take a look within R to the \code{cross} object:}
\preformatted{names(seed10.cleaned$phe)[1:10]}

\itemize{\item \bold{The R command to import the data within R:}}
\preformatted{new_probes.coord <- read.table('path_to_file',header= TRUE,sep=",");} 
}

\author{ Hamid A khalili }
\keyword{IO}
