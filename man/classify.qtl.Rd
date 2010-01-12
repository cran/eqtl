\name{classify.qtl}
\alias{classify.qtl}
\title{Estimate the acting type of expression QTL}
\description{Estimate wether an eQTL is cis- or trans- acting.}
\usage{classify.qtl(cross, peak, etrait.coord, data.gmap)}

\arguments{
\item{cross}{An object of class \command{cross}. See \sQuote{qtl} package manual for \code{\link[qtl]{read.cross}} function details.}
\item{peak}{An object of class \command{peak}. See \code{\link{define.peak}} for details.}
\item{etrait.coord}{A \command{data.frame} with column names \command{"etrait.name","chr","start","stop"} specifying the etrait (expression trait) location on the genome:
\enumerate{
\item \code{etrait.coord$array_element_name} is character strings vector specifying the name of the etraits.
\item \code{etrait.coord$chr} is a vector of integers specifying the chromosome on which the markers are localized.
\item \code{etrait.coord$start} is a vector of integers specifying the start of the etrait's sequence in base pair.
\item \code{etrait.coord$stop} is a vector of integers specifying the stopo of the etrait's sequence in base pair.
}
}
\item{data.gmap}{ A \command{data.frame} with column names \command{"Marker"}, \command{"chr"} and \command{"PP"} specifying the marker's physical location. Those ones must be the same markers defined in the related \command{cross} object.
\enumerate{
\item \code{data.gmap$Marker} is a vector character strings specifying the names of markers.
\item \code{data.gmap$chr} is a vector of integers specifying the chromosomes on which the markers are localized.
\item \code{data.gmap$PP} is a vector of integers specifying the physical marker locations on the chromosomes in base pair.
}
}
}

\details{
Useful in the case of genome-wide expression QTL mapping. Determines cis-acting and trans-acting eQTL (or cis- and trans- eQTL) and gives a basic overview about the global eQTL network. The (potential) cis-eQTL are those which colocalize with the controlled gene. These could be typically explained by a modification within a gene promoter and therefore actually correspond to a cis-regulation (note that it would remain to be confirmed on a case by case basis: due to the lack of precision in QTLs localization for all analysis methods, a cis-acting is still biologically hypothetical; plus it could also correspond to a trans-acting eQTL localised close to its target gene). eQTLs which contains the regulated gene within their LOD support interval are classified in this category as \command{cis}. The trans-acting eQTLs are defined as those which do not colocalize with the affected gene. These could typically correspond to the mode of action of a transcription factor on the regulation of another gene's expression. eQTL which do not contain the regulated gene within their LOD support interval are classified as \command{trans}.
}

\note{
The QTL support interval locations are defined within a \command{peak} object. This classification (performed by \code{\link{classify.qtl}}) depends entirely on the support interval definition computed by the \code{\link{define.peak}} function. This function tend to underestimate cis-eQTL number as LOD-drop value are more conservative. This, however, does not replace the scientist's own manual examination of the LOD curve.
}

\value{
The input \command{peak} object is returned with a component \command{type} added to the components of 
\command{names(peak\$trait\$chromosome)} for each previously detected QTL:
\item{type}{
	\command{cis} or \command{trans} for cis- and trans- eQTL respectively.
	\command{<NA>} if the etrait location is unknown or not nuclear.
}
}

\author{ Hamid A. Khalili }
\seealso{\code{\link[qtl]{read.cross}},\code{\link{define.peak}},\code{\link{calc.adef}}}
\examples{
data(seed10);

# Genotype probabilities
\dontrun{seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0,
	map.function='kosambi', stepwidth='fixed');
seed10 <- sim.geno( cross=seed10, step=2, off.end=0, error.prob=0,
	map.function='kosambi', stepwidth='fixed');}

# Genome scan and QTL detection
out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='hk');
out.peak <- define.peak( out.em, 'all');

# Additive effect computing and peaks localization
out.peak <- calc.adef(seed10,out.em,out.peak);
data(BSpgmap);
out.peak <- localize.qtl(seed10,out.peak,BSpgmap);

# Estimated actind-type of the expression QTL affecting
# the 100th expression trait and localized on chromosome 1
data(ATH.coord)
out.peak <- classify.qtl(seed10,out.peak,ATH.coord,BSpgmap);
out.peak[[26]]$'4'$type;

# idem for the trait 'CATrck'
out.peak$CATrck$'4'$type;

}
\keyword{models}
