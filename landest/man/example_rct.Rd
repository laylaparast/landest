\name{example_rct}
\alias{example_rct}
\docType{data}
\title{
Hypothetical data from a randomized trial
}
\description{
Hypothetical data from a randomized trial to be used in examples.
}
\usage{data(example_rct)}
\format{
  A data frame with 3000 observations on the following 6 variables.
  \describe{
    \item{\code{TL}}{the observed event or censoring time for the primary outcome, equal to min(T, C) where T is the time of the primary outcome and C is the censoring time.}
    \item{\code{DL}}{the indicator telling whether the individual was observed to have the event or was censored, equal to 1*(T<C) where T is the time of the primary outcome and C is the censoring time.}
    \item{\code{TS}}{the observed event or censoring time for the intermediate event, equal to min(TS, C) where TS is the time of the intermediate event and C is the censoring time.}
    \item{\code{DS}}{the indicator telling whether the individual was observed to have the intermediate event or was censored, equal to 1*(TS<C) where TS is the time of the primary outcome and C is the censoring time.}
    \item{\code{Z}}{a baseline covariate vector}
    \item{\code{treat}}{treatment indicator}
  }
}
\examples{
data(example_rct)
names(example_rct)
}
\keyword{datasets}

