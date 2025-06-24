# Step 1: Generate random normal distribution vector
rvec1 <- round(rnorm(200, mean = 80, sd = sqrt(20)))

# Step 2: Generate uniform distribution vector based on rvec1's range
min_val <- min(rvec1)
max_val <- max(rvec1)
possible_values <- min_val:max_val
rvec2 <- sample(possible_values, 200, replace = TRUE)

# Step 3: Create scatterplot
plot(rvec1, rvec2, 
     main = "Scatterplot of rvec1 vs rvec2",
     xlab = "rvec1", ylab = "rvec2",
     pch = 19, col = "#4682B4")

# Step 4: Create frequency tables and compare unique elements
tableA <- table(rvec1)
tableB <- table(rvec2)
more_unique <- ifelse(length(tableA) > length(tableB), 
                      "rvec1 has more unique elements", 
                      "rvec2 has more unique elements")

# Step 5: Extract 20th element frequencies and compare
freq20th <- c(tableA[[20]], tableB[[20]])
larger_freq <- ifelse(freq20th[1] > freq20th[2], 
                      "tableA has larger frequency", 
                      "tableB has larger frequency")