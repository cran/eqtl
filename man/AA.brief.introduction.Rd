\name{A brief introduction}
\alias{eqtl-package}

\title{Introductory comments on R/eqtl}
\description{A brief introduction to the R/eqtl package, with a walk-through of a typical analysis.}

\section{Preliminaries to R/eqtl}{
	\itemize{
		\item In order to use the R/\pkg{eqtl} package, you must type (within R)  \command{library(eqtl)}. This function will automatically load the R/\pkg{qtl} library required. You may want to include this in a \code{\link[base:Startup]{.Rprofile}} file.
		\item Documentation and several tutorials are available from the R archive : \url{http://cran.r-project.org}.
		\item Use the \code{\link[utils]{help.start}} function to start the html version of the R help.
		\item Type \code{library(help=qtl)} to get a list of the functions in R/\pkg{qtl}.
		\item Type \code{library(help=eqtl)} to get a list of the functions in R/\pkg{eqtl}.
		\item Download the latest version of R/\pkg{qtl} and R/\pkg{eqtl}.
	}
}

\section{Walk-through of an analysis with R/eqtl}{
	Here I briefly describe how to use R/\pkg{eqtl} to analyze an experimental cross. R/\pkg{eqtl} contains functions which required Karl Broman's R/\pkg{qtl} functions. This tutorial takes in consideration prior knowledge of R/\pkg{qtl}. Therefore, it is highly recommended that you read the R/\pkg{qtl} documentation and tutorials before you perform any analysis.

	%The data
	%\itemize{\item \bold{The data}}
	\subsection{The data}{

	A difficult first step in the use of most data-analysis software is to import the data in an adequate format. This step is perfectly described in R/\pkg{qtl} tutorials. With R/\pkg{eqtl} you should import some extra data in addition to the data needed for R/\pkg{qtl}. We will not discuss data import at this point. This step is described in the chapter \dQuote{Importing the data}.
	%end of paragraph

	We consider the example data \command{seed10}, an experiment on gene expression in \emph{Arabidopsis~thaliana}. Use the \command{data} function to load the data.

	\preformatted{data(seed10);}

	\command{seed10} data is formatted by \command{read.cross} function. This data object has class \command{cross} and \command{riself} and describes an experiment on an \emph{A.~thaliana} \acronym{RIL} population. The function \command{summary.cross} gives summary information on the data, and checks the data for internal consistency. A lot of utility functions are available in R/\pkg{qtl} and are widely described in Karl's tutorials. Please note~:  \command{seed10} is too large to be viewed in the R window. What is shown is the average phenotypes. Is is possible to use the \command{attributes} function later to get a closer look.
	%end of paragraph

	To project our results on the physical map, we also need to load the physical position of the genetic markers and the genomic physical coordinates of the probes used to estimate expression traits described in \command{seed10}. For information, \command{BSpgmap} and \command{ATH.coord} are simple data frames with specific column names.

	\preformatted{
data(BSpgmap);
names(BSpgmap);
data(ATH.coord);
names(ATH.coord);
	}
	}%end of subsection

	%The interval mapping
	%\itemize{\item \bold{The interval mapping}}
	\subsection{The Interval Mapping}{

	Before running the QTL analysis, intermediate calculations need to be performed. The function \command{calc.genoprob} is used to compute the conditional probabilities at each pseudo-marker while \command{sim.geno} simulates sequences of genotypes from their joint probabilities. See R/\pkg{qtl} manual for details. These steps have already been performed on seed10 and you do not need to run them again. Here, pseudo-markers have been defined every 0.5 centimorgan by defining the parameter \command{step=0.5} as described in the following lines.
	\preformatted{
#DO NOT RUN
seed10 <- calc.genoprob(seed10, step=0.5, off.end=0, error.prob=0, 
	map.function='kosambi', stepwidth='fixed');
#DO NOT RUN
seed10 <- sim.geno(seed10, step=0.5, off.end=0, error.prob=0,
	map.function='kosambi', stepwidth='fixed');
	}
	%end of paragraph

	The microarray probes usually contain data for which we don't want to perform any QTL analysis like the buffers, the controls or some missed probes. The function \command{cleanphe} cleans the \command{seed10} data for undesired phenotypes.
	\preformatted{
seed10.clean <- cleanphe(seed10,"Buffer");
seed10.clean <- cleanphe(seed10,"Ctrl");
	}
	In this example, dropped data comes from probes named \command{"Buffer"} and \command{"Ctrl"} found within CATMA data. This function is based on the \command{grep} function of R. Thus it can be used to remove all the data defined within a specific word (for example \command{"CHLORO"} will remove all items that contain \command{"CHLORO"} within it).
	%end of paragraph

	Note that the function \command{cleanphe} can also be run on \command{scanone} object. This is useful in case of you forget to clean your \command{cross} object before running \command{scanone}. For this, you have to be very careful to what you're doing. It is indeed important for the next steps of the analysis to keep a \command{cross} object whose phenotypes fit perfectly with those described in \command{scanone} object.
	%end of paragraph

	Use the \command{scanone} function to perform an interval mapping.

	\preformatted{
BaySha.em <- scanone(seed10.clean,method='em',
        pheno.col=1:nphe(seed10.clean),	model='normal')
	}
	Keep in mind that \command{BaySha.em} is obtained from \command{seed10.clean} which has been removed of some phenotypes from \command{seed10}. Thus, the dataframe from now on corresponding to \command{BaySha.em} is always \command{seed10.clean}.
	}%end of paragraph

	%Mapping the QTL
	%\itemize{\item \bold{Mapping the QTL}}
	\subsection{Mapping the QTLs}{

	Here start the main differences with R/\pkg{qtl}. One of the major problematic steps for genome-wide expression QTL analysis, is to read all the LOD curves and sytematically define the QTLs. Because of the amount of results, it is not feasible to read the LOD curves by hand. R/\pkg{eqtl} allows to detect several QTL by chromosome with drop LOD support interval and a genetic exclusionnary window.
	%end of paragraph

	Use \command{define.peak} function to define QTL with drop LOD support interval from the scanone results, here the interval mapping results \command{BaySha.em}.

	\preformatted{
BaySha.peak <- define.peak(BaySha.em,locdolumn='all');
class(BaySha.peak);
	}

	The parameter \command{lodcolumn='all'} specifies to analyze all LOD columns (all the traits) of the scanone object \command{BaySha.em}. By using \command{lodcolumn='CATrck'}, it specifies to analyze only the the scanone LOD column \command{CATrck}, which is supposed to be the interval mapping result of the trait \command{CATrck}.

	We call \command{peak} object, the results of the \command{define.peak} function. The \command{peak} object is used to store the QTL definition. The QTL are defined by several features decribed in the \command{peak} objects attributes. At this step, a QTL is only defined by its LOD score, location and the subjective quality of the LOD peak. See \command{define.peak} function for details.

	\preformatted{attributes(BaySha.peak);}

	Within the \command{BaySha.peak} attributes, you can see the \command{"scanone"} that it record from which the \command{scanone} object the QTL was defined.
	%end of paragraph

	Back to the \command{define.peak} parameters. \command{graph=TRUE} specifies to draw the LOD curves with LOD support interval. The curves showing a QTL detected will be drawn on different charts for each chromosome. Note that, no graphical setup has been defined and therefore all graphs generated will appear one above the others. You should specify the graphical parameter \command{mfrow} of the R function \command{par()} before running \command{define.peak} to draw all charts in the same window. You may not want to set the parameters \command{graph=TRUE} and \command{lodcolumn='all'} at the same time, depending on the amount of traits analyzed.

	The following command lines is an example to define QTL and draw chart for a unique trait \command{CATrck}. Because \emph{A.~thaliana} genome contains 5 chromosomes, 5 charts will be drawn for a unique trait.

	\preformatted{
png(filename='CATrck.png',width=800,height=600);
par(mfrow=c(1,5));
define.peak(BaySha.em, lodcolumn='CATrck', graph=TRUE, chr=c(1,5));
par(mfrow=c(1,1));
dev.off();
	}

	\command{png()} and \command{dev.off()} are classical R functions which indicates here to print the graph generated as a png file \command{'CATrck.png'}. By using these functions, you can page set the graph as you would like it. By adding \command{save.pict=TRUE}, to \command{define.peak} function parameters, will systematically save all single LOD curves generated for each chromosome as png files. The files generated will be named with the names of the trait and the chromosomes where the QTLs are located. Pay attention to the amount of data you're analysing before setting the parameters \command{save.pict=TRUE} .
	%end of paragraph

	The way to access QTL results within \command{peak} object is quite simple:

	\preformatted{
BaySha.peak
BaySha.peak$CATrck
	}

	\command{BaySha.peak} will give you the \command{define.peak} results ordered by trait and chromosomes, respectively. \command{BaySha.peak\$CATrck} will give you the results for the trait \command{'CATrck'} and so on for other trait names. If no QTL had been detected for a trait, the result will be the value \command{NA}. To avoid to save all charts, I first run \command{define.peak } for all traits ( \command{lodcolumn='all'}) and save the results as a \command{peak} object. Then, when I need to check how look like the LOD curve of a specific trait, I run \command{define.peak} again on this trait by setting  \command{graph=TRUE} without saving the \command{peak} object obtained.
	}%end of paragraph

	%Defining the QTL
	%\itemize{\item \bold{Defining the QTL}}
	\subsection{Defining the QTLs}{

	To complete the QTL analysis, use the functions \command{calc.adef}, \command{localize.qtl} and \command{classify.qtl} to compute, for each QTL previously detected in \command{peak} object, the additive effect, the estimated physical location and the estimated acting-type in case of eQTL, respectively. All of these functions will add peak features to the \command{peak} object.

	\preformatted{
BaySha.peak <- localize.qtl(cross=seed10.clean, peak=BaySha.peak,
	data.gmap=BSpgmap);
BaySha.peak <- calc.adef(cross=seed10.clean, scanone=BaySha.em,
	peak=BaySha.peak);
BaySha.peak <- classify.qtl(cross=seed10.clean, peak=BaySha.peak,
	etrait.coord=ATH.coord, data.gmap=BSpgmap);
attributes(BaySha.peak);
	}

	For each of these functions you have to specify the \command{peak} object. You also need to specify the related \command{cross} object and \command{scanone} results, the related genetic map physical data \command{BSpgmap} and the expression traits  physical data \command{ATH.coord}. Note that, the expression trait physical data (here \command{ATH.coord}) may contain more traits than those studied. Conversely, all traits studied within the \command{peak}, the \command{scanone} or the \command{cross} objects must be described in \command{ATH.coord}. As you can see, the name of the cross object has been recorded in the attributes of the \command{BaySha.peak} object
	%end of paragraph

	Use \command{calc.Rsq} function to compute, from the \command{peak} object, the contribution of the individual QTLs to the phenotypic variation. At the same time this function tests and computes the contribution of significant epistatic interactions between QTLs. By default the significant threshold is set to \command{th=0.001}. In case you wanted to take all QTL interactions whatever the significance, you must set \command{th=1}.

	\preformatted{
BaySha.Rsq <- calc.Rsq(cross=seed10.clean,peak=BaySha.peak);
BaySha.Rsq;
plotRsq(rsq=BaySha.Rsq);
	}
	} %end of paragraph

	%Manipulating the results
	%\itemize{\item \bold{Manipulating the results}}
	\subsection{Manipulating the results}{

	The function \command{peak.2.array} will format all QTL results in a simple array. The column names are the names of the peak features described in \command{peak} object. This array has the class \command{peak.array}. \command{Rsq.2.array} adds the R square column to the QTL array. Formatting the results as a simple array allows the use of all basic and complex R functions (statistical, summary, graphical, histograms...) which will allow us to customize the data in the simplest way. This format also allows to write the results in a file (like text or CSV) to save out the data.

	\preformatted{
BaySha.array <- peak.2.array(BaySha.peak);
BaySha.array <- Rsq.2.array(rsq=BaySha.Rsq,BaySha.array);
	} 
	%end of paragraph

	R/\pkg{eqtl} provides useful functions that give an overview of the QTLs results stored in \command{peak.array}. The \command{peaksummary} function gives a variety of summary information and an overview of peak distribution. Summary graphs are available by setting \command{graph=TRUE}. Like \command{define.peak}, no graphical parameters had been set and therefore all graphs generated will appear one above the others in the same R graph window. You may define \command{mfrow} before running \command{peaksummary} to draw all charts in the same R window.
	%end of paragraph

	Whole QTL summary with graphs:

	\preformatted{
par(mfrow=c(3,4));
BaySha.summary <- peaksummary(BaySha.array,seed10.cleaned,graph=TRUE);
par(mfrow=c(1,1));
names(BaySha.summary);
BaySha.summary;
	}
	%end of paragraph

	QTL summary with graphs excluding QTL localized on the chromosome 3 between 5000 and 6000 bp:
	\preformatted{
par(mfrow=c(3,4));
BaySha.sum_exc <- peaksummary( BaySha.array, seed10.cleaned,
	exc=data.frame(inf=5000, sup=6000, chr=3), graph=TRUE);
par(mfrow=c(1,1));
names(BaySha.sum_exc);
BaySha.sum_exc;
	}
	%end of paragraph

	The function \command{genoplot} provides basic information and an overview about genome-wide eQTL parameters.

	\preformatted{
genoplot(BaySha.array,seed10.clean, ATH.coord, BSpgmap,
	chr.size=c(30432457, 19704536, 23470536, 18584924, 26991304),
	save.pict=TRUE);
	}

	The parameter \command{chr.size} is the size of the chromosomes in base pair (here \emph{A. thaliana}). These sizes are used to delimit the chromosomes for genome-wide graphs. For this function, the page setting has already been specified, \command{save.pict=TRUE} will save all graphs in different files within the current folder.
	} %end of paragraph

	%The composite interval mapping
	%\itemize{\item \bold{The composite interval mapping}}
	\subsection{The Composite Interval Mapping}{

	Use the function \command{cim.peak} to systematically perform composite interval mapping by running a single genome scan \command{scanone} with previously defined QTL as additives covariates. The additive covariates are defined from the \command{peak} object as the closest flanking marker of LOD peaks with the function \command{map.peak}. The \command{cim.peak} function returns an object of the \command{scanone} class and therefore can be analyzed by the \command{define.peak} function. The results can then be analyzed by \command{calc.adef}, \command{localize.qtl}, \command{calc.Rsq}, etc\dots Due to the model, the LOD curves present a high (artefactual) LOD peak at the additive covariates locations which will be incorrectly detected as a strong QTL by the \command{define.peak} function. To avoid this, use the \command{wash.covar} function which will set the LOD score at the covariates location to 0 LOD. This function takes care of a genetic window size which specifies the size of the region to \dQuote{wash}.

	\preformatted{
BaySha.cem <- cim.peak(seed10.clean,BaySha.peak);
covar <- map.peak(BaySha.peak) ;
covar;
BaySha.cem <- wash.covar(BaySha.cem, covar, window.size=20);
BaySha.cem.peak <- define.peak(BaySha.cem, lodcolumn='all');
BaySha.cem.peak <- calc.adef(cross=seed10.clean, scanone=BaySha.cem,
	peak=BaySha.cem.peak);
BaySha.cem.peak <- localize.qtl(cross=seed10.clean, peak=BaySha.cem.peak,
	data.gmap=BSpgmap);
BaySha.cem.peak <- classify.qtl(cross=seed10.clean, peak=BaySha.cem.peak,
	etrait.coord=ATH.coord, data.gmap=BSpgmap);
BaySha.cem.Rsq <- calc.Rsq(cross=seed10.clean, peak=BaySha.cem.peak);
plot.Rsq(BaySha.cem.Rsq);
BaySha.cem.array <- peak.2.array(BaySha.cem.peak);
BaySha.cem.array <- Rsq.2.array(BaySha.cem.Rsq,BaySha.cem.array);
	}

	You now have two \command{peak.array}. \command{BaySha.array} which contained the results from \acronym{IM} analysis and \command{BaySha.cem.array} which contained the results from \acronym{CIM}. You may want to merge these two \command{peak.array} in one to run the \command{genoplot} function using all QTLs from \acronym{IM} and \acronym{CIM}. Note that you may have to add manually the class \command{peak.array} to the merge array obtained.

	\preformatted{
BaySha.em.cem.array <- rbind(BaySha.em.array,BaySha.cem.array);
attributes(BaySha.em.cem.array)$class<-c("peak.array","data.frame");
	}

	} %end of paragraph
} %end of section
\author{ Hamid A Khalili, \email{hamid.khalili@gmail.com} }
\keyword{documentation}
