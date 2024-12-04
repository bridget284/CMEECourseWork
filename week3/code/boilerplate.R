# a boilerplate R script

MyFunction <- function(Arg1, Arg2) {
  # return concatenated arguments to tell used the variable class efficiently
  print(paste("Argument", as.character(Arg1), "is a", class(Arg1)))
  print(paste("Argument", as.character(Arg2), "is a", class(Arg2)))
  return(c(Arg1, Arg2))
}

# use function
MyFunction(1,2)
MyFunction("Riki", "Tiki")
