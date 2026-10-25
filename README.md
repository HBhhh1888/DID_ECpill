# Reassessing the Effects of the Emergency Contraceptive Pill on Children and Women in Chile: Do Current DID Methods Change Results?

This repository contains the analysis code for my thesis at Monash University (ETC5860). In this project, I reassess the findings of Bentancor and Clarke (2017), who use a two-way fixed effects (TWFE) regression to estimate the effect of staggered municipal-level access to the emergency contraceptive (EC) pill in Chile on birth rates and early-gestation foetal deaths.

This project asks whether those TWFE conclusions are robust to modern staggered-adoption difference-in-differences (DID) methods:

- **De Chaisemartin and D'Haultfoeuille (2020)** diagnostic tools, to assess whether the original TWFE estimates are vulnerable to the negative-weighting problem in staggered-adoption designs.
- **Callaway and Sant'Anna (2021)**, a staggered-adoption-consistent estimator that allows for heterogeneous and dynamic treatment effects, used here as an alternative to TWFE.

## Repository Structure

```
DID_ECpill/
├── Data_Process.qmd     # Step 1: builds the municipality-by-year panels
├── Stage1.qmd           # Step 2: TWFE replication, diagnostics, spillover and timing checks
├── Stage2.qmd           # Step 3: Callaway and Sant'Anna estimation, pre-trends, event study
├── Stage3.qmd           # Step 4: comparison tables
├── Data/                # Raw input data (see Data Source below)
├── Data_Processed/      # Panels produced by Data_Process.qmd
├── Output/              # CSV results and figures produced by Stage1-Stage3
├── requirements.r       # R packages to install
├── .gitignore           # Git ignore file
└── README.md            # This file
```

## Analysis Overview

The analysis is organised into four files, which must be run in this order:

1. **`Data_Process.qmd`** loads the raw birth and foetal-death records, constructs the outcome, treatment, cohort, switcher and spillover variables, and aggregates them into municipality-by-year panels for three age groups (all women 15–49, teenagers 15–19, young adults 20–34). It saves the panels to `Data_Processed/` (the full panels with the one-year lagged pill, and the panels with the current-year pill used for the timing checks) and the summary statistics to `Output/`.

2. **`Stage1.qmd`** replicates the four original TWFE specifications (baseline, population-weighted, municipality-specific trends, covariates), computes the De Chaisemartin and D'Haultfoeuille (2020) negative-weighting diagnostics, and runs two spillover robustness checks (regression-based and sample-restriction-based). It also re-estimates TWFE on the switcher-excluded restricted sample, so that the effect of the estimation method can be separated from the effect of the sample restriction, and re-estimates it with the current-year pill (timing checks).

3. **`Stage2.qmd`** estimates the Callaway and Sant'Anna model on the switcher-excluded restricted sample (four specifications), extracts the pre-treatment dynamic effects as a placebo-style parallel-trends check, produces the event-study estimates and figure, and runs the timing checks (current-year pill, an anticipation of one year, and the one-year lag on the same rows as the current-year pill).

4. **`Stage3.qmd`** builds the overall comparison tables (original TWFE, restricted TWFE and Callaway and Sant'Anna), which are the main empirical output of this project, together with the comparisons for the timing checks and for the anticipation of one year.


## Data Source

The data used in this project is the publicly available replication package for Bentancor and Clarke (2017), from <https://github.com/damiancclarke/morning-after-pill>. Two files are used and included in the `Data/` directory:

- `S1Data_granular_covars.csv` — live births
- `S1Data_deaths_covars.csv` — foetal deaths

Both cover 336 municipalities. Note that the public replication data covers 2006–2011, one year short of the original paper's 2006–2012 sample, so the TWFE coefficients reported here do not reproduce the original paper's coefficients exactly.

## Pipeline

Step 0: Ensure you have R 4.5.2 or later installed on your system.

Step 1: Clone the repository, and open it as a working directory in RStudio.

Step 2: Install the required R packages by running all the code in `requirements.r`.

Step 3: Run or render all the four quarto files in order:

1. `Data_Process.qmd`
2. `Stage1.qmd`
3. `Stage2.qmd`
4. `Stage3.qmd`

After these steps:

- The processed data will be available in the `Data_Processed/` directory
- The results from Stage 1, 2 and 3 will be shown in the quarto output and will also be available in the `Output/` directory

## Acknowledgements

I would like to thank Bentancor and Clarke for making the replication data of their paper publicly available at <https://github.com/damiancclarke/morning-after-pill>, De Chaisemartin and D'Haultfoeuille for their diagnostic tools, and Callaway and Sant'Anna for their staggered-adoption estimator, all of which made this project possible. I am also grateful to my supervisor, Akanksha Negi, for the guidance and feedback throughout this project, and to the ETC5860 teaching team for their patient guidance.
