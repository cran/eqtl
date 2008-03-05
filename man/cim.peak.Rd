\name{cim.peak}
\alias{cim.peak}
\title{ Genome scan using previously detected QTLs as covariates}
\description{
Use the LOD peaks previously detected in a \code{peak} object to define the additive covariates and perform a single genome scan taking cofactors into account.
}
\usage{
cim.peak(cross,peak)
}
\arguments{
	\item{cross}{An object of class \code{cross}. See 'qtl' package manual for \code{read.cross} function details.}
	\item{peak}{ An object of class \code{peak}. See \code{define.peak} function for details.}
}
\details{
Perform a composite interval mapping using the \code{scanone} function with additive covariates previously defined in the related peak object.
A scan is performed for traits which are affected by at least one QTL. The additive covariates for each trait are defined as the closest flanking marker to each significant LOD peak (defined in the peak feature \code{peak_cM}). Each trait scan generates a \code{scanone} object which is concatenated to the others \code{scanone} objects.
}
\value{
Return an object of class \code{scanone}.
}
\references{ Broman KW, Wu H, Sen S, Churchill GA (2003) R/qtl: QTL mapping in experimental crosses. Bioinformatics  19:889-890   }
\author{ Hamid A. Khalili }
\seealso{ \code{\link{define.peak}},\code{\link[qtl]{c.scanone}},\code{\link[qtl]{scanone}},\code{\link[qtl]{find.flanking}} }
\examples{
data(seed10);

seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');
seed10 <- sim.geno( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');

out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');
out.peak <- define.peak(out.em, 'all');
out.cem <- cim.peak(seed10,out.peak);
}
\keyword{models}
