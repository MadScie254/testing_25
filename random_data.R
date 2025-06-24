# Set seed for reproducibility
set.seed(123)

# Step 1: Create random_data correctly
random_data <- data.frame(
  ID = 1:100,
  Age = sample(18:30, 100, replace = TRUE),
  Gender = sample(c("M", "F"), 100, replace = TRUE),
  Score = runif(100, min = 60, max = 100)
)

# Step 2a: Filter students with Score > 80
high_scores <- subset(random_data, Score > 80)

# Step 2b: Average score by gender
avg_scores_by_gender <- aggregate(Score ~ Gender, data = random_data, FUN = mean)

# Step 3: Custom stats function
calc_stats <- function(x) {
  list(
    Mean = mean(x),
    Variance = var(x)
  )
}

# Use function on Score column
score_stats <- calc_stats(random_data$Score)

# Print results
print("Filtered students with Score > 80:")
print(high_scores)

print("Average Score by Gender:")
print(avg_scores_by_gender)

print("Statistics for Score (Mean & Variance):")
print(score_stats)
