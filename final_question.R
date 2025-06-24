# R Script to Analyze Student Substance Data

# Install and load necessary packages if they are not already installed.
# The 'dplyr' and 'tidyr' packages are used for data manipulation, particularly for question 9.
if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyr")) install.packages("tidyr")

library(dplyr)
library(tidyr)

# Set the working directory to the location of your CSV file, or ensure the CSV is in your current working directory.
# For example: setwd("C:/Users/YourUser/Documents/")

# Load the dataset from the CSV file.
# The 'check.names=TRUE' argument ensures that column names are syntactically valid variable names in R,
# which often involves replacing spaces and special characters with dots.
student_data <- read.csv("StudentsSubstancesData.csv", check.names = TRUE)

# --------------------------------------------------------------------------------------------------

# Question 1: How many variables and cases does the dataset have?
cat("--- Question 1: Dataset Dimensions ---\n")
num_variables <- ncol(student_data)
num_cases <- nrow(student_data)
cat("Number of variables (columns):", num_variables, "\n")
cat("Number of cases (rows):", num_cases, "\n\n")

# --------------------------------------------------------------------------------------------------

# Question 2: The file contains real survey data captured from CUK students. How many of the students were Males and how many were females?
cat("--- Question 2: Gender Distribution ---\n")
gender_counts <- table(student_data$Gender)
print(gender_counts)
cat("\n")

# --------------------------------------------------------------------------------------------------

# Question 3: What percentage of the students were taking Undergraduate degrees?
cat("--- Question 3: Percentage of Undergraduate Students ---\n")
academic_level_percent <- prop.table(table(student_data$Academic.Level)) * 100
cat("Percentage of students in each academic level:\n")
print(academic_level_percent)
cat("\n")

# --------------------------------------------------------------------------------------------------

# Question 4: What percentage of the Undergraduate students were females?
cat("--- Question 4: Percentage of Females among Undergraduates ---\n")
undergraduates <- subset(student_data, Academic.Level == "Undergraduate")
undergrad_gender_percent <- prop.table(table(undergraduates$Gender)) * 100
cat("Percentage of genders among Undergraduate students:\n")
print(undergrad_gender_percent)
cat("\n")

# --------------------------------------------------------------------------------------------------

# Question 5: Where do the male students mostly reside while in session? (Give the percentage)
cat("--- Question 5: Male Student Residence (In Session) ---\n")
male_students <- subset(student_data, Gender == "Male")
male_residence_percent <- prop.table(table(male_students$Residence..In.Session.)) * 100
cat("Percentage distribution of residence for male students (in session):\n")
print(sort(male_residence_percent, decreasing = TRUE))
cat("\n")

# --------------------------------------------------------------------------------------------------


# Question 6: While not in session, what percentage of the students stayed with both parents?
cat("--- Question 6: Residence with Both Parents (Out of Session) ---\n")
out_of_session_residence_percent <- prop.table(table(student_data$Residence..Out.of.Session.)) * 100
cat("Percentage of students who stayed with both parents (out of session):\n")
print(out_of_session_residence_percent["With Both Parents"])
cat("\n")

# --------------------------------------------------------------------------------------------------

# Question 7: Is there an association between gender and where they reside while out of session?
cat("--- Question 7: Association between Gender and Residence (Out of Session) ---\n")
contingency_table_residence <- table(student_data$Gender, student_data$Residence..Out.of.Session.)
chi_test_residence <- chisq.test(contingency_table_residence)
cat("Chi-squared test for association between gender and out-of-session residence:\n")
print(chi_test_residence)
# Interpretation of the result
if (chi_test_residence$p.value < 0.05) {
  cat("Conclusion: Since the p-value is less than 0.05, we reject the null hypothesis. There is a statistically significant association between gender and where students reside out of session.\n\n")
} else {
  cat("Conclusion: Since the p-value is greater than 0.05, we fail to reject the null hypothesis. There is no statistically significant association between gender and where students reside out of session.\n\n")
}

# --------------------------------------------------------------------------------------------------

# Question 8: How many siblings on average did self-sponsored students have?
cat("--- Question 8: Average Siblings for Self-Sponsored Students ---\n")
self_sponsored <- subset(student_data, Sponsorship == "Self-Sponsored")
avg_siblings <- mean(self_sponsored$Number.of.Siblings, na.rm = TRUE)
cat("Average number of siblings for self-sponsored students:", round(avg_siblings, 2), "\n\n")

# --------------------------------------------------------------------------------------------------

# Question 9: What was the source of the money that student spent while in session? Provide a table summary for the average amount from each source.
# Note: This question is interpreted as "What is the average amount spent on substances monthly, grouped by the student's source of money?"
cat("--- Question 9: Average Monthly Substance Spending by Source of Money ---\n")
# Using tidyr and dplyr to reshape the data and calculate the average spending.
money_source_summary <- student_data %>%
  # Select relevant columns
  select(starts_with("Source.of.Money"), Amount.Spent.on.Substances..Monthly.) %>%
  # Convert wide format to long format
  pivot_longer(
    cols = -Amount.Spent.on.Substances..Monthly.,
    names_to = "Source",
    values_to = "Has_Source"
  ) %>%
  # Clean up the source names
  mutate(Source = gsub("Source.of.Money...", "", Source, fixed = TRUE)) %>%
  # Filter for only students who have that source of money
  filter(Has_Source == "YES") %>%
  # Group by the source
  group_by(Source) %>%
  # Calculate the average amount spent
  summarise(Average_Amount_Spent = mean(Amount.Spent.on.Substances..Monthly., na.rm = TRUE))

print(money_source_summary)
cat("\n")


# --------------------------------------------------------------------------------------------------

# Question 10: How many students have ever taken drug(s)?
cat("--- Question 10: Number of Students Who Have Ever Taken Drugs ---\n")
drug_use_counts <- table(student_data$Ever.taken.drug.s.)
cat("Counts of students who have ever taken drugs:\n")
print(drug_use_counts)
cat("Number of students who answered 'Yes':", drug_use_counts["Yes"], "\n\n")

# --------------------------------------------------------------------------------------------------

# Question 11: Is students gender associated with drug/substance abuse?
cat("--- Question 11: Association between Gender and Drug/Substance Abuse ---\n")
contingency_table_drugs <- table(student_data$Gender, student_data$Ever.taken.drug.s.)
chi_test_drugs <- chisq.test(contingency_table_drugs)
cat("Chi-squared test for association between gender and drug abuse:\n")
print(chi_test_drugs)
# Interpretation of the result
if (chi_test_drugs$p.value < 0.05) {
  cat("Conclusion: Since the p-value is less than 0.05, we reject the null hypothesis. There is a statistically significant association between gender and drug/substance abuse.\n")
} else {
  cat("Conclusion: Since the p-value is greater than 0.05, we fail to reject the null hypothesis. There is no statistically significant association between gender and drug/substance abuse.\n")
}

# --------------------------------------------------------------------------------------------------













