# SMO/SVM model helpers.
# e1071::svm uses libsvm-style SVM training; RWeka::SMO can be substituted if WEKA SMO is required.

make_class_weights <- function(y) {
  y <- as.factor(y)
  tab <- table(y)
  weights <- sum(tab) / (length(tab) * tab)
  setNames(as.numeric(weights), names(tab))
}

train_smo_svm <- function(x_train, y_train, kernel = c("linear", "radial"), cost = 1, gamma = NULL,
                          class_weights = TRUE, probability = TRUE) {
  if (!requireNamespace("e1071", quietly = TRUE)) stop("Package e1071 is required.")
  kernel <- match.arg(kernel)
  y_train <- as.factor(y_train)
  weights <- if (isTRUE(class_weights)) make_class_weights(y_train) else NULL
  args <- list(
    x = as.matrix(x_train),
    y = y_train,
    kernel = kernel,
    cost = cost,
    probability = probability,
    class.weights = weights
  )
  if (!is.null(gamma) && kernel == "radial") args$gamma <- gamma
  do.call(e1071::svm, args)
}

predict_smo_svm <- function(model, x_test, positive_class = NULL) {
  pred <- stats::predict(model, as.matrix(x_test), probability = TRUE)
  prob_attr <- attr(pred, "probabilities")
  if (is.null(positive_class)) positive_class <- levels(pred)[1]
  prob <- NULL
  if (!is.null(prob_attr) && positive_class %in% colnames(prob_attr)) {
    prob <- prob_attr[, positive_class]
  }
  data.frame(
    predicted_class = as.character(pred),
    probability_positive = prob,
    stringsAsFactors = FALSE
  )
}
