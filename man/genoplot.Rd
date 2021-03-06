\name{genoplot}
\alias{genoplot}
\title{Genome plot of the eQTL data on the expression traits locations}

\description{
Plots the estimated eQTL positions with the genomic positions of the controlled gene.
}

\usage{
genoplot( peak.array, cross, etrait.coord, data.gmap, chr.size, save.pict=FALSE, \dots)
}

\arguments{
\item{cross}{ An object of class \command{cross}. See 'qtl' package manual for \command{read.cross} function details.}
\item{peak.array}{ An object of class \command{peak.array}. See \command{peak.2.array} function for details.}
\item{etrait.coord}{ A data frame specifying the etrait genomic locations with columns:\cr
	\command{etrait.name} a factor with  array element or gene name as levels.\cr
	\command{chr} an integer vector determining the chromosome.\cr
	\command{start} an integer vector determining the GST start location in base pair.\cr
	\command{stop} an integer vector determining the GST stop location in base pair.
}
\item{data.gmap}{ A data frame with column names \command{"Marker"}, \command{"chr"} and \command{"PP"} specifying the marker physical locations. Those one must be the same markers defined in the related \command{cross} object.
	\command{data.gmap\$Marker} is a vector character strings specifying the names of markers.\cr
	\command{data.gmap\$chr} is a vector of integers specifying the chromosome on which the markers are localized.\cr
	\command{data.gmap\$PP} is a vector of integers specifying the physical marker location on the chromosome in base pair.
}
\item{chr.size}{A vector of integer specifying the size of the chromosomes in base pair in order of the chromosomes.}
\item{save.pict}{If TRUE, save each charts generated by \command{genoplot} as png files in the current folder.}
\item{\dots}{Ignored at this step.}
}

\details{
Useful for genetical genomics studies. This function gives a graphical overview of the global eQTL network by plotting the estimated eQTL positions with the genomic positions of the affected traits. Six charts are generated and all locations data are represented on a physical scale. The genomic ditribution of both affected traits and QTLs are described by two histograms. If \command{save.pict=TRUE}, these histograms are saved as \file{./histogram\_controled\_gst.png} and \file{./histogram\_qtl.png} files, respectively. The \code{etrait~eQTL} plot are represented with LOD color scale (from green to red in order of increasing LOD score, blue representing the average LOD SCORE) and with additive effect color scale (from green to red in order of increasing additive effect, yellow representing the null additive effect). Four etrait~eQTL plot are generated representing the eQTL locations as single LOD peaks or support interval regions, both with LOD and additive effect color scales. If \command{save.pict=TRUE}, these plot are saved as \file{lod\_dotplot\_traitxqtl.png}, \file{ae\_dotplot\_traitxqtl.png}, \file{lod\_siplot\_traitxqtl.png} and \file{ae\_siplot\_traitxqtl.png} files.
}

\value{
return a list with elements:
\item{coord_etrait}{the etrait coordinates.}
\item{coord_qtl}{the QTL coordinates.}
\item{limit}{the chromosomes limits.}
\item{add_etrait}{the cumulates size of the chromosomes in bp for the etrait.}
\item{add_qtl}{the cumulates size of of the chromosomes in bp for the QTL.}
}

\author{ Hamid A. Khalili }

\seealso{ \code{\link{define.peak}},\code{\link[qtl]{read.cross}}}

\examples{
data(seed10);

seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');
seed10 <- sim.geno( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');

out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='hk');
out.peak <- define.peak( out.em, 'all');
out.peak <- calc.adef(seed10,out.em,out.peak);

data(BSpgmap);
data(ATH.coord);

out.peak <- localize.qtl(seed10, out.peak, BSpgmap);
out.array <- peak.2.array(out.peak)

genoplot(out.array, seed10, ATH.coord, BSpgmap,
	 chr.size=c(30432457,19704536,23470536,18584924,26991304), save.pict=TRUE);
# NB: the size of the Arabidopsis thaliana chromosomes are
# 30432457, 19704536, 23470536, 18584924 and 26991304 total base pairs
# for chromosomes 1 to 5 respectively
}
\keyword{hplot}

