# Setup script for leakage-aware SMO/SVM omics audit.
# Technical reproducibility: ensure required CRAN and Bioconductor packages
# are installed before running the pilot scripts or rendering the notebook.
# This does not change any analysis design, model logic, metrics, feature
# selection, or validation structure.

source("environment/packages.R")

# Required CRAN packages for the pilot pipelines and notebook render.
required_cran <- c(
  "caret",
  "e1071",
  "kernlab",
  "pROC",
  "PRROC",
  "quarto",
  "yaml"
)

# Required Bioconductor packages (installed via BiocManager).
required_bioc <- c(
  "GEOquery",
  "Biobase",
  "statmod"
)

# Install any missing CRAN packages (uses helper from environment/packages.R).
install_if_missing(required_cran)

# Ensure BiocManager is available, then install any missing Bioconductor packages.
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
for (pkg in required_bioc) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg, ask = FALSE, update = FALSE)
  }
}

sessionInfo()
