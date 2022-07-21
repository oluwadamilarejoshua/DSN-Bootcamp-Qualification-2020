
# Packages ----------------------------------------------------------------

library(xgboost)
library(magrittr)
library(dplyr)
library(Matrix)
library(e1071)
library(Metrics)


# Data --------------------------------------------------------------------

split_ <- c(1:nrow(trainData))
train_ <- fullData[split_, ]
test_ <- fullData[-split_, ]

# str(test_) # Data whose prediction is to be submitted
# 
# str(build_)  # 85% of the original train data to be used to build the model
# str(validate_)   # 15% of the original train data to be used for validation

# defaultIndex <- ncol(train_)


# build_features <- data.matrix(train_)
# build_label <- factor(build_[, defaultIndex])
# 
# params <- list(booster = "gbtree", max.depth = 8, eta = 0.01,  
#                objective = "binary:logistic", subsample = 0.8)
# 
# model_ <- xgboost(params, data = build_features, label = build_label,
#                   nround = 150, eval_metric = "rmse")

# 
# dvalidate <- xgb.DMatrix(data.matrix(validate_[, -362]), label = validate_[, 362], missing = NA)
# 
dtrain <- xgb.DMatrix(data.matrix(train_), label = as.factor(toDefault_), missing = NA)

str(train_)

params <- list(booster = "gbtree", 
               objective = "binary:logistic", 
               eta = 0.00005, 
               gamma = 1,
               max_depth = 25, 
               min_child_weight = 1, 
               subsample = 1, 
               colsample_bytree = 1)
# 
# model_ <- xgb.train(params = params, data = dtrain, nrounds = 291, 
#                     print_every_n = 10, maximize = F , eval_metric = "auc")



# machine = xgboost(dtrain, num_class = 2 , max.depth = 2, 
#                   eta = 1, nround = 2,nthread = 2, 
#                   objective = "multi:softprob")
# 
# df_metrics <- function(data, level = NULL, model = NULL) {
#   df_eval = auc(data[, "obs"], data[, "pred"])
#   names(df_eval) = c("AUC")
#   df_eval
# }

# 
# control <- trainControl(method = "cv",
#                         number = 5,
#                         classProbs = T,
#                         # summaryFunction = df_metrics,
#                         )
# 
# param_grid <- expand.grid(eta = 0.1,
#                           colsample_bytree = 0.5,
#                           max_depth = 2,
#                           nrounds = 100,
#                           gamma = 1,
#                           min_child_weight = 1,
#                           subsample = 0.8)
# 
# modelxgboost <- train(toDefault_ ~., 
#                       data = build_,
#                       method = "xgbTree",
#                       trControl = control,
#                       tuneGrid = param_grid,
#                       na.action = na.pass,
#                       # metric = "AUC",
#                       )

# real_model <- train(toDefault_ ~., 
#                       data = train_,
#                       method = "xgbTree",
#                       trControl = control,
#                       tuneGrid = param_grid,
#                       na.action = na.pass,
#                       # metric = "AUC",
#                       )


# str(train_features)
 
# train_features <- as.matrix(train_)
# train_label <- factor(train_[, defaultIndex])

model_1 <- xgboost(params, 
                   data = dtrain,
                  nround = 12, 
                  eval_metric = "rmse")


#------ Validation ------------------------------------------------------------

test_prediction <-
  predict(model_1, newdata = data.matrix(validate_[, -the_index]))

head(test_prediction)

auc(validate_[, the_index], test_prediction)

#-------------------------------------------------------------------------------

submission <- predict(model_1, newdata = data.matrix(test_))

submission1 <- data.frame(test_Application_ID, submission - 1)
names(submission1) <- c("Applicant_ID", "default_status")

head(submission1)
# write.csv(submission1, file = "newFile.csv")
# write.csv(submission1, file = "newFile2.csv")
write.csv(submission1, file = "xgboost_submission11.csv")




# 0.7905256
# 0.787411 without dummies
# 0.8128544 for 100 rounds
# 0.8179179 for 50 rounds
# 0.8208659 for 20 rounds
# 0.8211754 for 10 rounds
# 0.8223227 for 15 rounds
# 0.821877 for 17 rounds
# 0.8185076 for 5 rounds


# 0.8231404 (15 rounds after adding two new features)
# 0.8221882 (12 rounds after adding two new features)


# 0.8258275
# 0.8252653
# 0.8255938
# 0.8243203
# 0.8221103
# 0.8238826
# 0.8239109


# 0.82613

