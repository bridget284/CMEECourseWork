# A simple script to illustrate R input-output.
# Run line by line and check inputs outputs to understand what is happening

MyData <- read.csv("../data/trees.csv", header = TRUE) #import with headers
write.csv(MyData, "../results/MyData.csv", row.names=TRUE) #write it as a new file
print("Script complete!")
