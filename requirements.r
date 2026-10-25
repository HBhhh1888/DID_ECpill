# Install packages (R 4.5.2)
# 1. CRAN packages
install.packages(c("tidyverse", "glue", "fixest", "broom", "TwoWayFEWeights", "did", "remotes"))

# 2. If compilation fails (e.g. "emutls_w not found"), install the gfortran toolchain first (macOS)
remotes::install_github("coatless-mac/macrtools")
macrtools::macos_rtools_install()

# 3. fwildclusterboot (from GitHub)
remotes::install_github("s3alfisc/fwildclusterboot")
