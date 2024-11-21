# generate example data
n <- 10000   # Number of observations

data <- data.frame(
  ID = sample(1:10, n, replace = TRUE),  # ID column to define 10 groups
  y = rnorm(n),
  X = rnorm(n)
)

# split data into a list of data sets
library(dplyr)

data_groups <- data %>% group_by(ID) %>% group_split() # Split the data by ID

# Define a function to fit a linear model for each group
fit_model <- function(group_data) {
  model <- lm(y ~ X, data = group_data)
  coef_df <- as.data.frame(t(coef(model)))
  coef_df$ID <- unique(group_data$ID)  # Add ID for reference
  return(coef_df)
}

library(parallel)

num_cores <- detectCores() - 1 # Use all cores but one

results <- mclapply(data_groups, fit_model, mc.cores = num_cores) # Fit the models

final_results <- bind_rows(results) # Bind model outputs from list to table
print(final_results)
