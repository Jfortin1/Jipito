# Jipito
My personal R package

##### Software status

| Resource:      | Travis CI     |
| -------------  |  ------------- |
| Platform:      | Linux    |
| R CMD check    | <a href="https://travis-ci.org/Jfortin1/Jipito"><img src="https://travis-ci.org/Jfortin1/Jipito.svg?branch=master" alt="Build status"></a> |

### Why
Because I want to share pieces of code that are helpful to me. 


#### Kolmogorov-Zurbenko filter (Iterative moving average) : [kz.R](https://github.com/Jfortin1/Jipito/blob/master/R/kz.R)

I like this filter quite a lot and used it in my [recent paper](http://biorxiv.org/content/early/2015/06/03/019000) to smooth eigenvectors from several genomic matrices. It's simple (`k` iterations of a simple moving average), fast and the degree of smoothness can be tuned easily. The two main parameters are:

* `k`: number of iterations (`k`). Should be based on prior information if possible
* `w`: smoothing window width (odd integer number).
* `optimal`: should the optimality criterion discussed below be used? If set to `TRUE`, then `k` does not need to be specified since it will be chosen optimally.

In order to pick a reasonable number of iterations,  I implemented an intuitive optimality criterion. Basically, I want the iterative process to stop at `k` iterations when the difference between the (k+1)-th and the k-th smoothed vectors is less than a specified threshold. I quantify difference as the sums of squares of the difference vector, i.e. SS(x_(k+1)-x_k), divided by the sum of squares of the k-th vector, that is SS(x_k). If the difference is less than the parameter `tolerance`, set by default to 0.05, then the iterative process stops.  Below is an example of a vector before and after smoothing with an optimal number of iterations k=2.

```{r}
library(jipito)
mybarplot(x)
mybarplot(kz(x, w=3, optimal=TRUE))
```
![alt tag](https://raw.github.com/jfortin1/Jipito/master/figures/kz.png)


