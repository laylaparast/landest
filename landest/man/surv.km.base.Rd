\name{surv.km.base}
\alias{surv.km.base}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Estimates survival using Kaplan-Meier estimation
}
\description{
Estimates the probability of survival past some specified time using Kaplan-Meier estimation
}
\usage{
surv.km.base(tl, dl, tt, weight.perturb = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{tl}{
observed event time of primary outcome, equal to min(T, C) where T is the event time and C is the censoring time.
}
  \item{dl}{
event indicator, equal to I(T<C) where T is the event time and C is the censoring time.
}
  \item{tt}{
the time of interest, function estimates the probability of survival past this time	
}
  \item{weight.perturb}{
 an optional weight matrix to be incorporated in estimation.

}
}

\value{
estimate of survival at the specified time
}

\author{
Layla Parast
}

\keyword{internal}
\keyword{survival}
\keyword{nonparametric}