% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/classify.dd.R
\name{testZeroes}
\alias{testZeroes}
\title{testZeroes}
\usage{
testZeroes(dat, cond, these = 1:nrow(dat))
}
\arguments{
\item{dat}{Matrix of single cell expression data with genes in rows and samples in columns.}

\item{cond}{Vector of condition labels}

\item{these}{vector of row numbers (gene numbers) to test for a difference in the proportion of zeroes.}
}
\value{
Vector of FDR adjusted p-values
}
\description{
Test for a difference in the proportion of zeroes between conditions for a specified set of genes
}
\details{
Test for a difference in the proportion of zeroes between conditions that is not explained by the 
  detection rate.  Utilizes Bayesian logistic regression.
}

