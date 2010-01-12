\name{cover.peak}
\alias{cover.peak}
\title{List QTLs within a genetical region from a peak object}
\description{
List QTLs which cover a given genetical region from peak object data.}
\usage{cover.peak(peak,pos,chr,pre=0)}
\arguments{
	\item{peak}{ An object of class \command{peak}. See \command{define.peak} function for details.}
	\item{pos}{ A single numeric value : the genetic position.}
	\item{chr}{ A single integer value : the chromosome.}
	\item{pre}{ A single numeric value : the precision of the targeted genetic position.}
}
\details{
This function searches for the QTL from peak object which totally cover a genetical region. The targeted genetic region is defined as a single genetic position \command{pos} around which the QTLs are searched; the size of this region is defined by \command{pre} which is the max distance from \command{pos} on which the QTLs are searched. \command{pre=0} will set to search QTLs which cover only the single genetic position \command{pos}. The QTLs are defined by LOD peaks with a support interval in a peak object.
}
\value{
return a data frame of class \command{peak.array}
}
\author{ Hamid A. Khalili }
\examples{
data(seed10);

out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='hk');
out.peak <- define.peak( out.em, 'all');

# return the list of QTL which colocalize at 4 cM on chromosome 3
my_peak <- cover.peak(out.peak,pos=4,chr=3,pre=0);
my_peak;

# return the list of QTL which colocalize on the genetic region 4cM-6cM
# on chromosome 4
my_peak <- cover.peak(out.peak,pos=5,chr=4,pre=1);
my_peak;
}
\seealso{ \code{\link[base]{grep}},\code{\link[qtl]{scanone}},\code{\link[qtl]{read.cross}} }
\keyword{print}
