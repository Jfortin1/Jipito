# Jipito
Personal R package

### Why
I want to share pieces of code that I find really useful/cool

### What

#### Kolmogorov-Zurbenko filter (Iterated moving average) : [kz.R](https://github.com/Jfortin1/Jipito/blob/master/R/kz.R)

I like this filter a lot and used it in my [recent paper](http://biorxiv.org/content/early/2015/06/03/019000) to smooth the first eigenvector of several genomic matrices. It's simple (`k` iterations of a simple moving average), fast and the degree of smoothness can be tuned easily -- the number of iterations (`k`) controls the smoothness. In order to choose what would be a reasonable value of `k`, I implemented an intuitive optimal criterion. Basically, I want the iterative process to stop at `k` iterations when the difference between the `(k+1)`-th and the `k`-th smoothed vectors is less than a specified threshold. 

the iterative process will stop when the difference between the k-th iteration and the `(k-1)`-th iteration  `tolerance` parameter, set by default to `0.05`,  
