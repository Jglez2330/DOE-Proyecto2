# Design of experiments
# Project 2
# Stdudents: Gabriel Gutierrez Arguedas
#            Joseph Gonzalez Pastora          

# Calling required libraries

library(psych)
library(FSA)
library(lattice)
library(rcompanion)
library(car)
library(lsmeans)
library(multcompView)
library(multcomp)
library(ggplot2)
library(stringr)

# Loading data

Data <- read.csv("C:/Users/gegutier/OneDrive - Intel Corporation/Documents/data.txt", sep="", header=TRUE)

# Defining columns as factor

Data$OS <- as.factor(Data$OS)
Data$Scenes <- as.factor(Data$Scenes)
Data$Acc_Int <- as.factor(Data$Acc_Int)

# Data summary

headTail(Data)
str(Data)
summary(Data)

# Simple interaction graphs

# OS and Scenes in function of time 

int1 <- interaction.plot(x.factor = Data$Scenes,
                 trace.factor = Data$OS,
                 response= Data$Time,
                 fun = mean,
                 type="b",
                 col=c ("black" ,"red" ,"blue"),
                 pch=c(19, 17, 15),
                 #fixed-TRUE,
                 leg.bty = "o" )

# OS and Accelerator-Integrator in function of time

interaction.plot(x.factor = Data$Acc_Int,
                 trace.factor = Data$OS,
                 response= Data$Time,
                 fun = mean,
                 type="b",
                 col=c ("black" ,"red" ,"blue"),
                 pch=c(19, 17, 15),
                 #fixed-TRUE,
                 leg.bty = "o" )

# Defining linear model

model = lm(Time ~ OS*Acc_Int*Scenes,
           data=Data)

# Executing Anova

Anova(model, 
      type ="II") 

# Residuals 

x = residuals(model)

# Residuals histogram

plotNormalHistogram(x)

# Homoscedasticity

plot(fitted(model),
     residuals(model))

# Graphs

#1. Residuals vs Fitted
#2. Q-Q plot
#3. Scale-Location

plot(model)

# Homoscedasticity Levene Test

leveneTest(Time ~ OS*Acc_Int*Scenes,
           data=Data)

# Data transformation: Square root

T_sqrt = sqrt(Data$Time)

model = lm(T_sqrt ~ OS*Acc_Int*Scenes,
           data=Data)

# Residuals

x = residuals(model)

# Residuals histogram
plotNormalHistogram(x)

# Homoscedasticity

plot(fitted(model),
     residuals(model))

# Graphs

#1. Residuals vs Fitted
#2. Q-Q plot
#3. Scale-Location

plot(model)

# Homoscedasticity Levene Test

leveneTest(T_sqrt ~ OS*Acc_Int*Scenes,
           data=Data)

# Executing Anova

Anova(model, 
      type ="II") 

# Plotting Time vs OS

# Creating Sum variable with means and se

Sum = Summarize(T_sqrt ~ OS,
                data = Data,
                digits = 3)

# Adding se 

Sum$se = Sum$sd / sqrt(Sum$n)
Sum$se = signif(Sum$se, digits=3)

# Plotting graph

pd = position_dodge(.2)

var1 <- ggplot(Sum,
       aes(x=OS, 
           y=mean, color = OS)) +
  geom_errorbar(aes(ymin = mean - se, 
                    ymax = mean + se), 
                width=.2,size=0.7,
                position=pd) +
  geom_point(aes(shape=OS), size=5, position=pd) 

var1 + theme(text = element_text(size = 20)) + ylab("Square root of Time mean") 

# Plotting Time vs OS+Acc_Int interaction

# Creating Sum variable with means and se

Sum = Summarize(T_sqrt ~ OS+Acc_Int,
                data = Data,
                digits = 3)

# Adding se 

Sum$se = Sum$sd / sqrt(Sum$n)
Sum$se = signif(Sum$se, digits=3)

# Plotting graph

pd = position_dodge(.2)

var2 <- ggplot(Sum,
       aes(x=Acc_Int, 
           y=mean, color = OS)) +
  geom_errorbar(aes(ymin = mean - se, 
                    ymax = mean + se), 
                width=.2,size=0.7,
                position=pd) +
  geom_point(aes(shape=OS), size=5, position=pd) 

var2 + theme(text = element_text(size = 20)) + ylab("Square root of Time mean") 

# Plotting Time vs OS+Scenes interaction

# Creating Sum variable with means and se

Sum = Summarize(T_sqrt ~ OS+Scenes,
                data = Data,
                digits = 3)

# Adding se 

Sum$se = Sum$sd / sqrt(Sum$n)
Sum$se = signif(Sum$se, digits=3)

# Plotting graph

pd = position_dodge(.2)

var3 <- ggplot(Sum,
       aes(x=Scenes, 
           y=mean, color = OS)) +
  geom_errorbar(aes(ymin = mean - se, 
                    ymax = mean + se), 
                width=.2,size=0.7,
                position=pd) +
  geom_point(aes(shape=OS), size=5, position=pd) 

var3 + theme(text = element_text(size = 20)) + ylab("Square root of Time mean")

# Pairwise t-test for OS

pairwise.t.test(T_sqrt, Data$OS,
                p.adjust.method = "BH")

# Pairwise t-test for Acc_Int

pairwise.t.test(T_sqrt, Data$Acc_Int,
                p.adjust.method = "BH")

# Pairwise t-test for Scenes

pairwise.t.test(T_sqrt, Data$Scenes,
                p.adjust.method = "BH") 