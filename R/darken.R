darken <- function (col, factor = 1.4){
    col <- col2rgb(col)
    col <- col/factor
    col <- rgb(t(col), maxColorValue = 255)
    col
}
