\name{mnames.map}
\alias{mnames.map}
\title{List all markers from a cross object}
\description{
	Return the list of all markers for all of the chromosomes.
}

\usage{
mnames.map(cross)
}

\arguments{
\item{cross}{ An object of class \code{cross}. See 'qtl' package manual for \code{read.cross} function details.}
}

\details{
Return the list of all markers of the cross object sort by chromosome appearance and the marker relatives position. This function is used by the \code{cim.peak} function.
}

\value{
A vector containing all marker names sort by the marker relatives position and chromosomes appearance.
}

\author{ Hamid A. Khalili }

\examples{
data(seed10);
mnames.map(seed10);
}

\seealso{ \code{\link{cim.peak}},\code{\link[qtl]{read.cross}}}
\keyword{print}

