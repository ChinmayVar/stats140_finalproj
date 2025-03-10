library(nnet)
library(dplyr)


df <- read_csv('all-star-dataset.csv')

#Clean and make all_star binary
df$all_star <- as.numeric(df$all_star)

df <- df %>% select(-season, -player, -player_id)

output <- c(0)

for (i in 1:50) {
  
  #Split train/test
  train_idx <- sample(1:nrow(df), size = 0.8 * nrow(df))
  train_data <- df[train_idx, ]
  test_data <- df[-train_idx, ]
  
  #Extract predictors
  x_train <- train_data %>% select(-all_star)
  y_train <- train_data$all_star
  
  x_test <- test_data %>% select(-all_star)
  y_test <- test_data$all_star
  
  #Train the neural network
  model <- nnet(all_star ~ ., data = train_data, size = 8, linout = FALSE, decay = 0.1, maxit = 400, trace = FALSE)
  
  #Get predictions 
  pred_probs <- predict(model, x_test, type = "raw")
  
  preds <- ifelse(pred_probs > 0.5, TRUE, FALSE)
  
  accuracy <- mean(preds == test_data$all_star)
  
  output[i] <- accuracy
  
  cat("Test Accuracy:", accuracy, "\n")

}

mean(output)


output <- c(0)

df_per_game <- df %>%
  mutate(across(everything(), ~ . / g))

for (i in 1:50) {
  
  #Split train/test
  train_idx <- sample(1:nrow(df_per_game), size = 0.8 * nrow(df_per_game))
  train_data <- df_per_game[train_idx, ]
  test_data <- df_per_game[-train_idx, ]
  
  #Extract predictors
  x_train <- train_data %>% select(-all_star)
  y_train <- train_data$all_star
  
  x_test <- test_data %>% select(-all_star)
  y_test <- test_data$all_star
  
  #Train the neural network
  model <- nnet(all_star ~ ., data = train_data, size = 8, linout = FALSE, decay = 0.1, maxit = 400, trace = FALSE)
  
  #Get predictions
  pred_probs <- predict(model, x_test, type = "raw")

  preds <- ifelse(pred_probs > 0.5, TRUE, FALSE)
  
  accuracy <- mean(preds == test_data$all_star)
  cat("Test Accuracy:", accuracy, "\n")
  
  output[i] <- accuracy
}

mean(output)



df <- read_csv('all-star-dataset_more.csv')

#Clean and make all_star binary
df$all_star <- as.numeric(df$all_star)

df <- df %>% select(-season, -player, -player_id)

output <- c(0)

for (i in 1:50) {

  #Split train/test
  train_idx <- sample(1:nrow(df), size = 0.8 * nrow(df))
  train_data <- df[train_idx, ]
  test_data <- df[-train_idx, ]
  
  #Extract predictors
  x_train <- train_data %>% select(-all_star)
  y_train <- train_data$all_star
  
  x_test <- test_data %>% select(-all_star)
  y_test <- test_data$all_star
  
  #Train the neural network
  model <- nnet(all_star ~ ., data = train_data, size = 8, linout = FALSE, decay = 0.1, maxit = 400, trace = FALSE)
  
  #Make predictions
  pred_probs <- predict(model, x_test, type = "raw")
  
  preds <- ifelse(pred_probs > 0.5, TRUE, FALSE)
  
  accuracy <- mean(preds == test_data$all_star)
  
  cat("Test Accuracy:", accuracy, "\n")
  
  output[i] <- accuracy
}

mean(output)

df_per_game <- df %>%
  mutate(across(everything(), ~ . / g))

output <- c(0)

for (i in 1:50) {
  
  #Split train/test
  train_idx <- sample(1:nrow(df_per_game), size = 0.8 * nrow(df_per_game))
  train_data <- df_per_game[train_idx, ]
  test_data <- df_per_game[-train_idx, ]
  
  #Extract predictors
  x_train <- train_data %>% select(-all_star)
  y_train <- train_data$all_star
  
  x_test <- test_data %>% select(-all_star)
  y_test <- test_data$all_star
  
  #Train the neural network
  model <- nnet(all_star ~ ., data = train_data, size = 8, linout = FALSE, decay = 0.1, maxit = 400, trace = FALSE)
  
  # Make predictions
  pred_probs <- predict(model, x_test, type = "raw")
  
  preds <- ifelse(pred_probs > 0.5, TRUE, FALSE)
  
  accuracy <- mean(preds == test_data$all_star)
  cat("Test Accuracy:", accuracy, "\n")
  
  output[i] <- accuracy

}

mean(output)




























