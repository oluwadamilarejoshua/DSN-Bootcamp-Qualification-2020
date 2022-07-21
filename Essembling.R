
# cat6 <- read.csv("catboost6.csv")    #.8429
# cat7 <- read.csv("catboost7.csv")    #.8419
cat11 <- read.csv("catboost11.csv")  #.8431
# cat12 <- read.csv("catboost12.csv")  
# cat15 <- read.csv("catboost15.csv") 
# cat18 <- read.csv("catboost18.csv")
# cat19 <- read.csv("catboost19.csv")
# cat20 <- read.csv("catboost20.csv")
# cat_1 <- read.csv("optimal_cat1.csv")


beauti_merge3 <- read.csv("beautiful_merge3.csv")
newFile <- read.csv("newFile.csv")

# head(newFile_pred)
# merge7 <- read.csv("merge7.csv")  
# merge8 <- read.csv("merge8.csv")  
# merge9 <- read.csv("merge9.csv")  
# merge10 <- read.csv("merge10.csv")  
# 
# merge7_pred <- merge7$new_catboost_prediction
# merge8_pred <- merge8$new_catboost_prediction
# merge9_pred <- merge9$new_catboost_prediction
# merge10_pred <- merge10$new_catboost_prediction

beautiPred <- beauti_merge3[, 2]
newFile_pred <- newFile[, 2]

# 
# cat6_pred <- cat6$catboost_prediction
# cat7_pred <- cat7$catboost_prediction
cat11_pred <- cat11$catboost_prediction
# cat12_pred <- cat12$catboost_prediction
# cat15_pred <- cat15$catboost_prediction
# cat18_pred <- cat18$catboost_prediction
# cat19_pred <- cat19$catboost_prediction
# cat20_pred <- cat20$catboost_prediction
# cat_1_pred <- cat_1$catboost_prediction

# 0.8426 / (0.8429 + 0.8419 + 0.843 + 0.8426)


# new_pred <- (cat6_pred * 0.3) + (cat7_pred * 0.2) + (cat11_pred * 0.2) + 
#   (cat15_pred * 0.15) + (cat18_pred * 0.15)

# combination1 <- (cat6_pred * 0.3) + (cat11_pred * 0.3) + (cat15_pred * 0.2) + (cat19_pred * 0.2)
# combination2 <- (cat7_pred * 0.2) + (cat12_pred * 0.15) + (cat18_pred * 0.35) + (cat20_pred * 0.3)
# 
# new_merge <- (combination1 * 0.85) + (combination2 * 0.15) +
#                                                             0.8423 + 0.8415 + 0.8425
# #  + 
#   (cat19_pred * 0.8423) + (cat20_pred * 0.8415) + (cat_1_pred * 0.8425)
# 
# merging_merge1 <- (merge7_pred * .45) + (merge9_pred * .55)
# merging_merge2 <- (merge8_pred * .55) + (merge10_pred * .45)
# 
# 
# tot_merge <- (merging_merge1 * .35) + (merging_merge2 * .65)


# new_catboost_prediction <- (new_merge * .45) + (tot_merge * .55)

# new_catboost_prediction <- (merge8_pred * 0.2) + (merge9_pred * 0.7) + (merge10_pred * 0.1)

# new_catboost_prediction <- (cat11_pred * 0.6) + (cat15_pred * 0.16) + (cat6_pred * 0.14) + 
#   (cat18_pred * 0.1)

# head(new_catboost_prediction)

default_status <- (beautiPred * .5) + (newFile_pred * .3) + (cat11_pred * .4)


write.csv(data.frame(test_Application_ID, default_status),
          file = "bestPreds10.csv")
# write.csv(data.frame(test_Application_ID, new_catboost_prediction), file = "complex_merging3.csv")
# write.csv(data.frame(test_Application_ID, new_catboost_prediction), file = "merging_merge6.csv")
# write.csv(data.frame(test_Application_ID, new_catboost_prediction), file = "beautiful_merge3.csv")
# 
# a <- 0.8419 + 0.8429 + 0.8431
# 0.8431/a
