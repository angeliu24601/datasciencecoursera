#' 1. A pharmaceutical company is interested in testing a potential blood 
#' pressure lowering medication. Their first examination considers only subjects 
#' that received the medication at baseline then two weeks later. The data are 
#' as follows (SBP in mmHg)
#' 
#' |Subject  |Baseline |Week2 |
#' ===========================
#' |1        |140      |132   |
#' |2        |138      |135   |
#' |3        |150      |151   |
#' |4        |148      |146   |
#' |5        |135      |130   |
#' 
#' Consider testing the hypothesis that there was a mean reduction in blood 
#' pressure? Give the P-value for the associated two sided T test.
baseline <- c(140, 138, 150, 148, 135)
week2 <- c(132, 135, 151, 146, 130)
ans1 <- t.test(baseline, week2, paired = T)$p.value
ans <- list(ans1 = ans1)
rm(list = setdiff(ls(), "ans"))

#' 2. A sample of 9 men yielded a sample average brain volume of 1,100cc and a 
#' standard deviation of 30cc. What is the complete set of values of μ0 that a 
#' test of H0:μ=μ0 would fail to reject the null hypothesis in a two sided 5% 
#' Students t-test?
avg <- 1100; sd <- 30; s <- 9
ans2 <- avg + c(1, -1)*qt(0.025, s-1)*sd/sqrt(s)
ans <- c(ans, ans2 = list(ans2))
rm(list = setdiff(ls(), "ans"))

#' 3. Researchers conducted a blind taste test of Coke versus Pepsi. Each of 
#' four people was asked which of two blinded drinks given in random order that
#' they preferred. The data was such that 3 of the 4 people chose Coke. 
#' Assuming that this sample is representative, report a P-value for a test of 
#' the hypothesis that Coke is preferred to Pepsi using a one sided exact test.
ans3 <- binom.test(x = 3, n = 4, alternative = "greater")$p.value #Approach it as a binomial test
ans <- c(ans, ans3 = list(ans3))
rm(list = setdiff(ls(), "ans"))

#' 4. Infection rates at a hospital above 1 infection per 100 person days at 
#' risk are believed to be too high and are used as a benchmark. A hospital that
#' had previously been above the benchmark recently had 10 infections over the 
#' last 1,787 person days at risk. About what is the one sided P-value for the 
#' relevant test of whether the hospital is *below* the standard?
ans4 <-poisson.test(10, 1787, 1/100, alternative = "less")$p.value
ans <- c(ans, ans4 = list(ans4))
rm(list = setdiff(ls(), "ans"))

#' 5. Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill
#' and a placebo. Subjects’ body mass indices (BMIs) were measured at a baseline
#' and again after having received the treatment or placebo for four weeks. 
#' The average difference from follow-up to the baseline (followup - baseline) 
#' was −3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. The 
#' corresponding standard deviations of the differences was 1.5 kg/m2 for the 
#' treatment group and 1.8 kg/m2 for the placebo group. Does the change in BMI 
#' appear to differ between the treated and placebo groups? Assuming normality 
#' of the underlying data and a common population variance, give a pvalue for a 
#' two sided t test.
s <- 9;avg.tr <- -3; avg.pl <- 1; sd.tr <- 1.5; sd.pl <- 1.8
se <- sqrt(sd.tr^2/s + sd.pl^2/s)
tstatis <- (avg.tr - avg.pl)/se
p <- pt(tstatis, df = 2*s - 2)
ans <- c(ans, ans5 = "Less than 0.01")
rm(list = setdiff(ls(), "ans"))

#' 6. Brain volumes for 9 men yielded a 90% confidence interval of 1,077 cc to 
#'1,123 cc. Would you reject in a two sided 5% hypothesis test of H0: u = 1078?

#' 1078 falls in the range. So no

ans <- c(ans, ans6 = "No you would not reject")

#' 7. Researchers would like to conduct a study of 100 healthy adults to detect 
#' a four year mean brain volume loss of .01 mm3. Assume that the standard 
#' deviation of four year volume loss in this population is .04 mm3. About what 
#' would be the power of the study for a 5% one sided test versus a null 
#' hypothesis of no volume loss?
mua <- 0.01; n <- 100; sd <- 0.04; p <- 0.05
ans7 <- pnorm(1.645 * 0.004, mean = 0.01, sd = 0.004, lower.tail = FALSE)
ans <- c(ans, ans7 = ans7)
rm(list = setdiff(ls(), "ans"))

#' 8. Researchers would like to conduct a study of n healthy adults to detect a 
#' four year mean brain volume loss of .01 mm3. Assume that the standard 
#' deviation of four year volume loss in this population is .04 mm3. About 
#' what would be the value of n needed for 90% power of type one error rate of 5%
#' one sided test versus a null hypothesis of no volume loss?
mua <- 0.01; sd <- 0.04; p <- 0.05; pow <- 0.9
ans8 <- power.t.test(power = pow, delta = mua, 
                     sd = sd, sig.level = p, type = "one.sample", alt = "one.sided")$n
ans <- c(ans, ans8 = ans8)
rm(list = setdiff(ls(), "ans"))

#' 9. As you increase the type one error rate, α, what happens to power?
ans <- c(ans, ans9 = "You will get larger power.")
