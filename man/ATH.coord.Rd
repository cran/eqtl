\name{ATH.coord}
\alias{ATH.coord}
\docType{data}
\title{Data on probes coordinates}
\description{Data for the physical coordinates of A. thaliana GST (probes).}
\usage{data(ATH.coord)}
\format{
A data frame with 487 observations with the following 4 variables representing \acronym{GST} genomic coordinates:
	\describe{
		\item{etrait.name}{a factor with \acronym{GST} names as levels}
		\item{chr}{an integer vector corresponding to the chromosomes.}
		\item{start}{an integer vector corresponding to the \acronym{GST} start location in base pair.}
		\item{stop}{an integer vector corresponding to the \acronym{GST} stop location in base pair.}
	}
}
\details{
The CATMA microarray, composed of Gene Sequence Tag ( \acronym{GST} ) referenced below, correspond to the expression phenotypes measured on their related cross object (here, they describes the \command{seed10} object). Usually, all expression traits are not taken into account within a QTL analysis, therefore this list could contain more traits than the ones phenotyped within the cross object. On the other hand, every phenotype analysed must be found within \command{ATH.coord} data frame. Please note that ATH.coord contains the physical locations values of an anonymized \acronym{GST} sample taken from true \acronym{CATMA} 2 data which originaly contains 30334 GST. The complete data is available on from the TAIR or CATdb websites.
}
\source{
Jean-Pierre Renou and Alain Lecharny (CATdb a Complete Arabidopsis Transcriptome database)(\url{http://urgv.evry.inra.fr/CATdb})\cr
The Arabidopsis Information Ressource (TAIR) (\url{http://www.arabidopsis.org})
}
\references{
Crowe M.L. et al., (2003) CATMA A complete Arabidopsis GST database. Nucleic Acids Res 31:156-158.
}
\examples{
data(ATH.coord);
}
\keyword{datasets}
