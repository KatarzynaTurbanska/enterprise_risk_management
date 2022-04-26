library(mltools)
library(data.table)
cocoa <- read.csv('cocoa_close.csv')
milk <- read.csv('milk_close.csv')
sugar <- read.csv('sugar_close.csv')

dt <- data.table(cocoa, milk, sugar)
colnames(dt) <- c('x','y','z')

1 - empirical_cdf(dt, ubounds = data.table(x = 0, y = 0, z=0))


