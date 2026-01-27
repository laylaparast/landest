\name{delta.land.rct}
\alias{delta.land.rct}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Estimates survival and treatment effect using landmark estimation
}
\description{
Estimates the probability of survival past some specified time and the treatment effect, defined as the difference in survival at the specified time, using landmark estimation for a randomized trial setting
}
\usage{
delta.land.rct(tl, dl, treat, tt, landmark, short = NULL, z.cov = NULL, 
var = FALSE, conf.int = FALSE, weight.perturb = NULL, bw = NULL)
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
  \item{weight.perturb}{
a (n1+n0) by x matrix of weights where n1 = length of tl for treatment group 1 and n0 =  length of tl for treatment group 0; used for perturbation-resampling, default is null. If var or conf.int is TRUE and weight.perturb is not provided, the function generates exponential(1) weights. 
}
  \item{bw}{
bandwidth used for kernel estimation, default is NULL
}
}
\details{
Let  \eqn{T_{Li}} denote the time of the primary event of interest for person \eqn{i}, \eqn{T_{Si}} denote the time of the available intermediate event(s), \eqn{C_i} denote the censoring time, \eqn{Z_{i}} denote the vector of baseline (pretreatment) covariates, and \eqn{G_i} be the treatment group indicator such that \eqn{G_i = 1} indicates treatment and \eqn{G_i = 0} indicates control. Due to censoring, we observe \eqn{X_{Li}= min(T_{Li}, C_{i})} and \eqn{\delta_{Li} = I(T_{Li}\leq C_{i})} and \eqn{X_{Si}= min(T_{Si}, C_{i})} and \eqn{\delta_{Si} = I(T_{Si}\leq C_{i})}. This function estimates survival at time t within each treatment group, \eqn{S_j(t) = P(T_{L} > t | G = j)} for \eqn{j = 1,0} and the treatment effect defined as \eqn{\Delta(t) = S_1(t) - S_0(t)}.

To derive these estimates using landmark estimation, we first decompose the quantity into two components \eqn{S_j (t)= S_j(t|t_0) S_j(t_0)} using a landmark time \eqn{t_0} and estimate each component separately. Intermediate event information is used in estimation of the conditional component \eqn{S_j(t|t_0)}, 
\deqn{S_j(t|t_0)= P(T_L>t |T_L> t_0,G=j)=E[E[I(T_L>t | T_L> t_0,G=j,H)]]=E[S_{j,H} (t|t_0)]}
where \eqn{S_{j,H}(t|t_0) = P(T_L>t | T_L> t_0,G=j,H)} and \eqn{H = \{Z, I(T_S \leq t_0), min(T_S, t_0) \}.} Then \eqn{S_{j,H}(t|t_0)} is estimated in two stages: 1) fitting the Cox proportional hazards model  among individuals with \eqn{X_L> t_0} to obtain an estimate of \eqn{\beta}, denoted as \eqn{\hat{\beta}}, \deqn{S_{j,H}(t|t_0)=\exp \{-\Lambda_{j,0} (t|t_0) \exp(\beta^{T} H) \} }
where \eqn{\Lambda_{j,0} (t|t_0)} is the cumulative baseline hazard in group \eqn{j} and then 2) using a nonparametric kernel Nelson-Aalen estimator to obtain a local constant estimator for the conditional hazard \eqn{\Lambda_{j,u}(t|t_0) = -\log [S_{j,u}(t|t_0)]} as 
\deqn{\hat{\Lambda}_{j,u}(t|t_0) = \int_{t_0}^t \frac{\sum_i K_h(\hat{U}_i - u) dN_i(z)}{\sum_i K_h(\hat{U}_i - u) Y_i(z)}}
where \eqn{S_{j,u}(t|t_0)=P(T_L>t | T_L> t_0,G=j,\hat{U}=u), \hat{U} = \hat{\beta}^{T} H, Y_i(t)=I(T_L \geq t),N_i (t)=I(T_L\leq t)I(T_L<C),K(\cdot)} is a smooth symmetric density function, \eqn{K_h (x/h)/h},  \eqn{h=O(n^{-v})} is a bandwidth with \eqn{1/2 > v > 1/4}, and the summation is over all individuals with \eqn{G=j} and \eqn{X_L>t_0}.  The resulting estimate for \eqn{S_{j,u}(t|t_0)} is \eqn{\hat{S}_{j,u}(t|t_0) = \exp \{-\hat{\Lambda}_{j,u}(t|t_0)\}}, and the final estimate \deqn{\hat{S}_j(t|t_0) =\frac{n^{-1} \sum_{i =1}^n  \hat{S}_j(t|t_0, H_i) I(G_i=1)I(X_{Li} > t_0)}{n^{-1} \sum_{i =1}^n  I(G_i=1)I(X_{Li} > t_0) }} is a consistent estimate of \eqn{S_j(t|t_0)}.


	
Estimation of \eqn{S_j(t_0)} uses a similar two-stage approach but using only baseline covariates, to obtain  \eqn{\hat{S}_j(t_0)}. The final overall estimate of survival at time \eqn{t} is, \eqn{\hat{S}_{LM,j} (t)=  \hat{S}_j(t|t_0) \hat{S}_j(t_0)}. The treatment effect in terms of the difference in survival at time \eqn{t} is estimated as \eqn{\hat{\Delta}_{LM}(t) = \hat{S}_{LM,1}(t) - \hat{S}_{LM,0}(t).}   To obtain an appropriate \eqn{h} we first use the bandwidth selection procedure given by Scott(1992) to obtain \eqn{h_{opt}}; and then we let \eqn{h = h_{opt}n^{-0.10}}. 


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
Parast, L., Tian, L., & Cai, T. (2014). Landmark Estimation of Survival and Treatment Effect in a Randomized Clinical Trial. Journal of the American Statistical Association, 109(505), 384-394.

Beran, R. (1981). Nonparametric regression with randomly censored survival data. Technical report, University of California Berkeley.

Scott, D. (1992). Multivariate density estimation. Wiley.

}
\author{
Layla Parast
}
\examples{
data(example_rct)
#executable but takes time
#delta.land.rct(tl=example_rct$TL, dl = example_rct$DL, treat = example_rct$treat, tt=2, 
#landmark = 1, short = cbind(example_rct$TS,example_rct$DS), z.cov = as.matrix(example_rct$Z))

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{survival}
\keyword{nonparametric}
\keyword{robust}
