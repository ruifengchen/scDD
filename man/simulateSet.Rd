% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Simulate_set.R
\name{simulateSet}
\alias{simulateSet}
\title{simulateSet}
\usage{
simulateSet(SCdat, numSamples = 100, nDE = 250, nDP = 250, nDM = 250,
  nDB = 250, nEE = 5000, nEP = 4000, sd.range = c(1, 3), modeFC = c(2,
  3, 4), plots = TRUE, plot.file = NULL, random.seed = 284,
  varInflation = NULL, condition = "condition")
}
\arguments{
\item{SCdat}{An object of class \code{ExpressionSet} that contains normalized single-cell expression and metadata, where the \code{assayData} 
slot contains one row for each gene and one sample for each column.  The \code{PhenoData} slot should contain a vector of numeric values
(either 1 or 2) that indicates which 
condition each sample belongs to (in the same order as the columns of \code{assayData}).  Optional additional metadata about the 
experiment can be contained in the \code{experimentData} slot.}

\item{numSamples}{numeric value for the number of samples in each condition to simulate}

\item{nDE}{Number of DE genes to simulate}

\item{nDP}{Number of DP genes to simulate}

\item{nDM}{Number of DM genes to simulate}

\item{nDB}{Number of DB genes to simulate}

\item{nEE}{Number of EE genes to simulate}

\item{nEP}{Number of EP genes to simulate}

\item{sd.range}{Numeric vector of length two which describes the interval (lower, upper) of standard deviations
of fold changes to randomly select.}

\item{modeFC}{Vector of values to use for fold changes between modes for DP, DM, and DB.}

\item{plots}{Logical indicating whether or not to generate fold change and validation plots}

\item{plot.file}{Character containing the file string if the plots are to be sent to a pdf instead of to the standard output.}

\item{random.seed}{Numeric value for a call to \code{set.seed} for reproducibility.}

\item{varInflation}{Optional numeric vector with one element for each condition that corresponds to the multiplicative 
variance inflation factor to use when simulating data.  Useful for sensitivity studies to assess the impact of 
confounding effects on differential variance across conditions. Currently assumes all samples within a 
condition are subject to the same variance inflation factor.}

\item{condition}{A character object that contains the name of the column in \code{phenoData} that represents 
the biological group or condition of interest (e.g. treatment versus control).  Note that this variable should only contain two 
possible values since \code{scDD} can currently only handle two-group comparisons.  The default option assumes that there
is a column named "condition" that contains this variable.}
}
\value{
A named list of two items: the first (labeled 'Simulated_Data') is a matrix of simulated 
  data with \code{numSamples} columns and \code{nDE + nDP + nDM + nDB + nEE + nEP} rows 
  (total number of genes).  The second item (named 'FC') is a vector of the number of standard 
  deviations used for fold changes. For DE genes, this value is computed from the sampled fold
  changes obtained from \code{\link{findFC}}.  For DP, DM, DB, and EP genes, this is one of the 
  values in \code{modeFC}.  For EE genes, this value is \code{NA}.
}
\description{
Simulation of a complete dataset, where the number of each type of differential distributions and equivalent distributions is specified.
}
\examples{

# Load toy example ExpressionSet to simulate from

data(scDatEx)


# check that this object is a member of the ExpressionSet class
# and that it contains 142 samples and 500 genes

class(scDatEx)
show(scDatEx)


# set arguments to pass to simulateSet function
# we will simuate 30 genes total; 5 genes of each type;
# and 100 samples in each of two conditions

nDE <- 5
nDP <- 5
nDM <- 5
nDB <- 5
nEE <- 5
nEP <- 5
numSamples <- 100
seed <- 816


# create simulated set with specified numbers of DE, DP, DM, DM, EE, and EP genes,
# specified number of samples, DE genes are 2 standard deviations apart, and 
# multimodal genes have modal distance of 4 standard deviations

SD <- simulateSet(scDatEx, numSamples=numSamples, nDE=nDE, nDP=nDP, nDM=nDM, nDB=nDB, 
                  nEE=nEE, nEP=nEP, sd.range=c(2,2), modeFC=4, plots=FALSE, 
                  random.seed=seed)
                  
                  
# convert the simulated data object returned by simulateSet into an ExpressionSet object

library(Biobase)   # needed to create and instance of the ExpressionSet class
condition <- c(rep(1, numSamples), rep(2, numSamples))
rownames(SD[[1]]) <- paste0(rownames(SD[[1]]), 1:nrow(SD[[1]]), sep="")
colnames(SD[[1]]) <- names(condition) <- paste0("Sample", 1:ncol(SD[[1]]), sep="")
SDExpressionSet <- ExpressionSet(assayData=SD[[1]], 
                     phenoData=as(data.frame(condition), "AnnotatedDataFrame"))
}

