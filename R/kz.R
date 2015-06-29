# Kolmogorov-Zurbenko filter (iterative moving average)
kz <- function(x, k=1, iter=1, na.rm=TRUE, optimal=FALSE, tolerance=0.05){

    check.integer <- function(N){
        !grepl("[^[:digit:]]", format(N,  digits = 20, scientific = FALSE))
    }
    if (!check.integer(k) | k<=0 | (k %% 2)==0){
        stop("k must be a strictly positive odd integer")
    }
    stopifnot(is.numeric(x))

    k <- (k-1)/2
    .movingAverage <- function(x, k=1, na.rm=TRUE){
        n <- length(x)
        y <- rep(NA,n)

        window.mean <- function(x, j, k, na.rm=na.rm){
            if (k>=1){
                return(mean(x[(j-(k+1)):(j+k)], na.rm=na.rm))
            } else {
                return(x[j])
            }    
        }

        for (i in (k+1):(n-k)){
            y[i] <- window.mean(x,i,k, na.rm)
        }
        for (i in 1:k){
            y[i] <- window.mean(x,i,i-1, na.rm)
        }
        for (i in (n-k+1):n){
            y[i] <- window.mean(x,i,n-i,na.rm)
        }
        y
    }

    .iterativeMovingAverage <- function(x, k, iter=1, na.rm=TRUE){
        for (i in 1:iter){
            x <- .movingAverage(x, k=k, na.rm=na.rm)
        } 
        x
    }


    .optimalMovingAverage <- function(x, k, na.rm=TRUE){
    
        
    }



    # Iterative part:
    if (k >=1){
        
        if (!optimal){
            x <- .iterativeMovingAverage(x, k=k, na.rm=na.rm, iter=iter)
        } else {
            x <- .optimalMovingAverage(x, k=k, na.rm)
        }
        
    }
    x
}



