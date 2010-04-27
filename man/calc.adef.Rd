\name{calc.adef}
\alias{calc.adef}
\title{Compute the additive effect at each QTL marker}
\description{
Computes the additive effect at QTL marker by meaning the phenotypic value for each genotypic group.
}
\usage{calc.adef(cross, scanone, peak, round, \dots)}
\arguments{
  \item{cross}{ An object of class \command{cross}. See 'qtl' package manual for \code{\link[qtl]{read.cross}} function details.}
  \item{scanone}{ An object of class \command{scanone}. See 'qtl' package manual for \code{\link[qtl]{read.cross}} function details.}
  \item{peak}{ An object of class \command{peak}. See \code{\link{define.peak}} function for details.}
  \item{round}{An optional integer indicating the precision to be used for the additive effect value. See \command{round} function for details.}	
  \item{\dots}{ Additional arguments passed to the functions \code{\link[graphics]{plot}} and \code{\link[qtl]{effectplot}} when it is called.}
}
\details{
  Uses Karl Broman's  \code{\link[qtl]{effectplot}} function to mean the phenotype for each genotypic group defined at the QTL marker. The additive effect is computed as the difference between the phenotypical means of the two genotypic groups (homozygous). The parental reference allele is allele 2.
By default, allele 1 is encoded as A and allele 2 as B, therefore the additive effect is \bold{mean(B)-mean(A)} where \bold{mean(A)} is the phenotypical mean of genotypic group \bold{A} and \bold{mean(B)} is the phenotypical mean of the genotypic group \bold{B}.
}
\value{
The input \command{peak} object is returned with component, \command{adef}, added to components of \command{peak\$trait\$chromosome} for each previously detected QTLs.
\item{additive.effect}{The additive effect value at the QTL marker}
}
\references{ Broman KW, Wu H, Sen S, Churchill GA (2003) R/qtl: QTL mapping in experimental crosses. Bioinformatics  19:889-890 }
\author{ Hamid A. Khalili }
\note{ It is necessary to have previously performed the \command{sim.geno} function. It is not recommended to plot the allelic contribution by using the function \code{\link{calc.adef}}. It is preferable to use directly Karl Broman's code{\link[qtl]{effectplot}} function (using the parameter \command{draw=TRUE}). See 'qtl' package manual for code{\link[qtl]{effectplot}} function details.}
\seealso{\code{\link[qtl]{effectplot}},\code{\link{define.peak}},\code{\link[qtl]{read.cross}},\code{\link[graphics]{plot}}}
\examples{
data(seed10);

# Genotype probabilities
\dontrun{seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');
seed10 <- sim.geno( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');}

# Genome scan and QTL detection
out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');
out.peak <- define.peak(out.em, 'all');

# Additive effect computing
out.peak <- calc.adef(seed10,out.em,out.peak,round=3);

# Additive effect of the QTLs affecting the 26th trait
# and localized on chromosome 1
out.peak[[26]]$'4'$additive.effect;

# Peak's features describing the QTLs affecting the 26th trait
# and localized on chromosome 1
out.peak[[26]]$'4';

# idem for the trait 'CATrck'
out.peak$CATrck
out.peak$CATrck$'4'
out.peak$CATrck$'4'$additive.effect
}

\keyword{models}
