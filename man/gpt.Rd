\name{gpt}
\alias{gpt}
\title{Global Permutation Threshold}
\description{
Computes a Global Permutation Threshold to estimate a LOD score significance threshold.
}
\usage{
gpt(cross, n_etrait=100, n_perm=1000)
}
\arguments{
	\item{cross}{ An object of class \command{cross}. See 'qtl' package manual for \command{read.cross} function details.}
	\item{n_etrait}{ An integer which specifies the number of individuals on which the permutation test are performed.}
	\item{n_perm}{ An integer. This argument defines the number of permutation replicates.}
}
\details{Computes the Global Permutation Threshold which fits to a single-QTL scan (using \command{scanone} function) by permuting the phenotypes while maintaining the genotype for a sample of individuals randomly chosen within an object of class \command{cross}. The GPT estimates the LOD score significance threshold if 1000 permutations at least are computed on 100 individuals at least (i.e. 100,000 permutations).}
\value{ An object of class \command{scanoneperm} }
\references{Churchill and Doerge (1994) Empirical threshold values for quantitative trait mapping. Genetics 138:963-971 }
\author{ Hamid A. Khalili }
\seealso{\code{\link[qtl]{read.cross}},\code{\link[qtl]{scanone}},\code{\link[qtl]{add.threshold}}}
\examples{

data(seed10);

# Compute the global permutation test with 1000 permutations on 100 individuals
\dontrun{out_1000.gpt <- gpt(seed10,100,1000);}

# Compute the global permutation threshold with 100 permutations on 100 individuals
out_100.gpt <- gpt(seed10, 10, 10)

# Significance LOD threshold value with alpha at 0.05 (5%)
\dontrun{th_1000 <- out_1000.gpt[order(out.gpt,decreasing=TRUE)][5000];}
th_100 <- out_100.gpt[order(out_100.gpt,decreasing=TRUE)][50];

th_100;
mean(summary(out_100.gpt, alpha=0.05));

hist(out_100.gpt,nclass=50,col='gray')
abline(v=th_100,col='red')

# out.em <- scanone(seed10, method='em', chr=c(1:5));
\dontrun{plot(out.em, chr=c(1:5));
add.threshold(out.em, chr=c(1:5), perms=out_1000.gpt, alpha=0.05);
add.threshold(out.em, chr=c(1:5), perms=out_1000.gpt, alpha=0.1, col="green");}

}
\keyword{models}
