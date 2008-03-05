\name{cover.peak}
\alias{cover.peak}
\title{List QTLs within a genetical region from a peak object}
\description{
List QTLs which cover a given genetical region from peak object data.}
\usage{
	cover.peak(peak,pos,chr,pre=0)
}
\arguments{
	\item{peak}{ An object of class \code{peak}. See \code{define.peak} function for details.}
	\item{pos}{ A single numeric value : the genetic position.}
	\item{chr}{ A single integer value : the chromosome.}
	\item{pre}{ A single numeric value : the precision of the targeted genetic position.}
}
\details{
This function searches QTL from peak object which cover a genetical region. The targeted genetic region is defined as a single genetic position \code{pos} around which the QTLs are searched; the size of this region is defined by \code{pre} which is the max distance from \code{pos} on which the QTLs are searched. \code{pre=0} will set to search QTLs which cover only the single genetic position \code{pos}. The QTLs are defined by LOD peaks with support interval in a peak object.
}
\value{
return a data frame of class \code{peak.array}
}
\author{ Hamid A. Khalili }
\examples{
data(seed10);

seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');
out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');

out.peak <- define.peak( out.em, 'all');

# return the list of QTL which colocalize at 4 cM on chromosome 3
my_peak <- cover.peak(out.peak,2,4,pre=0);
my_peak;

# return the list of QTL which colocalize on the genetic region 400-406 bp
# on chromosome 4
my_peak <- cover.peak(out.peak,pos=5,chr=4,pre=1);
my_peak;
}
\seealso{ \code{\link[base]{grep}},\code{\link[qtl]{scanone}},\code{\link[qtl]{read.cross}} }
\keyword{print}
