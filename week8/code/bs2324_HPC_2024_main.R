# CMEE 2024 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "Bridget Smith"
preferred_name <- "Bridget"
email <- "bs2314@imperial.ac.uk"
username <- "bs2324"

# Please remember *not* to clear the work space here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any auto marking code that may be running and that would be annoying!

# Section One: Stochastic demographic population model

# Question 0

state_initialise_adult <- function(num_stages,initial_size){
  state_vector<-rep(0,num_stages) # create a vector of 0s
  state_vector[num_stages] = initial_size # place all individuals in the last life stage
  return(state_vector)
}

state_initialise_spread <- function(num_stages,initial_size){
  state_vector<-rep(0,num_stages) # create a vector of 0s
  for (i in 1:num_stages) { # evenly split the individuals into the life stages - rounding down if necessary
    state_vector[i] = floor(initial_size/num_stages) 
  }
    rem<-initial_size %% num_stages # find any left over individuals and place them
    if (rem > 0) { 
      for (i in 1:rem) {
        state_vector[i] = state_vector[i] + 1
      }
  }
  return(state_vector)
}

# Question 1
source("Demographic.R")
question_1 <- function(){
  growth_matrix <- matrix(c(0.1,0.0,0.0,0.0, # growth matrix
                            0.5,0.4,0.0,0.0,
                            0.0,0.4,0.7,0.0,
                            0.0,0.0,0.25,0.4),
                          nrow=4, ncol=4, byrow = T)
  reproduction_matrix<-matrix(c(0.0,0.0,0.0,2.6, # reproduction matrix
                                0.0,0.0,0.0,0.0,
                                0.0,0.0,0.0,0.0,
                                0.0,0.0,0.0,0.0),
                              nrow=4, ncol=4, byrow=T)
  projection_matrix = reproduction_matrix + growth_matrix # projection matrix
  
  # set up initial values
  simulation_length = 24
  population_size <-matrix(0, nrow = simulation_length + 1, ncol = 2)
  initial_state = state_initialise_adult(4,100)
  
  # run simulation and record population sizes
  population<- deterministic_simulation(initial_state,projection_matrix,simulation_length)
  population<- cbind(population, zeros=0)
  # run simulation for second ICs
  initial_state = state_initialise_spread(4,100)
  population[,2]<- deterministic_simulation(initial_state,projection_matrix,simulation_length)
  
  # make and save a graph
  index_vector <- seq(1, nrow(population))
  png(filename="../results/question_1.png", width = 600, height = 400)
  #plot(index_vector, population)
  # Plot the first column as a line
  plot(index_vector, population[, 1], type = "l", col = "blue", lwd = 2, 
       xlab = "Time", ylab = "Population Size")
  
  # Add the second column as another line
  lines(index_vector, population[, 2], col = "red", lwd = 2)
  
  # Add a legend for clarity
  legend("topleft", legend = c("All Adults", "Spread"), col = c("blue", "red"), lwd = 2, bty="n")
  
  Sys.sleep(0.1)
  dev.off()
  
  return("When the initial population is all adults, the initial population growth is very high, but then peaks and declines as the adults begin to die out. 
         After around 6 time steps the population begins to steadily increase. When the population is spread through all life stages, there is a similar pattern although it is far less extreme. 
         There is a period of population growth then a slight decline before settling back into a slow increase for the rest of time.
         At longer times the population growth between the two initial conditions is very similar, although the all-adults population has a higher population due to the high initial growth.")
}

# Question 2
source("Demographic.R")
question_2 <- function(){
  growth_matrix <- matrix(c(0.1,0.0,0.0,0.0, # growth matrix
                            0.5,0.4,0.0,0.0,
                            0.0,0.4,0.7,0.0,
                            0.0,0.0,0.25,0.4),
                          nrow=4, ncol=4, byrow = T)
  reproduction_matrix<-matrix(c(0.0,0.0,0.0,2.6, # reproduction matrix
                                0.0,0.0,0.0,0.0,
                                0.0,0.0,0.0,0.0,
                                0.0,0.0,0.0,0.0),
                              nrow=4, ncol=4, byrow=T)
  
  
  # set up initial values
  simulation_length = 24
  initial_state = state_initialise_adult(4,100)
  clutch_distribution <- c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)
  
  # run simulation and record population sizes
  population<- stochastic_simulation(initial_state, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length)
  population<- cbind(population, zeros=0)
  # run simulation for second ICs
  initial_state = state_initialise_spread(4,100)
  population[,2]<- stochastic_simulation(initial_state, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length)
  
  # make and save a graph
  index_vector <- seq(1, nrow(population))
  png(filename="../results/question_2.png", width = 600, height = 400)
  #plot(index_vector, population)
  # Plot the first column as a line
  plot(index_vector, population[, 1], type = "l", col = "blue", lwd = 2, 
       xlab = "Time", ylab = "Population Size")
  
  # Add the second column as another line
  lines(index_vector, population[, 2], col = "red", lwd = 2)
  
  # Add a legend for clarity
  legend("topleft", legend = c("All Adults", "Spread"), col = c("blue", "red"), lwd = 2, bty="n")
  
  Sys.sleep(0.1)
  dev.off()
  return("The deterministic simulation is smoother as it is less random, the stochastic simulations have an element of randomness causing them to change every time.")
}

# Questions 3 and 4 involve writing code elsewhere to run your simulations on the cluster


# Question 5
question_5 <- function(){
  
  # create list 
  results<-list()
  
  # read in data, into a list of 15000 simulations of 121 values
  for (i in 1:100) {
    filename <- paste0("/home/bridget-smith/Documents/CMEECourseWork/week8/data/output_", i, ".rda")
    load(filename)
    results<-append(results, population)
  }
  
  
  # finds the number of simulations that go extinct, for each IC
  extinction = c(0,0,0,0)
  for (i in 1:3750) {
    if (results[[i]][121] == 0) {
      extinction[1] = extinction[1] + 1
    }
  }
  
  for (i in 3751:7500) {
    if (results[[i]][121] == 0) {
      extinction[2] = extinction[2] + 1
    }
  }
  
  for (i in 7501:11250) {
    if (results[[i]][121] == 0) {
      extinction[3] = extinction[3] + 1
    }
  }
  
  for (i in 11251:15000) {
    if (results[[i]][121] == 0) {
      extinction[4] = extinction[4] + 1
    }
  }
  
  # get extinction as a proportion
  extinction <- extinction/3750
  
  # make data frame for plotting with
  catagories <- c("adults, large population", "adults, small population", "spread, large population", "spread, small population")
  data<-data.frame(
    name=catagories,
    value=extinction
  )
  
  # plot graph
  png(filename="../results/question_5.png", width = 600, height = 400)
  require(ggplot2)
  ggplot(data, aes(x=name, y=value)) + 
    geom_bar(stat = "identity", fill = "darkblue") +
    labs(y = "Proportion of populations resulting in extinction") +
    theme_classic() +
    theme(panel.grid = element_blank(), axis.title.x = element_blank() ) +
    scale_y_continuous(limits = c(0, 0.16), expand = c(0, 0))

  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 6
question_6 <- function(){
  
  # source other files
  source("Demographic.R")
  
  
  
  
  ### find stochastic results
  # create list 
  results<-list()
  
  # read in data, into a list of 15000 simulations of 121 values
  for (i in 51:100) {
    filename <- paste0("/home/bridget-smith/Documents/CMEECourseWork/week8/data/output_", i, ".rda")
    load(filename)
    results<-append(results, population)
  }
  
  # find average population for each time step for the two ICs of stochastic simulations
  large_stoch<-rep(0,121)
  for (i in 1:3750){
    large_stoch <- large_stoch + results[[i]]
  }
  large_stoch <- large_stoch/3750
  
  small_stoch<-rep(0,121)
  for (i in 3751:7500){
    small_stoch <- small_stoch + results[[i]]
  }
  small_stoch <- small_stoch/3750
  
  
  
  
  ### find deterministic results
  # find population for each time step for the two ICs of deterministic simulations
  growth_matrix <- matrix(c(0.1,0.0,0.0,0.0, # growth matrix
                            0.5,0.4,0.0,0.0,
                            0.0,0.4,0.7,0.0,
                            0.0,0.0,0.25,0.4),
                          nrow=4, ncol=4, byrow = T)
  reproduction_matrix<-matrix(c(0.0,0.0,0.0,2.6, # reproduction matrix
                                0.0,0.0,0.0,0.0,
                                0.0,0.0,0.0,0.0,
                                0.0,0.0,0.0,0.0),
                              nrow=4, ncol=4, byrow=T)
  projection_matrix = reproduction_matrix + growth_matrix # projection matrix
  
  # set up initial values
  simulation_length = 120
  initial_state = state_initialise_spread(4,100)
  
  # run simulation and record population sizes
  large_det <- deterministic_simulation(initial_state,projection_matrix,simulation_length)
  
  # run simulation for second ICs
  initial_state = state_initialise_spread(4,10)
  small_det<- deterministic_simulation(initial_state,projection_matrix,simulation_length)
  
  
  
  
  ### find deviation between stochasic and deterministic results, and plot
  large_final <- large_stoch/large_det
  small_final <- small_stoch/small_det
  
  index_vector <- seq(1, 121)
  
  # create png file
  png(filename="../results/question_6.png", width = 600, height = 400)
  
  # Plot the first column as a line
  plot(index_vector, small_final, type = "l", col = "red", lwd = 2, 
       xlab = "Time", ylab = "Deviation", main = "Stochastic and Deterministic Simulation Deviation")
  
  # Add the second column as another line
  lines(index_vector, large_final, col = "blue", lwd = 2)
  
  # Add a legend for clarity
  legend("bottomright", legend = c("Large Population", "Small Population"), col = c("blue", "red"), lwd = 2, bty="n")

  # close png
  Sys.sleep(0.1)
  dev.off()
  
  return("It is more approriate to approximate the average behaviour of this stochastic simulation with a large population, as there is a much smaller deviation from the deterministic model when a large population is modelled.")
}


# Section Two: Individual-based ecological neutral theory simulation 

# Question 7
species_richness <- function(community){
  output <- length(unique(community))
  return(output)
}

# Question 8
init_community_max <- function(size){
  initial_state <- seq(from = 1, to = size)
  return(initial_state)
}

# Question 9
init_community_min <- function(size){
  initial_state <- rep(1, size)
  return(initial_state)
}

# Question 10
choose_two <- function(max_value){
  vector <- seq(from=1, to=max_value)
  output <- sample(vector, 2, replace=FALSE)
  return(output)
}

# Question 11
neutral_step <- function(community){ # replace one individual with 'offspring' of another
  choice <- choose_two(length(community))
  community[choice[2]] <- community[choice[1]]
  return(community)
}

# Question 12
neutral_generation <- function(community){
  if (length(community) %% 2 ==0){ # if there is an even number of individuals, divide by 2
    len <- length(community)/2
  } else { # if there is an odd number of individuals, 50-50 probability of rounding up (always rounded up but 50% chance of -1 after)
    len <- round(length(community)/2)
    rand <- sample(c(0, -1), size = 1, prob = c(0.5, 0.5))
    len <- len + rand
  }
  
  for (i in 1:len){
   community <- neutral_step(community)
  }
  return(community)
}

# Question 13
neutral_time_series <- function(community,duration)  {
  richness_series <- rep(0,duration+1)
  richness_series[1] <- species_richness(community)
  for (i in 1:duration){
    community <- neutral_generation(community)
    richness_series[i+1] <- species_richness(community)
  }
  return(richness_series)
}

# Question 14
question_14 <- function() {
  community <- init_community_max(100)
  duration = 200
  richness_series <- neutral_time_series(community, duration)
  index_vector <- seq(1, duration + 1)
  
  # create png file and plot graph
  png(filename="../results/question_14.png", width = 600, height = 400)
  plot(index_vector, richness_series, type = "l", col = "purple", lwd = 2, 
       xlab = "Generation", ylab = "Species Richness")
  Sys.sleep(0.1)
  dev.off()
  
  return("The system will always eventually converge to a species richness of 1.
         This is because there is no way of species being introduced in this model so they will always die out eventually until one species is left.")
}

# Question 15
neutral_step_speciation <- function(community,speciation_rate)  {
  rand <- sample(c(0, 1), size = 1, prob = c(speciation_rate, 1 - speciation_rate))
  choice <- choose_two(length(community))
  if (rand == 1){
    community[choice[2]] <- community[choice[1]]  
  } else {
    new_species <- max(community) +1
    community[choice[2]] <- new_species
  }
  return(community)
}

# Question 16
neutral_generation_speciation <- function(community,speciation_rate)  {
  if (length(community) %% 2 ==0){ # if there is an even number of individuals, divide by 2
    len <- length(community)/2
  } else { # if there is an odd number of individuals, 50-50 probability of rounding up (always rounded up but 50% chance of -1 after)
    len <- round(length(community)/2)
    rand <- sample(c(0, -1), size = 1, prob = c(0.5, 0.5))
    len <- len + rand
  }
  
  for (i in 1:len){
    community <- neutral_step_speciation(community, speciation_rate)
  }
  return(community)
}

# Question 17
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  richness_series <- rep(0,duration+1)
  richness_series[1] <- species_richness(community)
  for (i in 1:duration){
    community <- neutral_generation_speciation(community, speciation_rate)
    richness_series[i+1] <- species_richness(community)
  }
  return(richness_series)
}

# Question 18
question_18 <- function()  {
  
  png(filename="question_18", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 19
species_abundance <- function(community)  {
  
}

# Question 20
octaves <- function(abundance_vector) {
  
}

# Question 21
sum_vect <- function(x, y) {
  if (length(x) > length(y)) {
    tmp <- x
    x <- y
    y <- tmp
  }
  
  diff = length(y) - length(x)
  if (diff != 0) {
    for (i in 1:diff){
      x <- c(x,0)
    }
  }
  z = x+y
  return(z)
}



# Question 22
question_22 <- function() {
  
  png(filename="question_22", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 23
neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
    
}

# Questions 24 and 25 involve writing code elsewhere to run your simulations on
# the cluster

# Question 26 
process_neutral_cluster_results <- function() {
  
  
  combined_results <- list() #create your list output here to return
  # save results to an .rda file
  
}

plot_neutral_cluster_results <- function(){

    # load combined_results from your rda file
  
    png(filename="plot_neutral_cluster_results", width = 600, height = 400)
    # plot your graph here
    Sys.sleep(0.1)
    dev.off()
    
    return(combined_results)
}


# Challenge questions - these are substantially harder and worth fewer marks.
# I suggest you only attempt these if you've done all the main questions. 

# Challenge question A
Challenge_A <- function(){
  
  png(filename="Challenge_A", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
}

# Challenge question B
Challenge_B <- function() {
  
  png(filename="Challenge_B", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
}

# Challenge question C
Challenge_B <- function() {
  
  png(filename="Challenge_C", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()

}

# Challenge question D
Challenge_D <- function() {
  
  png(filename="Challenge_D", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
}

# Challenge question E
Challenge_E <- function() {
  
  png(filename="Challenge_E", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

