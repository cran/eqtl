\name{plotRsq}
\alias{plotRsq}
\title{Plot R square data}

\description{
Draw histograms of R square value distribution for \command{rsq} object.
}
\usage{
plotRsq( rsq, par=c(2,2), ...)
}
\arguments{
\item{rsq}{An object of class \command{rsq}. See \command{calc.Rsq} for function details.}
\item{par}{A vector of two integers corresponding to the \command{mfrow} parameter of the \command{par()} function.}
\item{\dots}{Passed to the function \command{hist} and \command{par} when they are called.}
}
\details{
Draw histograms of R square value distribution from an object of class \command{rsq}. Three histograms are drawn: the first one shows the R square value distribution of single QTLs. The second shows the distribution for QTL interactions. The last one shows all R square values distribution.
}
\value{none}
\author{Hamid A. Khalili}
\seealso{
\code{\link{calc.Rsq}},\code{\link{peak.2.array}}
}
\examples{
data(seed10);

seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	map.function='kosambi', stepwidth='fixed');
seed10 <- sim.geno( cross=seed10, step=2, off.end=0, error.prob=0,
	map.function='kosambi', stepwidth='fixed');

out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');
out.peak <- define.peak(out.em,'all');
out.rsq <- calc.Rsq(seed10,out.peak);

# plotting R quare data
plotRsq(out.rsq);
plotRsq(out.rsq,par=c(1,3));
}
\keyword{hplot}

