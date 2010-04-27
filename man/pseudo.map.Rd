\name{pseudo.map}
\alias{pseudo.map}
\title{The makers and pseudo-markers genetic map}
\description{Lists the markers and pseudo-markers genetic positions for all of the chromosomes.}
\usage{
pseudo.map( cross )
}
\arguments{
  \item{cross}{ An object of class \command{cross}. See 'qtl' package manual for \command{read.cross} function details.}
}
\details{
This function lists the markers and pseudo-marker genetic positions for all of the chromosomes. This function is used by others functions. It is necessary to have previously perform the calc.genoprob function before using this function.
}
\value{
A vector containing containing the genetic position of markers and pseudo-marker for all of the chromosomes sort by positions and chromosomes appearance.
}
\author{ Hamid A. Khalili }
\note{ It is necessary to previously perform the \code{calc.genoprob} function.}
\seealso{\code{\link[qtl]{calc.genoprob}}}
\examples{
data(seed10);

pseudo.map(seed10);
}
\keyword{print}

