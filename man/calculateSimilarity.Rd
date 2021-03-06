% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculateSimilarity.R
\name{calculateSimilarity}
\alias{calculateSimilarity}
\title{calculate hamming distance between samples}
\usage{
calculateSimilarity(hla_data)
}
\arguments{
\item{hla_data}{data frame with allele data}
}
\value{
TODO
}
\description{
Takes the parsed hla database and computes the hamming distance
for each pair of samples
}
\examples{

## Load example dataset
data(example_calculateSimilarity)

## Calculate similarity metrics
#calculateSimilarity(example_calculateSimilarity)

}
