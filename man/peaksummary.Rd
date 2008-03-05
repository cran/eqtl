\name{peaksummary}
\alias{peaksummary}
\title{Print summary of QTL definition}

\description{
Print summary information about QTL contained in a \code{peak} object.
}
\usage{
peaksummary(peak.array,cross,exc=data.frame(inf=0,sup=0,chr=NA),graph=FALSE,...)
}
\arguments{
\item{peak.array}{An object of class \code{peak.array}. See \code{peak.2.array} and \code{Rsq.2.array} functions for details.}
\item{cross}{An object of class \code{cross}. See "qtl" package manual for \code{read.cross} function details.}
\item{exc}{A data frame with columns \code{inf}, \code{sup} and \code{chr} which represent a genomic region to exclude from the summary. \code{inf}, \code{sup},\code{chr} represents the genomic location in base pair (start and stop of the sequence to exclude respectively), \code{chr} specify the chromosome. They are single numeric values.}
\item{graph}{If TRUE, print summary graphs.}
\item{...}{Ignored at this point.}
}
\note{
No page setting has been specified in the \code{peaksummary} function therefore if \code{graph=TRUE} all graphs will appear one above the others within the same R graphical window. You should specified use the parameter \code{mfrow} of the R function \code{par()} to setup the graph page.
}
\value{
Return a list containing a variety of summary information about QTL distribution according to the \code{peak} features.
}
\author{Hamid A. Khalili}
\seealso{
\code{\link{define.peak}},\code{\link[qtl]{read.cross}},\code{\link{peak.2.array}},\code{\link{Rsq.2.array}}
}
\examples{
data(seed10);

seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	map.function='kosambi', stepwidth='fixed');
seed10 <- sim.geno( cross=seed10, step=2, off.end=0, error.prob=0,
	map.function='kosambi', stepwidth='fixed');


out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');
out.peak <- define.peak(out.em,'all');
out.peak <- calc.adef(seed10,out.em,out.peak);

data(BSpgmap);
out.peak <- localize.qtl(seed10,out.peak,BSpgmap);
out.array <- peak.2.array(out.peak);

# Whole QTL summary woth graph
par(mfrow=c(2,4));
peaksummary( out.array, seed10, graph=TRUE);
par(mfrow=c(1,1));

# QTL summary with graphs excluding the QTLs localized
# on chromosome 3 between 5000 and 6000 bp.
par(mfrow=c(2,4));
peaksummary( out.array, seed10, exc=data.frame(inf=5000,sup=6000,chr=3), graph=TRUE);
par(mfrow=c(1,1));
}
\keyword{print}

