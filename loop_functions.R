#loop functions

  x <- list(a=1:5, b=rnorm(10))
  lapply(x, mean)
  
  
x <- list(a=1:4, b=rnorm(20, 1), c=rnorm(20,1), d=rnorm(100,5))
lapply(x, mean)
  
x <- 1:4
lapply(x, runif)

x <- 1:4
lapply(x, runif, min=0, max=10)

x <- list(a=matrix(1:4, 2,2), b=matrix(1:6, 3,2))
lapply(x, function(elt) elt[,1])


#/* sapply */
x <- list(a=1:4, b=rnorm(20, 1), c=rnorm(20,1), d=rnorm(100,5))
sapply(x, mean)


# apply
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)
apply(x, 1, sum)
#specialized apply functions similar to using apply above
rowSums(x)
colSums(x)
rowMeans(x)
colMeans(x)

apply(x, 1, quantile, probs=c(0.25, 0.75)) #quantiles of rows
apply(x, 2, quantile, probs=c(0.25, 0.75)) #quantiles of columns

a <- array(rnorm(2*2*10), c(2,2,10))
apply(a,c(1,2), mean)
rowMeans(a, dims=2) #this gets the same result as apply in above line