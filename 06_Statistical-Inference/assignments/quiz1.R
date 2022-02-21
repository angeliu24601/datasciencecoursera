#' 1. Consider influenza epidemics for two parent heterosexual families. 
#' Suppose that the probability is 17% that at least one of the parents 
#' has contracted the disease. The probability that the father has contracted 
#' influenza is 12% while the probability that both the mother and father have
#' contracted the disease is 6%. What is the probability that the mother has 
#' contracted influenza?
p1 <- 0.17; p.f <- 0.12; p.both <- 0.06
#' The concept is: p1 = p.f + p.m - p.both, therefore:
ans1 <- p1 - p.f + p.both
ans1
rm(list = setdiff(ls(), c("ans1")))

#' 2. A random variable, X is uniform, a box from 0 to 1 of height 1. (So that 
#' its density is f(x)=1 for 0≤x≤1.) What is its 75th percentile?
#' (Hints, look at lecture 2 around 21:30 and Chapter 5 Problem 5. Also, 
#' look up the help function for the qunif command in R.)
qunif(0.75)

#' 3. You are playing a game with a friend where you flip a coin and if it 
#' comes up heads you give her X dollars and if it comes up tails she gives
#' you Y dollars. The probability that the coin is heads is p 
#' (some number between 0 and 1.) What has to be true about X and Y to make 
#' so that both of your expected total earnings is 0. 
#' The game would then be called “fair”.
#' 
#' (Hints, look at Lecture 4 from 0 to 6:50 and Chapter 5 Problem 6. Also, for 
#' further reading on fair games and gambling, start with the Dutch Book problem ).

#' p * x = (1 - p) * y

#' 4. A density that looks like a normal density (but may or may not be exactly normal)
#' is exactly symmetric about zero. (Symmetric means if you flip it around zero
#' it looks the same.) What is its median?

#' the median must be zero

#' 5. Consider the following PMF shown below in R
x <- 1:4
p <- x/sum(x)
temp <- rbind(x, p)
rownames(temp) <- c("X", "Prob")
temp
#' What is the mean?
ans4 <- sum(temp["X",]*temp["Prob",])

#' 6 A web site (www.medicine.ox.ac.uk/bandolier/band64/b64-7.html) 
#' for home pregnancy tests cites the following: “When the subjects using the
#' test were women who collected and tested their own samples, the overall
#' sensitivity was 75%. Specificity was also low, in the range 52% to 75%.”
#' Assume the lower value for the specificity. Suppose a subject has a 
#' positive test and that 30% of women taking pregnancy tests are 
#' actually pregnant. What number is closest to the probability of pregnancy 
#' given the positive test?

sens <- 0.75; spec <- 0.52; p <- 0.3

#' Concept:
#'                 Disease Present   Disease Absent
#' Test Positive        TP                FP
#' Test Negative        FN                TN
#' - Sensitivity: P(T+|D+) = TP / (TP+FN)        = 0.75
#' - Specificity: P(T-|D-) = TN / (TN + FP)      = 0.52
#' - Prevalence: P(D+) = (TP+FN) / (TP+FP+TN+FN) = 0.3
#' - Predictive value of a positive test is the proportion of patients with 
#'  positive tests who have diseas (D+|T+) = TP / (TP+FP)

#'  We can infer that:
#'    TP + FN = Prevalance = 0.3 (assuming TP + FP + TN + FN = 1)
#'    FP + TN = 1 - Prevalance = 0.7
#'    TP = Sensitivity * Prevalance
#'    FP = (1 -  Specificity) * (1 - Prevalance)
#' Therefore, Predicitive value (+) =
#'                          Sensitivity * Prevalance
#' ------------------------------------------------------------------
#' [Sensitivity * Prevalance + (1 -  Specificity) * (1 - Prevalance)]
ans6 <- sens * p /(sens*p + (1 - spec) * (1 - p))
rm(list = setdiff(ls(), paste0("ans", c(1:6))))
