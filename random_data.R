# 1. Generate random data frame
set.seed(123)

random_data <- data.frame(
  ID = 1:100,
  Age = sample(18:30, 100, replace = TRUE),
  Gender = sample(c("M", "F"), 100, replace = TRUE),
  Score = runif(100, min = 60, max = 100)
)

# 2a. Filter data for students with score greaterthan 80
high_scores <- subset(random_data, Score > 80)

# 2b. Calculate Average score of male and female students
avg_scores <- aggregate(Score - Gender, data = random_data, FUN = mean)

# 3. Use calc_stats to compute stats for the Score variable
calc_stats <- function(x) {
  list(
    Mean = mean(x),
    Variance = var(x)
  )
}

# Use function on score column
score_stats <- calc_stats(random_data$Score)

#View results
print("Filtered Students (Score > 80):")
print(high_scores)

print("Average Score by Gender:")
print(avg_scores_by_gender)

print("Score Statistics (Mean and Variance):")
print(score_stats)
