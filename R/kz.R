# Kolmogorov-Zurbenko filter (kative moving average)
# w: width of the window
# k: number of iterations
kz <- function(x, w=3, k=1, na.rm=TRUE, optimal=FALSE, tolerance=0.05, verbose=TRUE){

    check.integer <- function(N){
        !grepl("[^[:digit:]]", format(N,  digits = 20, scientific = FALSE))
    }
    if (!check.integer(w) | w<=0 | (w %% 2)==0){
        stop("w must be a strictly positive odd integer")
    }
    stopifnot(is.numeric(x))

    w <- (w-1)/2
    .movingAverage <- function(x, w=1, na.rm=TRUE){
        n <- length(x)
        y <- rep(NA,n)

        window.mean <- function(x, j, w, na.rm=na.rm){
            if (w>=1){
                return(mean(x[(j-(w+1)):(j+w)], na.rm=na.rm))
            } else {
                return(x[j])
            }    
        }

        for (i in (w+1):(n-w)){
            y[i] <- window.mean(x,i,w, na.rm)
        }
        for (i in 1:w){
            y[i] <- window.mean(x,i,i-1, na.rm)
        }
        for (i in (n-w+1):n){
            y[i] <- window.mean(x,i,n-i,na.rm)
        }
        y
    }

    .iterativeMovingAverage <- function(x, w, k=1, na.rm=TRUE){
        for (i in 1:k){
            x <- .movingAverage(x, w=w, na.rm=na.rm)
        } 
        x
    }


    .optimalMovingAverage <- function(x, w, na.rm=TRUE){
        continue <- TRUE
        k <- 0
        xs <- list()
        xs[[1]] <- x
        while (continue){
            k <- k+1
            xs[[k+1]] <- .movingAverage(xs[[k]], w=w, na.rm = na.rm)
            diff <- sum((xs[[k+1]]-xs[[k]])^2)/sum(xs[[k]]^2)
            if (diff < tolerance){
                continue  <- FALSE
            }
        }
        if (verbose){
            cat(paste0("Optimal number of iterations: ", k-1, "\n"))
        }
        return(xs[[k]])
    }



    # Iterative part:
    if (w >=1){
        
        if (!optimal){
            x <- .iterativeMovingAverage(x, w=w, na.rm=na.rm, k=k)
        } else {
            x <- .optimalMovingAverage(x, w=w, na.rm)
        }
        
    }
    x
}



