# Reassessing the Effects of the Emergency Contraceptive Pill on Children and Women in Chile: Do Current DID Methods Change Results?

This repository contains the analysis code for my honours thesis at Monash University (ETC5860). In this project, I reassess the findings of Bentancor and Clarke (2017), who use a two-way fixed effects (TWFE) regression to estimate the effect of staggered municipal-level access to the emergency contraceptive (EC) pill in Chile on birth rates and early-gestation foetal deaths.

This project asks whether those TWFE conclusions are robust to modern staggered-adoption difference-in-differences (DID) methods:

- **De Chaisemartin and D'Haultfoeuille (2020)** diagnostic tools, to assess whether the original TWFE estimates are vulnerable to the negative-weighting problem in staggered-adoption designs.
- **Callaway and Sant'Anna (2021)**, a staggered-adoption-consistent estimator that allows for heterogeneous and dynamic treatment effects, used here as an alternative to TWFE.

## Repository Structure

The repository is structured as follows:

```
DID_ECpill/
├── DID_ECpill.qmd     # Main analysis file (Quarto, R)
├── Data/              # Input data (see Data Source below)
├── Output/            # CSV results produced by rendering DID_ECpill.qmd
├── .gitignore         # Git ignore file
└── README.md          # This file
```

## Analysis Overview

The analysis is organised into the following stages:

1. **Data Preprocessing** — loads the raw birth and foetal-death records and aggregates them into a municipality-by-year panel, separately for three age groups (all women 15–49, teenagers 15–19, young adults 20–34).
2. **Stage 1: TWFE Replication + De Chaisemartin & D'Haultfoeuille (2020) Diagnostics** — replicates the original TWFE specifications (baseline, municipality trends, population-weighted), computes the dCDH negative-weighting diagnostics, and runs two spillover robustness checks (regression-based and sample-restriction-based).
3. **Stage 2: DID using Callaway & Sant'Anna (2021) Methods** — re-estimates TWFE on a switcher-excluded restricted sample (to isolate the effect of the estimation method from the effect of the sample restriction), estimates the Callaway and Sant'Anna model on the same restricted sample, and extracts pre-treatment dynamic effects as a placebo-style parallel-trends check.
4. **Comparison of Results** — builds the three-way comparison table (original TWFE / restricted TWFE / Callaway and Sant'Anna) that is the main empirical output of this project.

Each stage writes its results to a corresponding CSV file in `Output/`.

## Data Source

The data used in this project is the publicly available replication package for Bentancor and Clarke (2017), from <https://github.com/damiancclarke/morning-after-pill>. Two files are used and included in the `Data/` directory:

- `S1Data_granular_covars.csv` — birth-level records
- `S1Data_deaths_covars.csv` — foetal-death-level records

Note that the public replication data covers 2006–2011, one year short of the original paper's 2006–2012 sample, so the baseline TWFE coefficients reported here do not reproduce the original paper's coefficients exactly.

## Pipeline

All analysis code is contained in `DID_ECpill.qmd`, so the pipeline is straightforward:

Step 1: Clone the repository:

```bash
git clone https://github.com/HBhhh1888/DID_ECpill.git
cd DID_ECpill
```

Step 2: Uncomment and run the package installation code in `DID_ECpill.qmd` if you have not installed these packages:

```r
# Install packages
# 1. Regular CRAN packages
install.packages(c("tidyverse", "purrr", "tibble", "fixest", "broom", "TwoWayFEWeights", "did", "remotes"))

# 2. summclust (removed from CRAN, install via r-universe)
install.packages("summclust", repos = "https://s3alfisc.r-universe.dev")

# 3. If compilation fails (e.g. "emutls_w not found"), install gfortran toolchain first
remotes::install_github("coatless-mac/macrtools")
macrtools::macos_rtools_install()

# 4. fwildclusterboot (from GitHub)
remotes::install_github("s3alfisc/fwildclusterboot")
```

Step 3: Run the analysis by rendering the Quarto document.

- Open `DID_ECpill.qmd` in RStudio and run all chunks, or
- Render it from the command line using Quarto:

```bash
quarto render DID_ECpill.qmd
```

After these three steps, the rendered output of `DID_ECpill.qmd` will contain the full set of results, which are also saved as CSV files in the `Output/` directory.
