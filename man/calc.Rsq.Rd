\name{calc.Rsq}
\alias{calc.Rsq}

\title{Estimate R square of individual QTLs and QTL interactions}

\description{
Estimates the R square (phenotypic contribution) for individual QTLs and their significant interactions for each trait from cross and peak objects.
}

\usage{
calc.Rsq(cross,peak,th=0.001,round)
}

\arguments{
\item{cross}{An object of class \code{cross}. See 'qtl' package manual for \code{read.cross} function details.}
\item{peak}{An object of class \code{peak}. See \code{define.peak} for details. }
\item{th}{A numeric vector of length 1 with value between 0 and 1. The R square significance threshold to keep the R square values.}
\item{round}{An optional integer indicating the precision to be used for the R square value and it significance. The function 'round' is used for R square value \code{rsq}. The function 'signif' is used for the significance \code{pF} ( i.e. p(F) ).  See \code{round} and \code{signif} functions for details.}
}

\details{
Estimate the proportion of the phenotypic variation explained by the segregation of an individual QTL or a significant QTL interactions (also called R square). Compute R square i.e. to compare the phenotypic variation explained by the presence of a genetic determinant (an individual QTL or a QTLs interaction) with the total phenotypic variation. Here we use an AnOVa with a linear model including all possible epistatic interactions.

Let a trait be affected by 3 QTLs localised at 3 markers \bold{M1}, \bold{M2} and \bold{M3} respectively.
The AnOVa is computed for the linear model: \deqn{M1 + M2 + M3 + M1:M2 + M1:M3 + M2:M3 + M1:M2:M3}
The R square for each genotypic group is the comparison of the variance due to the between- groups variability (called Mean Square Effect, or MSeffect) with the within- group variability (called Mean Square Error, or Mserror).

The significance of an epistatic interaction is the significance of the group effect of each interaction computed by the AnOVa. If one wants to store the results within a QTL database, it might be useful to compute all genetic determinants by setting \code{th=1} and then to extract the significant results by SQL queries.
}

\value{
Return an object of class \code{rsq} which is a simple data frame with columns:
\item{qtl}{The name of the genetic determinant. If the genetic determinant is an individual QTL, the name is formated as \code{"trait_name.chr_number.order_number"}. In the case of epistasis, the genetic determinant name is formated as the list of individual genetic determinant (QTL) names separated by \code{":"}.}
\item{rsq}{The R square value (set to NA if not significant: \code{pF < th}).}
\item{pF}{The significance (set to NA if not significant: \code{pF < th}).}
}

\author{ Hamid A. Khalili }

\seealso{ \code{read.cross}, \code{define.peak}}

\examples{
data(seed10);

# Genotype probabilities
seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');
seed10 <- sim.geno( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');

# Genome scan and QTL detection
out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');
out.peak <- define.peak(out.em, 'all');

# R square computing
out.rsq <- calc.Rsq(seed10,out.peak);

# R square computing without taking account of any significance
out.rsq <- calc.Rsq(seed10,out.peak,th=1);

}
\keyword{models}
