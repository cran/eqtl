\name{Rsq.2.array}
\alias{Rsq.2.array}
\title{Add R square data to peak.array data frame}
\description{
Add the single QTL R square data to the related general QTL description contained within \code{peak.array} data frame. 
}
\usage{
Rsq.2.array(rsq,peak.array)
}
\arguments{
	\item{rsq}{An object of class\code{rsq}. See \code{calc.Rsq} for function details.}
	\item{peak.array}{An object of class \code{peak.array}. See \code{peak.2.array} for function details.}
}
\details{
Useful to store whole single QTL description within a simple array by adding the single QTL R square data. Add two columns containing the R square data from \code{rsq} object to the related \code{peak.array} data frame. Column \code{Rsq} contains the R square values and column \code{RpF} contains the R square significance. The R square data are computed by the function \code{calc.Rsq}.
}
\value{
Return an object of class \code{rsq} which is a simple data frame with columns:
	\item{qtl}{The name of the genetic determinant. If the genetic determinant is an individual QTL, the name is formated as \code{'trait_name'.'chr_number'.'a number'} . In the case of interactives QTL, the genetic determinant name is formated as the list of individual genetic determinant names separated by '\code{:}'.}
	\item{rsq}{The Fisher value (set to NA if not significant: \code{pF < th}).}
	\item{pF}{The significance (set to NA if not significant: \code{pF < th}).}
}
\author{ Hamid A. Khalili }
\seealso{ \code{\link{calc.Rsq}},\code{\link{peak.2.array}}}
\examples{
data(seed10);

# Genotype probabilities
seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');
seed10 <- sim.geno( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');

# Genome scan and QTL detection
out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');
out.peak <- define.peak( out.em, 'all');

# Computing additive effect
out.peak <- calc.adef(seed10,out.em,out.peak);

# Localizing peak
data(BSpgmap);
out.peak <- localize.qtl(seed10,out.peak,BSpgmap);
out.array <- peak.2.array(out.peak);

# R square computing
out.rsq <- calc.Rsq(seed10,out.peak);

# Adding R square data
out.array <- Rsq.2.array(out.rsq,out.array);

}
\keyword{print}

