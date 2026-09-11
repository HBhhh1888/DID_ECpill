# Reassessing the Effects of the Emergency Contraceptive Pill on Children and Women in Chile: Do Current DID Methods Change Results?

This repository contains the analysis code for an honours thesis (Monash University, ETC4860/ETC5860) that reassesses Bentancor and Clarke (2017), *"Assessing Plan B: The Effect of the Morning After Pill on Children and Women,"* *The Economic Journal* 127(607):2525–2552.

The original paper uses a two-way fixed effects (TWFE) regression to estimate the effect of staggered municipal-level access to the emergency contraceptive (EC) pill in Chile (2008–2012) on birth rates and early-gestation foetal deaths. This project asks whether those TWFE conclusions are robust to modern staggered-adoption difference-in-differences (DID) methods:

- **De Chaisemartin and D'Haultfoeuille (2020)** diagnostic tools, to assess whether the original TWFE estimates are vulnerable to the negative-weighting problem in staggered-adoption designs.
- **Callaway and Sant'Anna (2021)**, a staggered-adoption-consistent estimator that allows for heterogeneous and dynamic treatment effects, used here as an alternative to TWFE.

## Repository Structure

```
├── DID_ECpill.qmd     # Main analysis file (Quarto, R)
├── Data/              # Input data (see Data Source below)
├── Output/            # CSV results produced by the analysis, one file per analysis stage
└── README.md
```

## Analysis Overview

The analysis is organised into the following stages:

1. **Data Preprocessing** — loads the raw birth and foetal-death records and aggregates them into a municipality-by-year panel, separately for three age groups (all women 15–49, teenagers 15–19, young adults 20–34).
2. **Stage 1: TWFE Replication + De Chaisemartin & D'Haultfoeuille (2020) Diagnostics** — replicates the original TWFE specifications (baseline, municipality trends, population-weighted), computes the dCDH negative-weighting diagnostics, and runs two spillover robustness checks (regression-based and sample-restriction-based).
3. **Stage 2: DID using Callaway & Sant'Anna (2021) Methods** — re-estimates TWFE on a switcher-excluded restricted sample (to isolate the effect of the estimation method from the effect of the sample restriction), estimates the Callaway and Sant'Anna model on the same restricted sample, and extracts pre-treatment dynamic effects as a placebo-style parallel-trends check.
4. **Comparison of Results** — builds the three-way comparison table (original TWFE / restricted TWFE / Callaway and Sant'Anna) that is the main empirical output of this project.

Each stage writes its results to a corresponding CSV file in `Output/`.

## Data Source

The data used in this project is the publicly available replication package for Bentancor and Clarke (2017), from <https://github.com/damiancclarke/morning-after-pill>. Two files are used:

- `S1Data_granular_covars.csv` — birth-level records
- `S1Data_deaths_covars.csv` — foetal-death-level records

Note that the public replication data covers 2006–2011, one year short of the original paper's 2006–2012 sample, so the baseline TWFE coefficients reported here do not reproduce the original paper's coefficients exactly.

## Requirements

This project uses R. The required packages are listed and installed at the top of `DID_ECpill.qmd`:

```r
install.packages(c("tidyverse", "purrr", "tibble", "fixest", "broom", "TwoWayFEWeights", "did", "remotes"))
remotes::install_github("s3alfisc/fwildclusterboot")
```

## Running the Analysis

Render `DID_ECpill.qmd` with [Quarto](https://quarto.org/):

```bash
quarto render DID_ECpill.qmd
```

## References

- Bentancor, A. and Clarke, D. (2017). Assessing Plan B: The Effect of the Morning After Pill on Children and Women. *The Economic Journal*, 127(607), 2525–2552.
- Callaway, B. and Sant'Anna, P. H. (2021). Difference-in-differences with multiple time periods. *Journal of Econometrics*, 225(2), 200–230.
- De Chaisemartin, C. and D'Haultfoeuille, X. (2020). Two-way fixed effects estimators with heterogeneous treatment effects. *American Economic Review*, 110(9), 2964–2996.
- Goodman-Bacon, A. (2021). Difference-in-differences with variation in treatment timing. *Journal of Econometrics*, 225(2), 254–277.
