% File src/library/base/man/by.Rd
% Part of the R package, https://www.R-project.org
% Copyright 1995-2014 R Core Team
% Distributed under GPL 2 or later

\name{by}
\alias{by}
\alias{by.default}
\alias{by.data.frame}
\alias{print.by}
\title{Apply a Function to a Data Frame Split by Factors}
\description{
  Function \code{by} is an object-oriented wrapper for
  \code{\link{tapply}} applied to data frames.
}
\usage{
by(data, INDICES, FUN, \dots, simplify = TRUE)
}
\arguments{
 \item{data}{an \R object, normally a data frame, possibly a matrix.}
 \item{INDICES}{a factor or a list of factors, each of length
   \code{nrow(data)}. For the data frame method, \code{INDICES} can also
   be a formula as in the \code{f} argument of the \code{\link{split}}
   method for data frames.}
 \item{FUN}{a function to be applied to (usually data-frame) subsets of
   \code{data}.}
 \item{\dots}{further arguments to \code{FUN}.}
 \item{simplify}{logical: see \code{\link{tapply}}.}
}
\details{
  A data frame is split by row into data frames
  subsetted by the values of one or more factors, and function
  \code{FUN} is applied to each subset in turn.

  For the default method, an object with dimensions (e.g., a matrix) is
  coerced to a data frame and the data frame method applied.  Other
  objects are also coerced to a data frame, but \code{FUN} is applied
  separately to (subsets of) each column of the data frame.
}
\value{
  An object of class \code{"by"}, giving the results for each subset.
  This is always a list if \code{simplify} is false, otherwise a list or
  array (see \code{\link{tapply}}).
}
\seealso{\code{\link{tapply}}, \code{\link{simplify2array}}.
  \code{\link{array2DF}} to convert result to a data
  frame. \code{\link{ave}} also applies a function block-wise.
}
\examples{
require(stats)
by(warpbreaks[, 1:2], warpbreaks[,"tension"], summary)
by(warpbreaks[, 1],   warpbreaks[, -1],       summary)
by(warpbreaks, warpbreaks[,"tension"],
   function(x) lm(breaks ~ wool, data = x))

## now suppose we want to extract the coefficients by group
tmp1 <- with(warpbreaks,
            by(warpbreaks, tension,
               function(x) lm(breaks ~ wool, data = x)))
sapply(tmp1, coef)

## another way
tmp2 <- by(warpbreaks, ~ tension,
           with, coef(lm(breaks ~ wool)))
array2DF(tmp2, simplify = TRUE)
}
\keyword{iteration}
\keyword{category}
