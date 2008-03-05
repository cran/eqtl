\name{map.peak}
\alias{map.peak}
\title{Resume maximum LOD peak position from peak object}
\description{
Resume all maximum LOD peaks position from \code{peak} object as a data frame. This function is useful for Composite Interval Mapping to define as co-factor  previoulsy detected QTLs.
}
\usage{
map.peak(peak)
}
\arguments{
	\item{peak}{ An object of class \code{peak}. See \code{define.peak} function for details.}
}
\details{
Resume all detected QTLs location from \code{peak} object as a data frame. This function could be used by the function \code{wash.covar} and gives an overview of the covariates which can be used for a Composite Interval Mapping.
}
\value{
Returns a data frame with columns:
	\item{trait}{The names of the affected traits.}
	\item{chr}{The names of the chromosomes on which the QTL has been detected.}
	\item{cM}{The genetic position of the detected QTL.}
}
\author{ Hamid A. Khalili }
\seealso{\code{\link[qtl]{define.peak}}}
\examples{
	data(seed10);

	seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');
	seed10 <- sim.geno( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');

	out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');
	out.peak <- define.peak(out.em, 'all');

	covar <- map.peak(out.peak);

	covar;
}
\keyword{print}

