# CMEE 2024 HPC exercises R code pro forma
# For stochastic demographic model cluster run

rm(list=ls()) # good practice 
source("Demographic.R")
source("bs2324_HPC_2024_main.R")

# find job number and set seed
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
set.seed(iter)


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
  simulation_length = 120
  clutch_distribution <- c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)
  
  # find which ICs to use
  if (iter>=1 && iter<=25){
    initial_state <-state_initialise_adult(4,100)
  } else if (iter>25 && iter<=50) {
    initial_state <- state_initialise_adult(4,10)
  } else if (iter>50 && iter<=75) {
    initial_state <- state_initialise_spread(4,100)
  } else if (iter>75 && iter<=100) {
    initial_state <- state_initialise_spread(4,10)
  }
  
  # run simulation and find the population size after 10 years for each of 150 runs
  population <- list()
  for (i in 1:150) {
    # run simulation and record population sizes
    population[[i]]<- stochastic_simulation(initial_state, growth_matrix, reproduction_matrix, clutch_distribution, simulation_length)
  }

  # save output and remove objects from work-space
  save(population, file=paste("output_",iter,".rda",sep=""))
  rm(population, iter)
  

