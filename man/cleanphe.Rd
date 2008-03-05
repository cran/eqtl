\name{cleanphe}
\alias{cleanphe}
\title{Remove undesired phenotypes and LOD results from cross and scanone object respectively}
\description{
Drop the phenotypes or the LOD results within an object of class \code{cross} or \code{scanone} respectively. The names of the phenotypes and the lodcolumns to remove are defined by a character string or a regular expression.
}
\usage{
cleanphe(x, string = "Buffer")
}
\arguments{
	\item{x}{An object of class \code{cross} or class \code{scanone} containing at least two phenotypes. See 'qtl' package manual for \code{read.cross} and \code{scanone} functions details.}
	\item{string}{The string which describes the names of the phenotypes or the results to remove. It can be defined as a regular expression or just the name of a column. See \code{grep} for details.}
}
\details{
This function is useful to systematically drop phenotypes like buffers or controls existing in microarray data or clean out the scanone results in context of expression QTL mapping. The names of the phenotypes and the results from objects of class \code{cross} and class \code{scanone} are column names which are defined by a single string or a regular expression specified by the argument \code{string}.
The data to remove are searched by the \code{grep} function as follow:
\itemize{
	\code{grep(string,names(x))} when x have class \code{scanone}.\cr
	\code{grep(string,names(x$pheno))} when x have class \code{cross}.\cr
}
}
\value{
Return the input cross or scanone object.
}
\author{ Hamid A. Khalili }
\examples{
data(seed10);

# Genotype probabilities and genome scan
seed10 <- calc.genoprob( cross=seed10, step=2, off.end=0, error.prob=0, 
	 map.function='kosambi', stepwidth='fixed');
out.em <- scanone( seed10, pheno.col=1:50, model='normal', method='em');

# Clean cross object and genome scan
seed10 <- cleanphe(seed10,'Buffer');
seed10 <- cleanphe(seed10,'ctrl');

out.em <- cleanphe(out.em,'Buffer');
out.em <- cleanphe(out.em,'ctrl');
}
\seealso{ \code{\link[base]{grep}},\code{\link[qtk]{scanone}},\code{\link[qtl]{read.cross}}}
\keyword{utilities}
