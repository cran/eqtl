\name{BSpgmap}
\alias{BSpgmap}
\docType{data}

\title{Genetic map data of a RIL population}

\description{
Genetic map of physical data of an \emph{Arabidopsis~thaliana} Recombinant Inbred Line population
}

\usage{data(BSpgmap)}

\format{
A data frame with 69 observations on the following 3 variables representing the physical location of genetic markers:
\describe{
\item{Marker}{a factor with genetic marker names as levels.}
\item{chr}{a numeric vector determining the chromosomes.}
\item{PP}{a numeric vector determining the markers physical position on the chromosome in base pair (bp).}
}
}

\details{
Physical data of the 33RV population genetic map. This population was created from a Bay0 x Sha cross by Olivier Loudet and Sylvain Chaillou between 1997 and 2000 at INRA Versailles. For complete description of the population see reference below.
}
\source{
Loudet (Genetics and Plant breeding, the VAST lab, INRA VERSAILLES) \url{http://www.inra.fr/vast/}
}
\references{
Loudet et al.(2002) Theoretical and Applied Genetics, vol 104, pp 1173-1184
}
\examples{
data(BSpgmap);
}
\keyword{datasets}
