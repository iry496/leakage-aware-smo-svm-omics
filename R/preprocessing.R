# Preprocessing helpers.
# Rule: fit all data-dependent preprocessing parameters on training data only.

filter_near_zero_variance <- function(x, cutoff = 1e-8) {
  stopifnot(is.matrix(x) || is.data.frame(x))
  vars <- apply(as.matrix(x), 2, stats::var, na.rm = TRUE)
  keep <- which(is.finite(vars) & vars > cutoff)
  list(x = as.matrix(x)[, keep, drop = FALSE], keep_features = colnames(x)[keep])
}

fit_standardizer <- function(x_train) {
  x_train <- as.matrix(x_train)
  center <- colMeans(x_train, na.rm = TRUE)
  scale <- apply(x_train, 2, stats::sd, na.rm = TRUE)
  scale[!is.finite(scale) | scale == 0] <- 1
  list(center = center, scale = scale, features = colnames(x_train))
}

apply_standardizer <- function(x, standardizer) {
  x <- as.matrix(x)
  missing <- setdiff(standardizer$features, colnames(x))
  if (length(missing) > 0) {
    stop("Missing features in data passed to apply_standardizer(): ", paste(missing, collapse = ", "))
  }
  x <- x[, standardizer$features, drop = FALSE]
  sweep(sweep(x, 2, standardizer$center, FUN = "-"), 2, standardizer$scale, FUN = "/")
}

align_features <- function(x_train, x_test) {
  common <- intersect(colnames(x_train), colnames(x_test))
  list(
    train = as.matrix(x_train)[, common, drop = FALSE],
    test = as.matrix(x_test)[, common, drop = FALSE],
    common_features = common
  )
}
