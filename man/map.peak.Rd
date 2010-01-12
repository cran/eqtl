\name{map.peak}
\alias{map.peak}
\title{Summaries maximum LOD peak position from peak object}
\description{
Summaries all maximum LOD peaks position from \command{peak} object as a data frame. This function is useful for Composite Interval Mapping to define as co-factor  previously detected QTLs.
}
\usage{
map.peak(peak)
}
\arguments{
	\item{peak}{ An object of class \command{peak}. See \code{\link{define.peak}} function for details.}
}
\details{
Summaries all detected QTLs location from \command{peak} object as a data frame. This function could be used by the function \command{wash.covar} and gives an overview of the covariates which can be used for a Composite Interval Mapping.
}
\value{
Returns a data frame with columns:
	\item{trait}{The names of the affected traits.}
	\item{chr}{The names of the chromosomes on which the QTL has been detected.}
	\item{cM}{The genetic position of the detected QTL.}
}
\author{ Hamid A. Khalili }
\seealso{\code{\link{define.peak}}}
\examples{
data(seed10);

out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='hk');
out.peak <- define.peak(out.em, 'all');

covar <- map.peak(out.peak);

covar;
}
\keyword{print}

