\name{peak.2.array}
\alias{peak.2.array}
\title{Build a simple array from a peak object}

\description{
Build a simple array from a peak object.
}

\usage{
peak.2.array(peak)
}

\arguments{
\item{peak}{An object of class \code{peak}. See \code{define.peak} for function details.}
}

\details{
Useful for a genome-wide eQTL mapping. Formating the results as a simple array allow to use all classical R functions (graphical, statistical, summaries, ...) and permits all kind of manipulation for the results by the simplest way. All expression traits are represented and those which are not affected by any QTL, contain the empty data \code{<NA>} in each column.
}

\value{
Return an object of class \code{array.peak} which is a data frame whith columns:
\item{trait}{The name of the studied traits.}
\item{chr}{The number of the chromosome.}
\item{mname.peak}{The peak (pseudo-)marker name when a QTL was detected. \code{<NA>} if no QTL was detected.}
\item{lod}{The peak LOD score when a QTL was detected. \code{<NA>} if no QTL was detected.}
\item{peak.cM}{The genetic position of the peak in centiMorgan(cM) when QTL was detected. \code{<NA>} if no QTL was detected.}
\item{mname.inf}{The (pseudo-)marker name corresponding to the inferior SI bound when a QTL was detected. \code{<NA>} if no QTL was detected.}
\item{inf.cM}{The genetic position of the inferior SI bound in centiMorgan(cM) when a QTL was detected. \code{<NA>} if no QTL was detected.}
\item{mname.sup}{The (pseudo-)marker names corresponding to the superior SI bound when a QTL was detected. \code{<NA>} if no QTL was detected.}
\item{sup.cM}{The genetic position of the superior SI bound in centiMorgan(cM) if a QTL was detected. \code{<NA>} if no QTL was detected.}
\item{si.quality}{The subjective quality if the support interval. See '\code{define.peak}' for details.}

According the methods used to create the peak object, the following columns could be persent:
\item{additive.effect}{The additive effects of the QTL. \code{<NA>} if no QTL has been detected.}
\item{peak.bp}{The physical position of the maximum LOD peak. \code{<NA>} if no QTL was detected.}
\item{inf.bp}{The physical position of the SI lower bound. \code{<NA>} if no QTL was detected.}
\item{sup.bp}{The physical position of the SI upper bound. \code{<NA>} if no QTL was detected.}
\item{type}{The estimated type of the eQTLs ( trans or cis for  cis- and trans- eQTL respectively). \code{<NA>} if no QTL was detected or in case of non nuclear expression trait.}
}

\author{ Hamid A. Khalili }

\seealso{ \code{\link[qtl]{scanone}},\code{\link[qtl]{read.cross}}}

\examples{
data(seed10);

# Genotype probabilities and genome scan
seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');
seed10 <- sim.geno( cross=seed10, step=2, off.end=0, error.prob=0,
	 map.function='kosambi', stepwidth='fixed');
out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');

# Defining QTLs for all traits
out.peak <- define.peak( out.em, 'all',graph=TRUE,save.pict=TRUE);

# do not run
# out.array <- peak.2.array(out.peak);

# Computing additive effect
out.peak <- calc.adef(seed10,out.em,out.peak);

# Localizing peak
data(BSpgmap);
out.peak <- localize.qtl(seed10,out.peak,BSpgmap);

out.array <- peak.2.array(out.peak);
}
\keyword{print}

