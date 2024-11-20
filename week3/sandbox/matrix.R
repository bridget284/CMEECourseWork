#### plotting a matrix
require(reshape2)

# make a matrix that has N^2 vales, in NxN form, runif makes a uniform 
# distribution of random numbers between 0 and 1
GenerateMatrix <- function(N){
  M <- matrix(runif(N * N), N, N)
  return(M)
}

M <- GenerateMatrix(10)
Melt <- melt(M) # creates a table for M, column 1 is i, 2 is j, 3 is M(i,j) 
#plot this
p <- ggplot(Melt, aes(Var1, Var2, fill = value)) + geom_tile() + theme(aspect.ratio = 1)
p

#remove legend and add black lines
p + geom_tile(colour = "black") + theme(legend.position = "none") + theme(aspect.ratio = 1)
# change colour
p + scale_fill_continuous(low = "yellow", high = "darkgreen")







# plotting two data frames together

#build an ellipse
build_ellipse <- function(hradius, vradius){ # function that returns an ellipse
  npoints = 250
  a <- seq(0, 2 * pi, length = npoints + 1)
  x <- hradius * cos(a)
  y <- vradius * sin(a)  
  return(data.frame(x = x, y = y))
}

# build matrix and find e values
N <- 250 # Assign size of the matrix
M <- matrix(rnorm(N * N), N, N) # Build the matrix
eigvals <- eigen(M)$values # Find the eigenvalues
eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals)) # Build a dataframe
my_radius <- sqrt(N) # The radius of the circle is sqrt(N)
ellDF <- build_ellipse(my_radius, my_radius) # Dataframe to plot the ellipse
names(ellDF) <- c("Real", "Imaginary") # rename the columns

#plotting
# plot the eigenvalues
p <- ggplot(eigDF, aes(x = Real, y = Imaginary))
p <- p +
  geom_point(shape = I(3)) +
  theme(legend.position = "none")
# now add the vertical and horizontal line
p <- p + geom_hline(aes(yintercept = 0))
p <- p + geom_vline(aes(xintercept = 0))
# finally, add the ellipse
p <- p + geom_polygon(data = ellDF, aes(x = Real, y = Imaginary, alpha = 1/20, fill = "red"))
p

