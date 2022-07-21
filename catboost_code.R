library(catboost)
library(e1071)
library(Metrics)

split_ <- c(1:nrow(trainData))
train_ <- fullData[split_, ]
test_ <- fullData[-split_, ]




# str(validate_)

# head(train_)


train_pool <- catboost.load_pool(data = train_, label = toDefault_, cat_features = c(2))

# -------------------------------------------------
# 0.9433533 validation
# 0.843069905 zindi
params <- list(iterations = 2350,
               learning_rate = 0.001,
               depth = 12,
               # one_hot_max_size = 255,
               # l2_leaf_reg = 3.5,
               # loss_function = 'Logloss',
               # custom_loss = 'Logloss',
               # eval_metric = 'AUC',
               random_seed = 55,
               # bootstrap_type = "Bayesian",
               od_type = 'Iter',
               metric_period = 50,
               od_wait = 20)
# -------------------------------------------------

# 0.9683581 validation

# params <- list(iterations = 5050,
#                learning_rate = 0.005,
#                depth = 11,
#                # one_hot_max_size = 255,
#                # l2_leaf_reg = 3.5,
#                # loss_function = 'Logloss',
#                # custom_loss = 'Logloss',
#                # eval_metric = 'AUC',
#                random_seed = 55,
#                # bootstrap_type = "Bayesian",
#                od_type = 'Iter',
#                metric_period = 50,
#                od_wait = 20)
# -------------------------------------------------

# params <- list(iterations = 5050,
#                learning_rate = 0.002,
#                depth = 10,
#                # one_hot_max_size = 255,
#                # l2_leaf_reg = 3.5,
#                # loss_function = 'Logloss',
#                # custom_loss = 'Logloss',
#                # eval_metric = 'AUC',
#                random_seed = 55,
#                # bootstrap_type = "Bayesian",
#                od_type = 'Iter',
#                metric_period = 50,
#                od_wait = 20)
# -------------------------------------------------

# 0.8509104 validation
# params <- list(iterations = 5050,
#                learning_rate = 0.0005,
#                depth = 11,
#                # one_hot_max_size = 255,
#                # l2_leaf_reg = 3.5,
#                # loss_function = 'Logloss',
#                # custom_loss = 'Logloss',
#                # eval_metric = 'AUC',
#                # random_seed = 55,
#                # bootstrap_type = "Bayesian",
#                # od_type = 'Iter',
#                metric_period = 50
#                # od_wait = 20
#                )


# params <- list(iterations = 5550,
#                learning_rate = 0.005,
#                depth = 11,
#                # one_hot_max_size = 255,
#                # l2_leaf_reg = 3.5,
#                # loss_function = 'Logloss',
#                # custom_loss = 'Logloss',
#                # eval_metric = 'AUC',
#                random_seed = 55,
#                # bootstrap_type = "Bayesian",
#                od_type = 'Iter',
#                metric_period = 50,
#                od_wait = 20)


catboost_model <- catboost.train(learn_pool = train_pool, 
                                 # validate_pool, 
                                 params = params)

#------------------- Validation Area ------------------------------------------

trainCheck = data.frame(train_, toDefault_)
smp_size = floor(0.45 * nrow(train_))
set.seed(1234)

train_ind = sample(seq_len(nrow(trainCheck)), size = smp_size)
validate_ <- trainCheck[train_ind, ]

the_index <- ncol(validate_)
catboost_validation <- catboost.predict(model = catboost_model, 
                                        pool = catboost.load_pool(validate_[, -the_index]), 
                                        prediction_type = "Probability")
auc(validate_[, the_index], catboost_validation)

#-------------------- Prediction and submission prep --------------------------

catboost_prediction <- catboost.predict(model = catboost_model, 
                                        pool = catboost.load_pool(test_), 
                                        prediction_type = "Probability")
head(catboost_prediction)

write.csv(data.frame(test_Application_ID, catboost_prediction), file = "optimal_cat5.csv")


catboost.get_feature_importance(model = catboost_model)

