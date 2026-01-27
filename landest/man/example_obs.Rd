\name{example_obs}
\alias{example_obs}
\docType{data}
\title{
Hypothetical data from an observational study
}
\description{
Hypothetical data from an observational study to be used in examples.
}
\usage{data(example_obs)}
\format{
  A data frame with 4000 observations on the following 6 variables.
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
data(example_obs)
names(example_obs)
}
\keyword{datasets}
