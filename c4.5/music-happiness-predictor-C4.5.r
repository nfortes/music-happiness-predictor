install.packages("RWeka")

library(RWeka)

X_processed <- read.csv("C:/Users/brand/Documents/STEVENS SCHOOL STUFF/Semester8/music-happiness-predictor/music_attributes.csv", stringsAsFactors = TRUE)
y <- read.csv("C:/Users/brand/Documents/STEVENS SCHOOL STUFF/Semester8/music-happiness-predictor/music_target.csv", stringsAsFactors = TRUE)

# Combine features and target into one dataframe
df <- cbind(X_processed, target = as.factor(y$valence)) 

set.seed(42)
idx <- sample(1:nrow(df), size = 0.7 * nrow(df))
train <- df[idx, ]
test  <- df[-idx, ]

model <- J48(target ~ ., data = train)


summary(model)

# Optional: Predict on test set and evaluate
pred <- predict(model, test)
conf_mat <- table(Predicted = pred, Actual = test$target)
print(conf_mat)


accuracy <- sum(diag(conf_mat)) / sum(conf_mat)
cat(sprintf("Accuracy: %.2f%%\n", accuracy * 100))
