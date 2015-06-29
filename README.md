# Jipito
Personal R package

### Why
I want to share pieces of code that I find really useful/cool


#### Kolmogorov-Zurbenko filter (Iterative moving average) : [kz.R](https://github.com/Jfortin1/Jipito/blob/master/R/kz.R)

I like this filter a lot and used it in my [recent paper](http://biorxiv.org/content/early/2015/06/03/019000) to smooth the first eigenvector of several genomic matrices. It's simple (`k` iterations of a simple moving average), fast and the degree of smoothness can be tuned easily -- the number of iterations (`k`) controls the smoothness. In order to choose what would be a reasonable value of `k`, I implemented an intuitive optimal criterion. Basically, I want the iterative process to stop at `k` iterations when the difference between the (k+1)-th and the k-th smoothed vectors is less than a specified threshold. I quantify difference as the sums of squares of the difference vector, i.e. SS(x_(k+1)-x_k), divided by the sum of squares of the k-th vector, that is SS(x_k). If the difference is less than the parameter `tolerance`, set by default to 0.05, then the iterative process stops.  Below is an example of a vector before and after smoothing with an optimal number of iterations k=2.

```{r}
library(jipito)
mybarplot(x)
mybarplot(kz(x, w=3, optimal=TRUE))
```
![alt tag](https://raw.github.com/jfortin1/Jipito/master/figures/kz.png)


