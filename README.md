# Australian Retail Sales Forecasting (Monthly) — SNAIVE Benchmark (R)

This project applies a standard time-series forecasting workflow to monthly Australian retail sales data. The goal is to build a transparent seasonal benchmark, evaluate it on a 2011 holdout period, and diagnose remaining structure via residual tests.

## Workflow
- Construct monthly time series (frequency = 12; start = 1982-04)
- Train/test split with test beginning **2011-01**
- Fit **Seasonal Naïve (SNAIVE)** model on training data
- Backtest on holdout set and report forecast accuracy (RMSE/MAE)
- Run residual diagnostics (ACF + Ljung–Box) to assess autocorrelation

## Key takeaway
SNAIVE is a strong, interpretable seasonal baseline. Residual autocorrelation and large peak-month errors indicate remaining structure, motivating richer models (ETS/ARIMA or regression with seasonal/event effects) for production-grade forecasting.

## How to run
1) Place `retail.xlsx` in `data/`.
2) Run `scripts/australian_retail_snaive_backtest.R`

## Outputs
- Figures saved to `outputs/figures/`
- Tables saved to `outputs/tables/`
