library(magrittr)
library(dplyr)
library(Matrix)
library(tidyverse)
library(caret)


trainData <- read.csv("train.csv")
testData <- read.csv("test.csv")

# str(test_Application_ID)

test_Application_ID <- as.character(testData[, 1])

toDefault_ <- as.integer(factor(trainData[, 52], levels = c("no", "yes"),
                     labels = c("0", "1")))
str(toDefault_)

for (i in 1:length(toDefault_)){
  if (toDefault_[i] == "1") {
    toDefault_[i] <- 0
  }else{
    toDefault_[i] <- 1
  }
}
# toDefault_ <- as.factor(toDefault_)
head(toDefault_)

trainData$default_status <- NULL
fullData <- rbind(trainData, testData)

fullData <- fullData[, -1]

index_ <- c(16:20, 35:39, 46:47)
for (var_ in index_) {
  fullData[, var_] <- as.factor(fullData[, var_])
}

transLog <- c(1, 6:15, 21:32)
for (ind_ in transLog) {
  fullData[, ind_] <- fullData[, ind_] ^ (1 / 5)
}

str(fullData)

# 
# fullData <- fullData %>% 
#   mutate(
#     form_field_3by33 = log(sqrt(form_field3 / form_field33)),
#          form_field_1by15by44 = log((form_field1 / form_field15) * form_field44) ^ (-1),
#          # # form_field_42by43 = log(form_field42 * form_field43),
#          form_field_1by10by12 = form_field1 / (form_field10 * form_field12),
#          # form_field_8by3 = log(form_field8 * form_field3),
#          # form_field_2by50 = sqrt(form_field2) * log(form_field50),
#          form_field_1by7 = form_field1 * form_field7,
#          form_field_1by30 = form_field1 * form_field30,
#          # form_field_26by25 = form_field26 / form_field25,
#          form_field_13by14 = form_field13 * form_field14,
#          # form_field_11by15 = form_field11 * form_field15,
#          # form_field_8by13 = form_field8 / form_field13,
#          form_field_1by25by30 = (form_field1 * form_field25) / form_field30,
#          form_field_1by25by32 = (form_field1 * form_field25) / form_field32,
#          form_field_1by21 = form_field1 * form_field21,
#          # form_field_24by21by32 = (form_field24 * form_field21) / form_field32,
#          # form_field_7by10by11 = (form_field7 * form_field10) / form_field11,
#          
#          ) %>%
#   transform(form_field2 = sqrt(form_field2),
#             form_field50 = log(form_field50),
#             form_field32 = log(form_field32),
#             form_field7 = form_field7 ^ (-1))
# 

fullData <- fullData %>%
  mutate(
    form_field_3by33 = log(sqrt(form_field3 / form_field33)),
    form_field_42by43 = log(form_field42 * form_field43),
    form_field_1by15by44 = (form_field1 / form_field15) * form_field44,
    form_field_1by44 = form_field1 * form_field44,
    form_field_1by2 = log(sqrt(form_field1 * form_field2)),
    form_field_1by3 = log(sqrt(form_field1 * form_field3)),
    form_field_1by6 = log(sqrt(form_field1 * form_field6)),
    form_field_1by7 = log(sqrt(form_field1 * form_field7)),
    form_field_1by9 = log(sqrt(form_field1 * form_field9)),
    form_field_1by10 = log(sqrt(form_field1 * form_field10)),
    form_field_1by11 = log(sqrt(form_field1 * form_field11)),
    form_field_1by22 = log(sqrt(form_field1 * form_field22)),
    form_field_1by23 = log(sqrt(form_field1 * form_field24)),
    form_field1div15 = log(form_field1 / form_field15),
    form_field_1by15 = form_field1 * form_field15,
    form_field_1by25by30 = (form_field1 * form_field25) / form_field30,
    form_field_1by25by32 = (form_field1 * form_field25) / form_field32,
    form_field_1by21by32 = (form_field1 * form_field21) / form_field32,
    form_field_2by50 = form_field2 * form_field50,
    form_field_2by15by44 = log((form_field2 / form_field15) * form_field44),
    form_field_2by44 = log(sqrt(form_field2 * form_field44)),
    form_field_2by3 = log(form_field2 * form_field3),
    form_field_2by11 = log(form_field2 * form_field11),
    form_field_2by14 = log(form_field2 * form_field14),
    form_field_2by15 = log(sqrt(form_field2 / form_field15)),
    form_field_2by27 = log(sqrt(form_field2 / form_field27)),
    form_field_2by28 = log(sqrt(form_field2 / form_field28)),
    form_field_2by29 = log(sqrt(form_field2 / form_field29)),
    form_field_2by33 = log(sqrt(form_field2 / form_field33)),
    form_field_2by34 = log(form_field2 * form_field34),
    form_field_2by30 = log(sqrt(form_field2 / form_field30)),
    form_field_2by15 = log(sqrt(form_field2 * form_field15)),
    form_field_2by25by32 = log((form_field2 * form_field25) / form_field32),
    form_field_2by21by32 = log(sqrt((form_field2 * form_field21) / form_field32)),
    form_field_26by25 = log(sqrt(form_field26 * form_field25)),
    form_field_8by13 = log(sqrt(form_field8 * form_field13)),
    form_field_24by21by32 = log(sqrt((form_field24 * form_field21) / form_field32)),
    form_field_7by10by11 = log((form_field7 * form_field10) / form_field11),
    # Variables to check out 7, 8, 10, 11, 13, 21, 24, 25, 26, 32
    )
# %>%
#   transform(form_field2 = sqrt(form_field2),
#             form_field50 = log(form_field50),
#             form_field32 = log(form_field32)) 
# %>% 
  # select(., -c(form_field5, form_field12, form_field17, form_field20, form_field39, form_field50))

str(fullData)

# remove_feature <- c("form_field5", "form_field12", "form_field17", "form_field39", "form_field")
# 
# fullData <- full




# 
# ohe_feats = c('form_field16', 'form_field17', 'form_field18', 'form_field19', 'form_field20',
#               'form_field35', 'form_field36', 'form_field37', 'form_field38', 'form_field39',
#               'form_field46', 'form_field47')
# dummies <- dummyVars(~ form_field16 + form_field17 + form_field18 + form_field19 +form_field20 +
#               form_field35 + form_field36 + form_field37 + form_field38 + form_field39 +
#               form_field46 + form_field47, data = fullData)
# df_all_ohe <- as.data.frame(predict(dummies, newdata = fullData))
# fullData <- cbind(fullData[,-c(which(colnames(fullData) %in% ohe_feats))],df_all_ohe)

# str(fullData)
# toDefault_ <- as.integer(toDefault_)

split_ <- c(1:nrow(trainData))
train_ <- cbind(fullData[split_, ], toDefault_)
test_ <- fullData[-split_, ]

# View(train_)

# ggplot(train_) +
#   geom_point(mapping = aes(x = form_field32, #log(sqrt((form_field1 * form_field44) / form_field5)),
#                            y = log((form_field42 / form_field43) * log(form_field1)),
#                            color = toDefault))
# 
# ggplot(train_) +
#   geom_point(mapping = aes(x = form_field2,
#                            y = form_field43,
#                            color = toDefault_
#                            ))
# 
# ggplot(train_) +
#   geom_point(mapping = aes(x =
#                              # log(sqrt((form_field7 * form_field10) / form_field11)),
#                              # log((form_field7 * form_field10) / form_field11),
#                              # (form_field2 * form_field14) ^ (-1),
#                              form_field7 / form_field8,
#                              # (form_field7 * form_field10) / form_field11,
#                            y = form_field1,
#                            color = as.factor(toDefault_)))
# 
# ggplot(train_) +
#   geom_point(mapping = aes(x = log(form_field1 / form_field15),
#                            y = form_field2,
#                            color = as.factor(toDefault_)))
# 
# ggplot(train_) +
#   geom_point(mapping = aes(x = form_field1 ^ (-1),
#                            y = log(form_field14),
#                            color = toDefault))
# 
# ggplot(train_) +
#   geom_point(mapping = aes(x = form_field1,
#                            y = form_field_1by15by44,
#                            color = toDefault))
# ggplot(train_) +
#   geom_point(mapping = aes(x = form_field1,
#                            y = form_field14,
#                            color = toDefault))
