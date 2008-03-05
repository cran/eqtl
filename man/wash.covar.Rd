\name{wash.covar}
\alias{wash.covar}
\title{Erase additive covariates LOD peaks on the LOD curve}
\description{
	Sets LOD curve to 0 for a given region size around cofactors included in CIM.
}
\usage{
wash.covar(scanone,covar,window.size=20)
}
\arguments{
	\item{scanone}{ An object of class \code{scanone}. See 'qtl' package manual for \code{scanone} function details.}
	\item{covar}{ A data frame with columns \code{'trait'}, \code{'chr'} and \code{'cM'}.\cr
			\code{covar$trait} is a character strings vector which specifies the names of the traits.\cr
			\code{covar$chr} is an integer vector which specifies the number of the chromosome. \cr
			\code{covar$cM} is a numeric vector which specifies the cofactor position in cM. \cr
		}
	\item{window.size}{ a single numeric value which specifies the size of the region to set at zero LOD.}
}
\details{ This function is useful to extract the new QTLs from composite interval mapping results. The artifactual LOD peak value obtained from the cofactors are set at zero LOD. Then the QTLs are defined by using the function \code{define.peak} . The cofactors loci are defined in a data frame which can be performed by the function \code{map.peak}. In this case, the cofactors will be at the maximum LOD peak location defined within the related peak object.
}
\value{
The input \code{scanone} object is returned.
}
\author{ Hamid A. Khalili }
\seealso{ \code{\link[qtl]{scanone}}, \code{\link{cim.peak}}, \code{\link{map.peak}} }
\examples{
data(seed10);

seed10 <- calc.genoprob( cross=seed10, step=3, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');
seed10 <- sim.geno( cross=seed10, step=3, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');

out.em <- scanone( seed10, pheno.col=1:5, model='normal', method='em');
out.peak <- define.peak( out.em, 'all');

covar <- map.peak(out.peak)

out.cem <- cim.peak(seed10,out.peak);
out.cem <- wash.covar(out.cem,covar);

out_composite.peak <- define.peak(out.cem,'all');
}
\keyword{models}

