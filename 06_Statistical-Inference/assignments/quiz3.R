#' 1. In a population of interest, a sample of 9 men yielded a sample
#' average brain volume of 1,100cc and a standard deviation of 30cc.
#' What is a 95% Student's T confidence interval for the mean brain volume
#' in this new population?
s <- 9; avg <- 1100; sd <- 30
ans1 <- avg + c(1, -1)*qt(0.025, s-1)*sd/sqrt(s)
ans <- list(ans1 = ans1)
rm(list = setdiff(ls(), c("ans")))

#' 2. A diet pill is given to 9 subjects over six weeks. The average
#' difference in weight (follow up - baseline) is -2 pounds. What would
#' the standard deviation of the difference in weight have to be for
#' the upper endpoint of the 95% T confidence interval to touch 0?
s <- 9; avg <- -2;
ans2 <- avg/qt(0.025, s-1)*sqrt(s)
ans <- c(ans, ans2 = ans2)
rm(list = setdiff(ls(), c("ans")))

#' 3. In an effort to improve running performance, 5 runners were either
#' given a protein supplement or placebo. Then, after a suitable washout
#' period, they were given the opposite treatment. Their mile times were
#' recorded under both the treatment and placebo, yielding 10
#' measurements with 2 per subject. The researchers intend to use a
#' T test and interval to investigate the treatment.
#' Should they use a paired or independent group T test and interval?
#'  [   ]It's necessary to use both
#'  [ans]A paired interval
#'  [   ]You could use either
#'  [---]Independent groups, since all subjects were seen under both systems
ans <- c(ans, 
         ans3 = "A paired interval")

#' 4. In a study of emergency room waiting times, investigators consider
#' a new and the standard triage systems. To test the systems,
#' administrators selected 20 nights and randomly assigned the new
#' triage system to be used on 10 nights and the standard system on
#' the remaining 10 nights. They calculated the nightly median
#' waiting time (MWT) to see a physician. The average MWT for the
#' new system was 3 hours with a variance of 0.60 while the average
#' MWT for the old system was 5 hours with a variance of 0.68.
#' Consider the 95% confidence interval estimate for the differences
#' of the mean MWT associated with the new system. Assume a constant 
#' variance. What is the interval?
#' Subtract in this order (New System - Old System).
s <- 10; avg.new <- 3; var.new <- 0.6; avg.old <- 5; var.old <- 0.68
se <- sqrt(var.new/s + var.old/s)
error <- qt(0.975, df = s+s-2)*se
ans4 <- avg.new - avg.old + c(-1, 1)*error
ans <- c(ans, ans4 = list(ans4))
rm(list = setdiff(ls(), c("ans")))

#' 5. Suppose that you create a 95% T confidence interval. You then
#' create a 90% interval using the same data. What can be said about
#' the 90% interval with respect to the 95% interval?
#' [   ]It is impossible to tell.
#' [   ]The interval will be the same width, but shifted.
#' [ans]The interval will be narrower.
#' [---]The interval will be wider
ans <- c(ans, 
         ans5 = "The interval will be narrower")

#' 6. To further test the hospital triage system, administrators selected 200
#' nights and randomly assigned a new triage system to be used on 100 nights
#' and a standard system on the remaining 100 nights. They calculated the
#' nightly median waiting time (MWT) to see a physician. The average MWT for
#' the new system was 4 hours with a standard deviation of 0.5 hours while the
#' average MWT for the old system was 6 hours with a standard deviation of 2
#' hours. Consider the hypothesis of a decrease in the mean MWT associated
#' with the new treatment.
#' What does the 95% independent group confidence interval with unequal
#' variances suggest vis a vis this hypothesis? (Because there's so many
#' observations per group, just use the Z quantile instead of the T.)
#' [   ]When subtracting (old - new) the interval contains 0. 
#'      There is not evidence suggesting that the new system is effective.
#' [ans]When subtracting (old - new) the interval is entirely above zero. 
#'      The new system appears to be effective.
#' [   ]When subtracting (old - new) the interval is entirely above zero. 
#'      The new system does not appear to be effective.
#' [   ]When subtracting (old - new) the interval contains 0. 
#'      The new system appears to be effective.
s <- 100; avg.new <- 4; sd.new <- 0.5; avg.old <- 6; sd.old <- 2
se <- sqrt(sd.new*sd.new/s + sd.old*sd.old/s)
#df <- (sd.new^2 + sd.old^2)^2 / ((sd.new^2/s)^2/(s-1) + (sd.old^2/s)^2/(s-1) )
error <- qnorm(0.975)*se
left <- (avg.old - avg.new) - error
right <- (avg.old - avg.new) + error
ans <- c(ans, ans6 = list(c(left, right)))
rm(list = setdiff(ls(), c("ans")))

#' 7. Suppose that 18 obese subjects were randomized, 9 each, to a new diet
#' pill and a placebo. Subjects’ body mass indices (BMIs) were measured at a
#' baseline and again after having received the treatment or placebo for four
#' weeks. The average difference from follow-up to the baseline
#' (followup - baseline) was −3 kg/m2 for the treated group and 1 kg/m2 for
#' the placebo group. The corresponding standard deviations of the differences
#' was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group.
#' Does the change in BMI over the four week period appear to differ between
#' the treated and placebo groups? Assuming normality of the underlying data
#' and a common population variance, calculate the relevant *90%* t confidence
#' interval. Subtract in the order of (Treated - Placebo) with the smaller (more negative) number first.
s <- 9;diff.tr <- -3;diff.pl <- 1; sd.tr <- 1.5; sd.pl <- 1.8
se <- sqrt(sd.tr^2/s + sd.pl^2/s)
error <- qt(0.95, df = 2*s-2)*se
ans7 <- diff.tr - diff.pl + c(-1, 1)*error
ans <- c(ans, ans4 = list(ans7))
rm(list = setdiff(ls(), c("ans")))
