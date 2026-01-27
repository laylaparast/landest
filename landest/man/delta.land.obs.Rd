\name{delta.land.obs}
\alias{delta.land.obs}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Estimates survival and treatment effect using landmark estimation
}
\description{
Estimates the probability of survival past some specified time and the treatment effect, defined as the difference in survival at the specified time, using landmark estimation for an observational study setting
}
\usage{
delta.land.obs(tl, dl, treat, tt, landmark, short = NULL, z.cov = NULL, 
var = FALSE, conf.int = FALSE, ps.weights = NULL, weight.perturb = NULL, 
perturb.ps = FALSE, cov.for.ps = NULL, bw = NULL)
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
  \item{landmark}{
the landmark time
}
  \item{short}{
a matrix of intermediate event information, there should be two columns for each intermediate event, the first column contains the observed intermediate event time, equal to min(TS, C) where TS is the event time and C is the censoring time, and the second column contains the event indicator, equal to I(TS<C)}
  \item{z.cov}{
matrix of baseline covariate information
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
  \item{bw}{
bandwidth used for kernel estimation, default is NULL
}
}
\details{
Let  \eqn{T_{Li}} denote the time of the primary event of interest for person \eqn{i}, \eqn{T_{Si}} denote the time of the available intermediate event(s), \eqn{C_i} denote the censoring time, \eqn{Z_{i}} denote the vector of baseline (pretreatment) covariates, and \eqn{G_i} be the treatment group indicator such that \eqn{G_i = 1} indicates treatment and \eqn{G_i = 0} indicates control. Due to censoring, we observe \eqn{X_{Li}= min(T_{Li}, C_{i})} and \eqn{\delta_{Li} = I(T_{Li}\leq C_{i})} and \eqn{X_{Si}= min(T_{Si}, C_{i})} and \eqn{\delta_{Si} = I(T_{Si}\leq C_{i})}. This function estimates survival at time t within each treatment group, \eqn{S_j(t) = P(T_{L} > t | G = j)} for \eqn{j = 1,0} and the treatment effect defined as \eqn{\Delta(t) = S_1(t) - S_0(t)}.

To derive these estimates using landmark estimation for an observational study setting, we first decompose the quantity into two components \eqn{S_j (t)= S_j(t|t_0) S_j(t_0)} using a landmark time \eqn{t_0} and estimate each component separately incorporating inverse probability of treatment weights (IPTW) to account for potential selection bias. Let \eqn{W_j(Z_i) = {P(G_{i} = j | Z_i)}}, and \eqn{\hat{W}_j(Z_i)} be the estimated propensity score (or probability of treatment, see ps.wgt.fun for more information). In this presentation, we assume \eqn{Z_i} indicates the vector of baseline (pretreatment) covariates and that \eqn{Z_i} is used to estimate the propensity scores and incorporated into the survival and treatment effect estimation. However, the function allows one to use different subsets of \eqn{Z_i} for the propensity score estimation vs. survival estimation, as is appropriate in the setting of interest. Intermediate event information is used in estimation of the conditional component \eqn{S_j(t|t_0)}, 
\deqn{S_j(t|t_0)= P(T_L>t |T_L> t_0,G=j)=E[E[I(T_L>t | T_L> t_0,G=j,H)]]=E[S_{j,H} (t|t_0)]}
where \eqn{S_{j,H}(t|t_0) = P(T_L>t | T_L> t_0,G=j,H)} and \eqn{H = \{Z, I(T_S \leq t_0), min(T_S, t_0) \}.} Then \eqn{S_{j,H}(t|t_0)} is estimated in two stages. The first stage involves fitting a weighted Cox proportional hazards model  among individuals with \eqn{X_L> t_0} to obtain an estimate of \eqn{\beta}, denoted as \eqn{\hat{\beta}}, \deqn{S_{j,H}(t|t_0)=\exp \{-\Lambda_{j,0} (t|t_0) \exp(\beta^{T} H) \} }
where \eqn{\Lambda_{j,0} (t|t_0)} is the cumulative baseline hazard in group \eqn{j}. Specifically,  \eqn{\hat{\beta}} is the solution to the weighted Cox partial likelhoodand, with weights \eqn{\hat{W}_j(Z_i)^{-1}}. The second stage uses a weighted nonparametric kernel Nelson-Aalen estimator to obtain a local constant estimator for the conditional hazard \eqn{\Lambda_{j,u}(t|t_0) = -\log [S_{j,u}(t|t_0)]} as 
\deqn{\hat{\Lambda}_{j,u}(t|t_0) = \int_{t_0}^t \frac{\sum_i \hat{W}_j(Z_i)^{-1} K_h(\hat{U}_i - u) dN_i(z)}{\sum_i \hat{W}_j(Z_i)^{-1} K_h(\hat{U}_i - u) Y_i(z)}}
where \eqn{S_{j,u}(t|t_0)=P(T_L>t | T_L> t_0,G=j,\hat{U}=u), \hat{U} = \hat{\beta}^{T} H, Y_i(t)=I(T_L \geq t),N_i (t)=I(T_L\leq t)I(T_L<C),K(\cdot)} is a smooth symmetric density function, \eqn{K_h (x/h)/h},  \eqn{h=O(n^{-v})} is a bandwidth with \eqn{1/2 > v > 1/4}, and the summation is over all individuals with \eqn{G=j} and \eqn{X_L>t_0}.  The resulting estimate for \eqn{S_{j,u}(t|t_0)} is \eqn{\hat{S}_{j,u}(t|t_0) = \exp \{-\hat{\Lambda}_{j,u}(t|t_0)\}}, and the final estimate \deqn{\hat{S}_j(t|t_0) = \frac{n^{-1} \sum_{i =1}^n   \hat{W}_j(Z_i)^{-1} \hat{S}_j(t|t_0, H_i) I(G_i=1)I(X_{Li} > t_0)}{n^{-1} \sum_{i =1}^n  \hat{W}_j(Z_i)^{-1} I(G_i=1)I(X_{Li} > t_0) }}
is a consistent estimate of \eqn{S_j(t|t_0)}.

	
Estimation of \eqn{S_j(t_0)} uses a similar two-stage approach but using only baseline covariates, to obtain  \eqn{\hat{S}_j(t_0)}. The final overall estimate of survival at time \eqn{t} is, \eqn{\hat{S}_{LM,j} (t)=  \hat{S}_j(t|t_0) \hat{S}_j(t_0)}. The treatment effect in terms of the difference in survival at time \eqn{t} is estimated as \eqn{\hat{\Delta}_{LM}(t) = \hat{S}_{LM,1}(t) - \hat{S}_{LM,0}(t).}   To obtain an appropriate \eqn{h} we first use the bandwidth selection procedure given by Scott(1992) to obtain \eqn{h_{opt}}; and then we let \eqn{h = h_{opt}n_j^{-0.10}}. 


To obtain variance estimates and construct confidence intervals, we  use a perturbation-resampling method. Specifically, let \eqn{\{V^{(b)}=(V_1^{(b)}, . . . ,V_n^{(b)})^{T}, b=1,...B\}} be 
\eqn{n\times B} independent copies of a positive random variable U from a known distribution with unit mean and unit variance such as an Exp(1) distribution.  To estimate the variance of our estimates, we appropriately weight the estimates using these perturbation weights to obtain perturbed values: \eqn{\hat{S}_{LM,0} (t)^{(b)}}, \eqn{\hat{S}_{LM,1} (t)^{(b)}}, and \eqn{\hat{\Delta}_{LM} (t)^{(b)}, b=1,...B}. We then estimate the variance of each estimate as the empirical variance of the perturbed quantities. To construct confidence intervals, one can either use the empirical percentiles of the perturbed samples  or a normal approximation.


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
Parast, L. & Griffin B.A. (2017). Landmark Estimation of Survival and Treatment Effects in Observational Studies. Lifetime Data Analysis, 23:161-182.

Rosenbaum, P. R., & Rubin, D. B. (1983). The central role of the propensity score in observational studies for causal effects. Biometrika, 70(1), 41-55.

Rosenbaum, P. R., & Rubin, D. B. (1984). Reducing bias in observational studies using subclassification on the propensity score. Journal of the American Statistical Association, 79(387), 516-524.
}
\author{
Layla Parast
}
\examples{
data(example_obs)
W.weight = ps.wgt.fun(treat = example_obs$treat, cov.for.ps = as.matrix(example_obs$Z))	
#executable but takes time
#delta.land.obs(tl=example_obs$TL, dl = example_obs$DL, treat = example_obs$treat, tt=2, 
#landmark = 1, short = cbind(example_obs$TS,example_obs$DS), z.cov = as.matrix(example_obs$Z),
#ps.weights = W.weight)
#delta.land.obs(tl=example_obs$TL, dl = example_obs$DL, treat = example_obs$treat, tt=2, 
#landmark = 1, short = cbind(example_obs$TS,example_obs$DS), z.cov = as.matrix(example_obs$Z),
#cov.for.ps = as.matrix(example_obs$Z))

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{survival}
\keyword{nonparametric}
\keyword{robust}
