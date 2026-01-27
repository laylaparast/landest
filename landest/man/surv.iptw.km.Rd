\name{surv.iptw.km}
\alias{surv.iptw.km}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Estimates survival using inverse probability of treatment weighted (IPTW) Kaplan-Meier estimation
}
\description{
Estimates the probability of survival past some specified time using inverse probability of treatment weighted (IPTW) Kaplan-Meier estimation
}
\usage{
surv.iptw.km(tl, dl, tt, var = FALSE, conf.int = FALSE, ps.weights, 
weight.perturb = NULL,perturb.ps = FALSE, perturb.vector = FALSE)
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
  \item{var}{
TRUE or FALSE; indicates whether a variance estimate for survival is requested, default is FALSE.
}
  \item{conf.int}{
TRUE or FALSE; indicates whether a 95\% confidence interval for survival is requested, default is FALSE.
}
  \item{ps.weights}{
propensity score (or inverse probability of treatment) weights
}
  \item{weight.perturb}{
a n by x matrix of weights where n = length of tl; used for perturbation-resampling, default is null. If var or conf.int is TRUE and weight.perturb is not provided, the function generates exponential(1) weights. 
}
  \item{perturb.ps}{
TRUE or FALSE indicating whether the weight.perturb matrix includes the perturbed propensity score (or inverse probability of treatment) weights
}
  \item{perturb.vector}{
TRUE or FALSE; indicates whether a vector of the perturbed values of the survival estimate is requested, default is FALSE. This argument is ignored if both var and conf.int are FALSE. }
}
\details{
See documentation for delta.iptw.km for details.}
\value{
A list is returned:
 \item{S.estimate}{the estimate of survival at the time of interest, \eqn{\hat{S}(t) = P(T>t)}}
 \item{S.var }{the variance estimate of \eqn{\hat{S}(t)}; if var = TRUE or conf.int = TRUE}
 \item{conf.int.normal.S}{a vector of size 2; the 95\% confidence interval for \eqn{\hat{S}(t)} based on a normal approximation; if conf.int = TRUE}
 \item{conf.int.quantile.S}{a vector of size 2; the 95\% confidence interval for \eqn{\hat{S}(t)} based on sample quantiles of the perturbed values, described above; if conf.int = TRUE} 
\item{perturb.vector}{a vector of size x where x is the number of columns of the provided weight.perturb matrix (or x=500 if weight.perturb is not provided); the perturbed values of \eqn{\hat{S}(t)}; if perturb.vector = TRUE and either var=TRUE or conf.int = TRUE}
}
\references{
Xie, J., & Liu, C. (2005). Adjusted Kaplan-Meier estimator and log-rank test with inverse probability of treatment weighting for survival data. Statistics in Medicine, 24(20), 3089-3110.
}
\author{
Layla Parast
}

\examples{
data(example_obs)
W.weight = ps.wgt.fun(treat = example_obs$treat, cov.for.ps = as.matrix(example_obs$Z))	
example_obs.treat = example_obs[example_obs$treat == 1,]
surv.iptw.km(tl=example_obs.treat$TL, dl = example_obs.treat$DL, tt=2, ps.weights = 
W.weight[example_obs$treat == 1]) 
}
\keyword{survival}
\keyword{nonparametric}
\keyword{robust}
