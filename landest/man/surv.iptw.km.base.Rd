\name{surv.iptw.km.base}
\alias{surv.iptw.km.base}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Estimates survival using inverse probability of treatment weighted (IPTW) Kaplan-Meier estimation

}
\description{
Estimates the probability of survival past some specified time using inverse probability of treatment weighted (IPTW) Kaplan-Meier estimation
}
\usage{
surv.iptw.km.base(tl, dl, tt, ps.weights, weight.perturb = NULL, perturb.ps = FALSE)
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
  \item{ps.weights}{
propensity score (or inverse probability of treatment) weights
}
  \item{weight.perturb}{
 an optional weight matrix to be incorporated in estimation.
}
  \item{perturb.ps}{
TRUE or FALSE indicating whether the weight.perturb matrix includes the perturbed propensity score (or inverse probability of treatment) weights
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