# R script to Analyze student substance data
# install necessary lib
library(dplyr)
library(tidyr)

student_data <- read.csv("StudentsSubstancesData.csv", check.names = TRUE)

# Question 1
cat("--- Question 1: Dataset Dimension ---\n")
num_variables <= ncol(student_data)
num_cases <- nrow(student_data)
cat("Number of Variables (columns):", num_variables, "\n")
cat("Number of cases (rows):", num_cases, "\n\n")

# Question 2
cat("--- Question 2: Gender Distribution ---\n")
gender_counts <- table(student_data$Gender)
print(gender_counts)
cat("\n")

# Question 3
cat("--- Question 3: Percentage of Undergraduate ---\n")
academic_level_percent <- prop.table(table(student_data$Academic.Level)) * 100
print(academic_level_percent)
cat("\n")

# Question 4
cat("--- Question 4: Percentage of Females among undergradutes ---\n")
undergraduates <- subset(student_data, Academic.Level == "Undergraduate")
undergrad_gender_percent <- prop.table(table(undergraduates$Gender)) * 100
cat("Percentage of gender among Undergraduate students:\n")
cat("\n")

# Question 5
cat("--- Question 5: Male Student Residence (In Session) ---\n")
male_students <- subset(student_data, Gender == "Male")
male_residence_percent <- prop.table(table(male_students$Residence..In.Session.)) * 100
print(sort(male_residence_percent, decreasing = TRUE))

# Question 6













