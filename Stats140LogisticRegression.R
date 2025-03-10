library(tidyverse)
library(caret)
library(MASS)

nba <- read.csv("all-star-dataset.csv")
nba$all_star <- as.numeric(as.logical(nba$all_star))
features <- c("g", "gs", "mp", "fg", "fga", "x3p", "x3pa", "fta", "orb", 
              "drb", "ast", "stl", "blk", "tov", "pf", "pts")
nba1 <- nba[, c(features, "all_star")]


set.seed(42)
train_index <- createDataPartition(nba$all_star, p = 0.8, list = FALSE)
traindata <- nba[train_index,]
testdata <- nba[-train_index,]


m1 <- glm(all_star ~ g+gs+mp+fg+fga+x3p+x3pa+x2p+x2pa+ft+fta+orb+drb+ast+stl+blk+tov+pf+pts, data = traindata, family = binomial)
summary(m1)
stepmodel <- stepAIC(m1, direction = "both")
summary(stepmodel)

m2 <- glm(all_star ~ g+gs+fg+fga+x3p+x3pa+ft+drb+ast+stl+blk+pf, data = traindata, family = binomial)
summary(m2)


predprobs <- predict(m2, testdata, type = "response")
predlabels <- ifelse(predprobs > 0.5, 1,0)
confmatrix <- confusionMatrix(as.factor(predlabels), as.factor(testdata$all_star))
confmatrix

accuracy <- sum(predlabels ==testdata$all_star) / nrow(testdata)
accuracy

pp <- predict(m2, nba, type = "response")
ppl <- ifelse(pp > 0.5, 1,0)
confusionMatrix(as.factor(ppl), as.factor(nba$all_star))

