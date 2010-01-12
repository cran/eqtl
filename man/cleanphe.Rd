\name{cleanphe}
\alias{cleanphe}
\title{Remove undesired phenotypes and LOD results from cross and scanone object respectively}
\description{
Drops the phenotypes or the LOD results within an object of class \command{cross} or \command{scanone} respectively. The names of the phenotypes and the lodcolumns to be removed are defined by a character string or regular expression.
}
\usage{
cleanphe(x, string = "Buffer")
}
\arguments{
\item{x}{An object of class \command{cross} or class \command{scanone} containing at least two phenotypes. See 'qtl' package manual for \command{read.cross} and \command{scanone} functions details.}
\item{string}{The string which describes the names of the phenotypes or the results to remove. It can be defined as a regular expression or just the name of a column. See \command{grep} for details.}
}
\details{
This function is useful to systematically dropping phenotypes like buffers or controls existing in microarray data or clean out the scanone results in context of expression QTL mapping. The names of the phenotypes and results from objects of  \command{cross} and \command{scanone} class are column names which are defined by a single string or a regular expression specified by the argument \command{string}.
The \command{grep} function searches the data to be removed as follow:
\itemize{
	\command{grep(string,names(x))} when x have class \command{scanone}.\cr
	\command{grep(string,names(x\$pheno))} when x have class \command{cross}.\cr
}
}
\value{
Returns the input cross or scanone object.
}
\author{ Hamid A. Khalili }
\examples{
data(seed10);

# Genotype probabilities and genome scan
\dontrun{seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0, 
	 map.function='kosambi', stepwidth='fixed');}
out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='hk');

# Clean cross object and genome scan
seed10 <- cleanphe(seed10,'Buffer');
seed10 <- cleanphe(seed10,'ctrl');

out.em <- cleanphe(out.em,'Buffer');
out.em <- cleanphe(out.em,'ctrl');
}
\seealso{ \code{\link[base]{grep}},\code{\link[qtl]{scanone}},\code{\link[qtl]{read.cross}}}
\keyword{utilities}
