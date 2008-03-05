\name{ATH.coord}
\alias{ATH.coord}
\docType{data}
\title{Data on probes coordinates}
\description{Data for the physical coordinates of A. thaliana GST (probes).}
\usage{data(ATH.coord)}
\format{
A data frame with 30334 observations on the following 4 variables representing GST genomic coordinates:
	\describe{
		\item{\code{etrait.name}}{a factor with GST names as levels.}
		\item{\code{chr}}{an integer vector determining the chromosomes.}
		\item{\code{start}}{an integer vector determining the GST start location in base pair.}
		\item{\code{stop}}{an integer vector determining the GST stop location in base pair.}
	}
}
\details{
These Gene Sequence Tags are used on the CATMA microarray. See references below. They link to the expression phenotypes measured on their related cross object (here, they decribes the \code{seed10} object). Usually, all expression traits are not taken into account within a QTL analysis, therefore this list could contain more traits than the ones phenotyped within the cross object. On the other hand, every phenotype analysed must be found within \code{ATH.coord} data frame.
}
\source{
Jean-Pierre Renou and Alain Lecharny (CATdb a Complete Arabidopsis Transcriptome database)(http://urgv.evry.inra.fr/CATdb)
}
\references{
Crowe M.L. et al., (2003) CATMA A complete Arabidopsis GST database. Nucleic Acids Res 31:156-158.
}
\examples{
data(ATH.coord);
}

\keyword{datasets}
