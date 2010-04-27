\name{localize.qtl}
\alias{localize.qtl}
\title{Compute QTL physical positions from QTL genetic positions}
\description{
Computes QTL physical positions from QTL genetic positions from an object of class \command{peak} and the marker physical positions.
}
\usage{
localize.qtl( cross, peak, data.gmap, round )
}
\arguments{
	\item{cross}{ An object of class \command{cross}. See 'qtl' package manual for \command{read.cross} function details.}
	\item{peak}{ An object of class \command{peak}. See \command{define.peak} for details.}
	\item{data.gmap}{ A \command{data.frame} with column names \command{"Marker"}, \command{"chr"} and \command{"PP"} specifying the marker physical locations. Those one must be the same markers described in the related \command{cross} object.\cr
		\command{data.gmap\$Marker} is a vector of character strings specifying the names of the markers.\cr
		\command{data.gmap\$chr} is a vector of integers specifying the chromosomes on which the markers are localized.\cr
		\command{data.gmap\$PP} is a vector of integers specifying the physical marker locations on the chromosomes in base pair.
	}
	\item{round}{An optional integer indicating the precision to be used for the physical position. The physical position being estimated, non integer nucleotidic position values could be obtained. See \command{round} function for details.}
}
\details{
Linearly computes the physical position from \command{peak\$peak\_cM} and the flanking marker locations:\cr
\bold{A + B/C*D}\cr
\bold{A} is the physical position of the first flanking marker. \bold{B} and \bold{C} are the genetic and the physical distances between the two flanking markers respectively. \bold{D} is the genetic position of the qtl peak.
}
\value{
The input \command{peak} object is returned with components added to components of \command{names(peak\$trait\$chromosome)} for each previously detected QTL:
	\item{peak.bp}{is the physical location of the maximum LOD peak.}
	\item{inf.bp}{is the physical location of the SI lower bound.}
	\item{sup.bp}{is the physical location of the SI upper bound.}
}
\author{ Hamid A. Khalili }
\seealso{\code{\link[qtl]{read.cross}},\code{\link{define.peak}},\code{\link{calc.adef}}}
\examples{
data(seed10);

# Genome scan and QTL detection
out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');
out.peak <- define.peak(out.em, 'all');

# Additive effect computing
out.peak <- calc.adef(seed10,out.em,out.peak,round=3);

# Localizing peaks
data(BSpgmap);
out.peak <- localize.qtl( seed10, out.peak, BSpgmap, round=0);

# Peak features describing the QTLs affecting the 100th trait and
# localized on the chromosome 1
out.peak[[26]]$'4';

# Genetic and physical position of maximum LOD peaks affecting the 100th trait and
# localized on chromosome 1
out.peak[[26]]$'4'$peak.cM;
out.peak[[26]]$'4'$peak.bp;

# Genetic and physical position of QTLs' SI inferior bounds of the 100th trait and
# localized on chromosome 1
out.peak[[26]]$'4'$inf.cM;
out.peak[[26]]$'4'$inf.bp;

# Genetic and physical position of QTLs' SI superior bounds of the 100th trait and
# localized on chromosome 1
out.peak[[26]]$'4'$sup.cM;
out.peak[[26]]$'4'$sup.bp;

# idem for trait 'CATrck'
out.peak$CATrck$'4'$peak.cM;
out.peak$CATrck$'4'$peak.bp;
out.peak$CATrck$'4'$inf.cM;
out.peak$CATrck$'4'$inf.bp;
out.peak$CATrck$'4'$sup.cM;
out.peak$CATrck$'4'$sup.bp;

}
\keyword{models}

