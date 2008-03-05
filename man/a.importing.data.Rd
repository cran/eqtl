\name{First step}
\alias{First step}

\title{Importing the data}

\description{
R/eqtl needs to import some data in addition to those necessary for R/qtl package: the physical data of the genetic markers and the phycical coordinates of the probes used to measure the expression traits.
}

\section{The physical data of the genetic map}{
This is a simple data frame with columns \code{"Marker"},\code{"chr"} and \code{"PP"} as described for \code{BSpgmap} dataset. You can import these data by the way you wanted to obtain this data frame. I describes here one simple way to import it from a file:

\itemize{
\item \bold{The file format:} \cr
The first line contains the names of the columns coma separated. The following lines contains the informations needed (coma separated). This file could be created as CSV file from Excel or a simple text editor. Of course, these informations describes the map of the experiment stored as \code{cross} object (here \code{seed10}). The markers must appear in the same order as the markers and chromosomes in the \code{cross} object (in the order of the map !).\cr\cr
\bold{Take a look on the sample file:}\cr
\code{"Marker","chr","PP"} \cr
\code{"MSAT100008",1,8639} \cr
\code{"T1G11",1,1243250} \cr
\code{"F21M12",1,3212191} \cr
\code{"IND4992",1,4992444} \cr
\code{"IND6375",1,6375557} \cr
\code{"MSAT1.10",1,7296649} \cr
\code{"MSAT108193",1,8192951} \cr
etc...\cr\cr
\bold{Take a look whitin R to the \code{cross} object:} \cr
\code{seed10.cleaned$geno$'1'$map} \cr
\code{seed10.cleaned$geno$'2'$map} \cr
\code{seed10.cleaned$geno$'3'$map} \cr
etc...\cr\cr
\item \bold{The R command to import the data within R:} \cr
\code{a_new_BSpgmap <- read.table("path to the file",header=TRUE,sep=",")}
}

}

\section{The coordinates of the expression traits}{

This is a simple data frame with columns \code{"etrait.name"},\code{"chr"}, \code{"start"} and \code{"stop"} as described for \code{CATMA.coord}. By the same way than the map data importation, you can do by the way you wanted. The importation process is quite similar. Here the file can describe more expression trait than the phenotypes described in \code{cross} object. Of course all etraits described in \code{cross} object must have coordinates in the file.

\itemize{
\item \bold{The file format:}  \cr
\code{"etrait.name","chr","start","stop"} \cr
\code{"CATMA1A00010",1,4707,4972} \cr
\code{"CATMA1A00020",1,6442,6653} \cr
\code{"CATMA1C71002",1,7579,7791} \cr
\code{"CATMA1A00030",1,12268,12486} \cr
\code{"CATMA1A00035",1,30923,31142} \cr
\code{"CATMA1A00040",1,31232,31381} \cr
\code{"CATMA1A00045",1,33814,34211} \cr
\code{"CATMA1A00050",1,38785,38971} \cr
etc... \cr\cr
\bold{Take a look within R to the \code{cross} object:}\cr
\code{names(seed10.cleaned$phe)[1:10]} \cr 
\item \bold{The R command to import the data within R:}\cr
\code{new_CATMA.coord <- read.table('./data_Files/listGST-coord.tab', sep="\t", header= TRUE)} 
}

}

\author{ Hamid A khalili }
\keyword{models}
