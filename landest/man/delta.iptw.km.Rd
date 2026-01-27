\name{delta.iptw.km}
\alias{delta.iptw.km}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Estimates survival and treatment effect using inverse probability of treatment weighted (IPTW) Kaplan-Meier estimation
}
\description{
Estimates the probability of survival past some specified time and the treatment effect, defined as the difference in survival at the specified time, using inverse probability of treatment weighted (IPTW) Kaplan-Meier estimation
}
\usage{
delta.iptw.km(tl, dl, treat, tt, var = FALSE, conf.int = FALSE, ps.weights = NULL, 
weight.perturb = NULL, perturb.ps = FALSE, cov.for.ps = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{tl}{
observed event time of primary outcome, equal to min(T, C) where T is the event time and C is the censoring time.
}
  \item{dl}{
event indicator, equal to I(T<C) where T is the event time and C is the censoring time.
}
  \item{treat}{
treatment indicator, should be 0/1.
}
  \item{tt}{
the time of interest, function estimates the probability of survival past this time	
}
  \item{var}{
TRUE or FALSE; indicates whether variance estimates for the treatment effect and survival in each group are requested, default is FALSE.
}
  \item{conf.int}{
TRUE or FALSE; indicates whether 95\% confidence intervals for the treatment effect and survival in each group are requested, default is FALSE.
}
  \item{ps.weights}{
propensity score (or inverse probability of treatment) weights
}
 \item{weight.perturb}{
a (n1+n0) by x matrix of weights where n1 = length of tl for treatment group 1 and n0 =  length of tl for treatment group 0; used for perturbation-resampling, default is null. If var or conf.int is TRUE and weight.perturb is not provided, the function generates exponential(1) weights. 
}
  \item{perturb.ps}{
TRUE or FALSE indicating whether the weight.perturb matrix includes the perturbed propensity score (or inverse probability of treatment) weights; if cov.for.ps is supplied instead of ps.weights, this is forced to be TRUE.
}
  \item{cov.for.ps}{
matrix of covariates to be used to estimate propensity score (or inverse probability of treatment) weights; either ps.weights or cov.for.ps must be supplied. 
}
}
\details{
Let  \eqn{T_{Li}} denote the time of the primary event of interest for person \eqn{i}, \eqn{C_i} denote the censoring time,  \eqn{Z_{i}} denote the vector of baseline (pretreatment) covariates, and \eqn{G_i} be the treatment group indicator such that \eqn{G_i = 1} indicates treatment and \eqn{G_i = 0} indicates control. Due to censoring, we observe \eqn{X_{Li}= min(T_{Li}, C_{i})} and \eqn{\delta_{Li} = I(T_{Li}\leq C_{i})}. This function estimates survival at time t within each treatment group, \eqn{S_j(t) = P(T_{L} > t | G = j)} for \eqn{j = 1,0} and the treatment effect defined as \eqn{\Delta(t) = S_1(t) - S_0(t)}.

The inverse probability of treatment weighted (IPTW) Kaplan-Meier (KM) estimate of survival at time t for each treatment group is 

\deqn{ \hat{S}_{IPTW,KM, j}(t) = 
       \prod _{t_{kj} \leq t} \left [1-\frac{d_{kj}^w}{y_{kj}^w}\right ]  \mbox{ if } t\geq t_{1j}, \mbox{ or } 
         1  \mbox{ if } t<t_{1j}}      
 where \eqn{t_{1j},...,t_{Dj}} are the distinct observed event times of the primary outcome in treatment group j, \eqn{d_{kj}^w = \sum_{i: X_{Li} = t_{kj}, \delta_{Li} = 1} {\hat{W}_j(Z_i)}^{-1}\delta_{Li} I(G_i = j)} and  \eqn{y_{kj}^w = \sum_{i: X_{Li}  \geq  t_{kj}} {\hat{W}_j(Z_i)}^{-1} I(G_i = j), W_j(Z_i) = {P(G_{i} = j | Z_i)}}, and \eqn{\hat{W}_j(Z_i)} is the estimated propensity score (see ps.wgt.fun for more information).  The IPTW KM estimate of treatment effect at time t is \eqn{\hat{\Delta}_{IPTW,KM}(t) = \hat{S}_{IPTW,KM, 1}(t) - \hat{S}_{IPTW,KM, 0}(t)}.
 
To obtain variance estimates and construct confidence intervals, we  use a perturbation-resampling method. Specifically, let \eqn{\{V^{(b)}=(V_1^{(b)}, . . . ,V_n^{(b)})^{T}, b=1,...B\}} be 
\eqn{n\times B} independent copies of a positive random variable U from a known distribution with unit mean and unit variance such as an Exp(1) distribution.  To estimate the variance of our estimates, we appropriately weight the estimates using these perturbation weights to obtain perturbed values: \eqn{\hat{S}_{IPTW,KM,0} (t)^{(b)}}, \eqn{\hat{S}_{IPTW,KM,1} (t)^{(b)}}, and \eqn{\hat{\Delta}_{IPTW,KM} (t)^{(b)}, b=1,...B}. We then estimate the variance of each estimate as the empirical variance of the perturbed quantities. To construct confidence intervals, one can either use the empirical percentiles of the perturbed samples  or a normal approximation.
}
\value{
A list is returned:
 \item{S.estimate.1}{the estimate of survival at the time of interest for treatment group 1, \eqn{\hat{S}_1(t) = P(T>t | G=1)}}
  \item{S.estimate.0}{the estimate of survival at the time of interest for treatment group 0, \eqn{\hat{S}_0(t) = P(T>t | G=0)}}
   \item{delta.estimate}{the estimate of treatment effect at the time of interest}
 \item{S.var.1 }{the variance estimate of \eqn{\hat{S}_1(t)}; if var = TRUE or conf.int = TRUE}
 \item{S.var.0 }{the variance estimate of \eqn{\hat{S}_0(t)}; if var = TRUE or conf.int = TRUE}
 \item{delta.var}{the variance estimate of \eqn{\hat{\Delta}(t)}; if var = TRUE or conf.int = TRUE}
 \item{p.value}{the p-value from testing \eqn{\Delta(t) = 0}; if var = TRUE or conf.int = TRUE}
 \item{conf.int.normal.S.1}{a vector of size 2; the 95\% confidence interval for \eqn{\hat{S}_1(t)} based on a normal approximation; if conf.int = TRUE}
 \item{conf.int.normal.S.0}{a vector of size 2; the 95\% confidence interval for \eqn{\hat{S}_0(t)} based on a normal approximation; if conf.int = TRUE}
 \item{conf.int.normal.delta}{a vector of size 2; the 95\% confidence interval for \eqn{\hat{\Delta}(t)} based on a normal approximation; if conf.int = TRUE}
 \item{conf.int.quantile.S.1}{a vector of size 2; the 95\% confidence interval for \eqn{\hat{S}_1(t)} based on sample quantiles of the perturbed values, described above; if conf.int = TRUE} 
\item{conf.int.quantile.S.0}{a vector of size 2; the 95\% confidence interval for \eqn{\hat{S}_0(t)} based on sample quantiles of the perturbed values, described above; if conf.int = TRUE} 
\item{conf.int.quantile.delta}{a vector of size 2; the 95\% confidence interval for \eqn{\hat{\Delta}(t)} based on sample quantiles of the perturbed values, described above; if conf.int = TRUE} 
}
\references{
Xie, J., & Liu, C. (2005). Adjusted Kaplan-Meier estimator and log-rank test with inverse probability of treatment weighting for survival data. Statistics in Medicine, 24(20), 3089-3110.

Rosenbaum, P. R., & Rubin, D. B. (1983). The central role of the propensity score in observational studies for causal effects. Biometrika, 70(1), 41-55.

Rosenbaum, P. R., & Rubin, D. B. (1984). Reducing bias in observational studies using subclassification on the propensity score. Journal of the American Statistical Association, 79(387), 516-524.

}
\author{
Layla Parast
}

\examples{
data(example_obs)
W.weight = ps.wgt.fun(treat = example_obs$treat, cov.for.ps = as.matrix(example_obs$Z))	
delta.iptw.km(tl=example_obs$TL, dl = example_obs$DL, treat = example_obs$treat, tt=2, 
ps.weights = W.weight) 
delta.iptw.km(tl=example_obs$TL, dl = example_obs$DL, treat = example_obs$treat, tt=2,
cov.for.ps = as.matrix(example_obs$Z)) 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{survival}
\keyword{nonparametric}
\keyword{robust}
