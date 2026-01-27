\name{ps.wgt.fun}
\alias{ps.wgt.fun}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Calculates propensity score weights}
\description{
Calculates propensity score (or inverse probability of treatment) weights given the treatment indicator and available baseline (pretreatment) covariates.}
\usage{
ps.wgt.fun(treat, cov.for.ps, weight = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{treat}{
treatment indicator, should be 0/1.}
  \item{cov.for.ps}{
matrix of covariates to be used to estimate propensity score (or inverse probability of treatment) weights
}
  \item{weight}{
a (n1+n0) by x matrix of weights where n1 = number of observations in treatment group 1 and n0 =  number of observations in treatment group 0; used for perturbation-resampling, default is null.
}
}
\details{
Let \eqn{Z_{i}} denote the matrix of baseline (pretreatment) covariates and \eqn{G_i} be the treatment group indicator such that \eqn{G_i = 1} indicates treatment and \eqn{G_i = 0} indicates control. This function estimates \eqn{P = P(G_i = 1 | Z_i)} using logistic regression. The propensity score (or inverse probability of treatment) weights are then equal to \eqn{1/\hat{P}} for those in treatment group 1 and \eqn{1/(1-\hat{P})} for those in treatment group 0. These weights reflect the situation where the average treatment effect (ATE) is of interest, not average treatment effect in the treated (ATT).}
\value{
propensity score (or inverse probability of treatment) weights
}
\references{
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
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{regression}
\keyword{nonlinear}
