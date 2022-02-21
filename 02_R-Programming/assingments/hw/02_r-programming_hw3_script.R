setwd("./hw")
#1. Take a look at the 'iris' dataset that comes with R. The data can be loaded with the code:
library(datasets)
data(iris)
# A description of the dataset can be found by running
?iris
# There will be an object called 'iris' in your workspace. In this dataset, what is the mean of
# 'Sepal.Length' for the species virginica? Please round your answer to the nearest whole number.
species.mean <- tapply(iris$Sepal.Length, iris$Species, mean)
ans1 <- round(species.mean[[3]])

#2. Continuing with the 'iris' dataset from the previous Question, what R code returns a 
# vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', 
# and 'Petal.Width'?
apply(iris[, 1:4], 2, mean)

#3. Load the 'mtcars' dataset in R with the following code
library(datasets)
data(mtcars)
# There will be an object names 'mtcars' in your workspace. You can find some 
# information about the dataset by running
?mtcars
# How can one calculate the average miles per gallon (mpg) by number of cylinders in the 
# car (cyl)? Select all that apply.
sapply(mtcars, cyl, mean) #no
tapply(mtcars$cyl, mtcars$mpg, mean) #no
with(mtcars, tapply(mpg, cyl, mean)) #yes
mean(mtcars$mpg, mtcars$cyl) #no
sapply(split(mtcars$mpg, mtcars$cyl), mean) #yes
apply(mtcars, 2, mean) #no
lapply(mtcars, mean) #no
tapply(mtcars$mpg, mtcars$cyl, mean) #yes
split(mtcars, mtcars$cyl) #no

#4. Continuing with the 'mtcars' dataset from the previous Question, what is the absolute
# difference between the average horsepower of 4-cylinder cars and the average 
# horsepower of 8-cylinder cars?
avg <- with(mtcars, tapply(hp, cyl, mean))
ans4 <- round(avg[[3]] - avg[[1]])

#5. If you run debug(ls), what happens when you next call the 'ls' function?
debug(ls)
ls()
undebug(ls)
