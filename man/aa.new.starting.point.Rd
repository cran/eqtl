\name{A new starting point}
\alias{A new starting point}
\alias{eqtl-package}

\title{Introductory comments on R/eqtl}
\description{
	A brief introduction to the R/eqtl package, with a walk-through of a typical analysis.
}

\section{Preliminaries to R/eqtl}{
	\itemize{
		\item In order to use the R/eqtl package, you must type (within R) \code{library(qtl)} and \code{library(eqtl)}. You may want to include this in a \code{\link[base:Startup]{.Rprofile}} file.
		\item Documentation and several tutorials are available from the R archive (\url{http://cran.r-project.org}).
		\item Use the \code{\link[utils]{help.start}} function to start the html version of the R help.
		\item Type \code{library(help=qtl)} to get a list of the functions in R/qtl.
		\item Type \code{library(help=eqtl)} to get a list of the functions in R/eqtl.
		\item Download the latest version of R/qtl and R/eqtl.
	}
}

\section{Walk-through of a typical analysis}{
Here we briefly describe the use of R/eqtl and R/qtl to analyze an experimental cross. R/eqtl is an add-on package to Karl Broman's R/qtl. It requires the 'qtl' package and uses some of its functions. Therefore this tutorial takes in consideration prior knowledge of R/qtl. You must read the R/qtl documentation and tutorial before to perform any analysis with the 'eqtl' add-on.

A difficult first step in the use of most data-analysis software is to import the data in adequate format. This step is perfectly described in R/qtl tutorial. With R/eqtl you should import some extra data in addition to the data needed for R/qtl. We won't discuss about data import at this point. This step is described in the next chapter 'First step'.

We consider the example data \code{seed10}, an experiment on gene expression in \emph{Arabidopsis thaliana}. Use the \code{data} function to load the data.

\code{data(seed10)}

\code{seed10} data have class \code{cross} and \code{riself}. It describes an experiment on a RIL population obtained by single seed descent. The function \code{summary.cross} gives summary information on the data, and checks the data for internal consistency. A lot of utility functions are available in 'qtl' and are widely described in Karl's tutorial.

To project our results on the physical map, we also need to load the physical position of the genetic markers and the genomic physical coordinates of the probes used to estimate expression traits described in \code{seed10}. For information, \code{BSpgmap} and \code{ATH.coord} are simple data frame with specific column names.

\code{data(BSpgmap)} \cr
\code{names(BSpgmap)} \cr
\code{data(ATH.coord)} \cr
\code{names(ATH.coord)}

Before running the QTL analysis, intermediate calculations need to be performed. The function \code{calc.genoprob} is used to compute the conditional probabilities at each pseudo-marker. \code{sim.geno} simulates sequences of genotypes from their joint probabilities. See 'qtl' manual for details. These steps have been already performed on seed10 and you may not need to run them again. Here, pseudo-markers have been defined every 0.5 centimorgan ( \code{step=0.5} ).

\code{seed10 <- calc.genoprob(seed10, step=0.5, off.end=0, error.prob=0,} \cr
\code{		map.function='kosambi', stepwidth='fixed')} \cr
\code{seed10 <- sim.geno(seed10, step=0.5, off.end=0, error.prob=0,} \cr
\code{		map.function='kosambi', stepwidth='fixed')}

Use the \code{scanone} function to perform an interval mapping.
\code{BaySha.em <- scanone(seed10,method='em',pheno.col=1:nphe(seed10),model='normal')}

The microarray probes usually contains data for which we don't want to perform any QTL analysis like the buffers, the controls or some missed probes. The function \code{clean.phe} cleans the \code{seed10} and/or the \code{BaySha.em} data for undesired phenotypes.

\code{seed10.cleaned <- clean.phe(seed10,"Buffer")} \cr
\code{seed10.cleaned <- clean.phe(seed10,"Ctrl")} \cr
\code{BaySha.em <- clean.phe(BaySha.em,"Buffer")} \cr
\code{BaySha.em <- clean.phe(BaySha.em,"Ctrl")}

In this example, dropped data comes from probes named \code{"Buffer"} and \code{"Ctrl"} found within CATMA data. Note that one could a priori clean the \code{seed10} data before computing the interval mapping. The scanone object will be directly generated clean.

One of the major problematic step for genome-wide expression QTL analysis, is to read all the LOD curves and sytematically define the QTLs. Because of the amount of results, it is not feasible to read by eyes all the LOD curves. Use \code{define.peak} function to define QTL with drop LOD support interval from the scanone results, here the interval mapping results \code{BaySha.em}.

\code{BaySha.peak <- define.peak(BaySha.em,locdolumn='all')} \cr
\code{class(BaySha.peak)}

The parameter \code{lodcolumn='all'} specifies to analyse all LOD columns (all the traits) of the scanone object \code{BaySha.em}. \code{lodcolumn='CATrck'} specifies to analyse the scanone LOD column \code{CATrck} only, which is supposed to be the interval mapping result of the trait \code{CATrck}.

We call \code{peak} object, the results of the \code{define.peak} function. The \code{peak} object is used to store the QTL definition. The QTL are defined by several features decribed in the \code{peak} objects attributes. At this step, a QTL is only defined by its LOD score, its location, the subjective quality of the LOD peak. See \code{define.peak} function for details.

\code{attributes(BaySha.peak)}

Back to the \code{define.peak} parameters. \code{graph=TRUE} specifies to draw the LOD curves with LOD support interval. The curves showing a QTL detected will be drawn on different charts for each chromosome. Note that, no graphical setup has been defined and therefore all graphs generated will appear one above the others. You should specify the graphical parameter \code{mfrow} of the R function \code{par()} before running \code{define.peak} to draw all charts in the same window. You may not want to set the parameters \code{graph=TRUE} and \code{lodcolumn='all'} at the same time, depending on the amount of traits analyzed.

The following command lines gives an example to define QTL and draw chart for a unique trait \code{CATrck}.

\code{png(filename='CATrck.png',width=800,height=600)} \cr
\code{par(mfrow=c(1,5))} \cr
\code{define.peak(BaySha.im, lodcolumn='CATrck', graph=TRUE, chr=c(1,5))} \cr
\code{par(mfrow=c(1,1))} \cr
\code{dev.off();}

\code{png()} and \code{dev.off()} are classical R functions which indicates here to print the graph generated as a png file \code{'CATrck.png'}. By using these functions, you can page set the graph as you wanted. Differently, the \code{define.peak} function parameter's, \code{save.pict=TRUE}, will systematically save all single LOD curves generated for each chromosome as png files. The files generated will be named with the names of the trait and the chromosomes where the QTLs are located. So beware to the amount of data you're analysing before setting the parameters \code{save.pict=TRUE}.

The way to access QTL results within \code{peak} object is quite simple:

\code{BaySha.peak} \cr
\code{BaySha.peak$CATrck}

\code{BaySha.peak} will give you the \code{define.peak} results ordered by trait and chromosomes, respectively. \code{BaySha.peak$CATrck} will give you the results for the trait \code{'CATrck'} and so on for other trait names. If no QTL had been detected for a trait, the result will be the value \code{NA}.

To complete the QTL analysis, use the functions \code{calc.adef}, \code{localize.qtl} and \code{classify.qtl} to compute, for each QTL previously detected in \code{peak} object, the additive effect, the estimated physical location and the estimated acting-type in case of eQTL, respectively. All of these functions will add peak features to the \code{peak} object.

\code{BaySha.peak <- localize.qtl(cross=seed10.cleaned, peak=BaySha.peak,} \cr
\code{ data.gmap=BSpgmap)} \cr
\code{BaySha.peak <- calc.adef(cross=seed10.cleaned, scanone=BaySha.em,} \cr
\code{ peak=BaySha.peak)} \cr
\code{BaySha.peak <- classify.qtl(cross=seed10.cleaned, peak=BaySha.peak,} \cr
\code{ etrait.coord=ATH.coord, data.gmap=BSpgmap)}\cr
\code{attributes(BaySha?peak)}

For each of these functions you have to specify the \code{peak} object. You also need to specify the related \code{cross} object and \code{scanone} results, the related genetic map physical data \code{BSpgmap} and the expression traits  physical data \code{ATH.coord}. Note that, the expression trait physical data (here \code{ATH.coord}) may contain more traits than those studied. Conversely, all traits studied within the \code{peak}, the \code{scanone} or the \code{cross} objects must be described in \code{ATH.coord}.

Use \code{calc.Rsq} function to compute, from a \code{peak} object, the contribution of the individual QTLs to the phenotypic variation. At the same time this function tests and computes the contribution of significant epistatic interactions between QTLs. By default the significant threshold is set to \code{th=0.001}. In case you wanted to take all QTL interactions whatever the significance, you must set \code{th=1}.

\code{BaySha.Rsq <- calc.Rsq(cross=seed10.cleaned,peak=BaySha.peak)} \cr
\code{BaySha.Rsq} \cr
\code{plot.Rsq(rsq=BaySha.Rsq)}

The function \code{peak.2.array} will format all QTL results in a simple array. The column names are the names of the peak features described in \code{peak} object. This array have class \code{peak.array}. \code{Rsq.2.array} add the R square column to the QTL array. Formating the results as a simple array allows to use all basic and complex R functions (statistical, summary, graphical, histograms...) to study the results customly and in the simplest way. This format also allows to write the results in a file (like text or CSV) to save out the data.

\code{BaySha.array <- peak.2.array(BaySha.peak);} \cr
\code{BaySha.array <- Rsq.2.array(rsq=BaySha.Rsq,BaySha.array);}

'eqtl' provides also useful functions to get an overview of the QTLs results stored in \code{peak.array}:
The \code{summary.peak} function gives a variety of summary information and an overview of peak distribution. Summary graphs are available by setting \code{graph=TRUE}. Like \code{define.peak}, no graphical parameters had been setted and therefore all graphs generated will appear one above the others in the same R graph window. You may define \code{mfrow} before running \code{summary.peak} to draw all charts in the same R window.\cr
\cr
Whole QTL summary with graphs:

\code{par(mfrow=c(2,4))} \cr
\code{BaySha.summary <- summary.peak(peak.2.array,seed10.cleaned,graph=TRUE)} \cr
\code{par(mfrow=c(1,1))} \cr
\code{names(BaySha.summary)} \cr
\code{BaySha.summary}\cr

QTL summary with graphs excluding QTL localized on the chromosome 3 between 5000 and 6000 bp:

\code{par(mfrow=c(2,4))} \cr
\code{BaySha.sum_exc <- summary.peak( BaySha.array, seed10.cleaned,} \cr
\code{ exc=data.frame(inf=5000, sup=6000, chr=3), graph=TRUE)} \cr
\code{par(mfrow=c(1,1))} \cr
\code{names(BaySha.sum_exc)} \cr
\code{BaySha.sum_exc} \cr

The function \code{plot.genome} provides basic informations and an overview about genome-wide eQTL parameters.

\code{plot.genome(seed10.cleaned, BaySha.array, ATH.coord, BSpgmap, chr.size=c(30432457, 19704536, 23470536, 18584924, 26991304), save.pict=TRUE);}

The parameter \code{chr.size} is the size of the chromosomes in base pair (here A. thaliana). These sizes are used to delimit the chromosomes for genome-wide graphs. For this function, the page setting has already been specified. \code{save.pict=TRUE} will save all graphs in different files within the current folder.

Use the function \code{cim.peak} to systematically perform a composite interval mapping by running a single genome scan \code{scanone} with previously defined QTL as additives covariates. The additive covariates are defined from a \code{peak} object as the closest flanking marker of LOD peaks with the function \code{map.peak}. \code{cim.peak} returns an object of class \code{scanone} and therefore could be analyzed by the \code{define.peak} function. Then, the results can be analyzed by \code{calc.adef}, \code{localize.qtl}, \code{calc.Rsq}, etc... Due to the model, the LOD curve present a high (artefactual) LOD peak at the additive covariates locations which will be wrongly detected as a strong QTL by the function \code{define.peak}. To avoid that, use \code{wash.covar} function which will set the LOD score at the covariates location to 0 LOD. This function take care of a genetic window size which specifies the size of the region to "wash".

\code{BaySha.cem <- cim.peak(seed10.cleaned,BaySha.peak)} \cr
\cr
\code{covar <- map.peak(BaySha.peak)} \cr
\code{covar} \cr
\cr
\code{my_washed_BaySha.cem <- wash.covar(BaySha.cem, covar, window.size=20)} \cr
\code{BayShacim.peak <- define.peak(BaySha.em, lodcolumn='all')} \cr
\code{BayShacim.peak <- calc.adef(cross=seed10.cleaned, scanone=my_washed_BaySha.cem,} \cr
\code{peak=BayShacim.peak)} \cr
\code{BayShacim.peak <- localize(cross=seed10.cleaned, peak=BayShacim.peak,} \cr
\code{ data.gmap=BSpgmap)} \cr
\code{BayShacim.peak <- classify(cross=seed10.cleaned, peak=BayShacim.peak,} \cr
\code{ etrait.coord=ATH.coord,data.gmap=BSpgmap)} \cr
\code{BayShacim.Rsq <- calc.Rsq(cross=seed10.cleaned, peak=BayShacim.peak)} \cr
\code{plot.Rsq(BayShacim.Rsq)} \cr
\code{BaySha.cim.array <- peak.2.array(BayShacim.peak)} \cr
\code{BaySha.cim.array <- Rsq.2.array(BayShacim.Rsq,BayShacim.array)}

enjoy ;o)
}

\author{ Hamid A Khalili, \email{hamid.khalili@gmail.com} }
\keyword{models}
