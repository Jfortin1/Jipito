getColorFrancis <- function(shade=c("happy", "angry")){
    shade <- match.arg(shade)
    if (shade=="happy"){
        return("firebrick")
    } else {
        return("firebrick4")
    }
}