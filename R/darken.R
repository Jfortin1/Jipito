darken <- function (col, factor = 1.4){
    col <- col2rgb(col/factor)
    col <- rgb(t(col), maxColorValue = 255)
    col
}
