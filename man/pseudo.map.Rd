\name{pseudo.map}
\alias{pseudo.map}
\title{The makers and pseudo-markers genetic map}
\description{List the markers and pseudo-markers genetic positions for all of the chromosomes.}
\usage{
pseudo.map( cross )
}
\arguments{
  \item{cross}{ An object of class \code{cross}. See 'qtl' package manual for \code{read.cross} function details.}
}
\details{
This function list the markers and pseudo-marker genetic positions for all of the chromosomes. This function is used by others functions.
}
\value{
A vector containing containing the genetic position of markers and pseudo-marker for all of the chromosomes sort by positions and chromosomes appearance.
}
\author{ Hamid A. Khalili }
\note{ It is necessary to previously perform the \code{calc.genoprob} function.}
\seealso{\code{\link[qtl]{calc.genoprob}}}
\examples{
data(seed10);

# Genotype probabilities
seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');

pseudo.map(seed10);
}
\keyword{print}

