\name{Rsq.2.array}
\alias{Rsq.2.array}
\title{Add R square data to peak.array data frame}
\description{
Adds the single QTL R square data to the related general QTL description contained within \command{peak.array} data frame. 
}
\usage{
Rsq.2.array(rsq,peak.array)
}
\arguments{
	\item{rsq}{An object of class\command{rsq}. See \command{calc.Rsq} for function details.}
	\item{peak.array}{An object of class \command{peak.array}. See \command{peak.2.array} for function details.}
}
\details{
Useful to store whole single QTL description within a simple array by adding the single QTL R square data. Add two columns containing the R square data from \command{rsq} object to the related \command{peak.array} data frame. Column \command{Rsq} contains the R square values and column \command{RpF} contains the R square significance. The R square data is computed by the function \command{calc.Rsq}.
}
\value{
Returns an object of class \command{rsq} which is a simple data frame with columns:
	\item{qtl}{The name of the genetic determinant. If the genetic determinant is an individual QTL, the name is formated as \command{'trait\_name'.'chr\_number'.'a\_number'} . In the case of interactives QTL, the genetic determinant name is formated as the list of individual genetic determinant names separated by '\command{:}'.}
	\item{rsq}{The Fisher value (set to NA if not significant: \command{pF < th}).}
	\item{pF}{The significance (set to NA if not significant: \command{pF < th}).}
}
\author{ Hamid A. Khalili }
\seealso{ \code{\link{calc.Rsq}},\code{\link{peak.2.array}}}
\examples{
data(seed10);

# Genome scan and QTL detection
out.em <- scanone(seed10, pheno.col=1:50, model='normal', method='em');
out.peak <- define.peak(out.em, 'all');

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

