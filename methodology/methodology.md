# Methodology

## 1. Analytical scope

The project focuses on the German marketplace:

- `country_code = 'DE'`
- asking price `>= €1,000`

This produces an analytical population of **45,485 listings**.

The raw German population contains 45,611 listings; the €1,000 threshold is used to reduce the influence of clearly anomalous low-price entries while keeping the project focused on marketplace asking-price analysis.

## 2. Data grain

The source data is treated at listing level:

> **1 row = 1 vehicle listing**

The dataset contains **118,382 rows and 75 columns**. The source listing ID is unique in the analysed file.

The project uses listings and **asking prices**. It does not interpret asking prices as transaction prices, revenue, customer demand, or realised sales prices.

## 3. Preparation

### SQL

SQLite was used for:

- filtering the German analytical population
- seller-type comparisons
- fuel-category composition
- mileage-band analysis
- brand/model listing volume
- vehicle-age analysis
- benchmark-oriented exploration

### Power Query

Power Query was used in Power BI to:

- retain analysis-relevant fields
- set data types
- derive vehicle age
- create mileage bands
- create age bands
- classify electrified listings
- prepare display values for the dashboard

Vehicle age is calculated relative to **31 December 2025** using registration date. Future/unusable registration dates are not forced into an age calculation.

## 4. Data model

The Power BI model follows a simple star-schema approach:

- **Fact_Listings** — listing-level facts and attributes
- **DimBrand** — brand dimension
- **DimFuel** — fuel-category dimension
- **DimSeller** — seller-type dimension

Dimensions filter the fact table in a single direction.

## 5. Analytical design choices

### Median asking price

Median is used as the primary price KPI because asking prices are highly dispersed and the dataset contains a small number of very high-priced listings.

### Fuel terminology

The source category **Gasoline** is displayed as **Petrol** in the dashboard for the intended German/European business audience.

### Electrified classification

The project groups:

- Electric
- Electric/Gasoline
- Electric/Diesel

into an **Electrified** category for the electrified listing-share KPI.

This is a classification for analysis, not a claim about vehicle-market technology adoption over time.

### Marketplace composition

The project analyses the composition of the listing marketplace at the available snapshot. Because the dataset does not provide a reliable listing-observation date, the fuel analysis is intentionally framed as **marketplace composition**, not as a time-series "shift".

### Vehicle benchmarking

The Vehicle Detail page compares an individual listing's asking price with the **median asking price for the same brand + model** in the analytical population.

This is a descriptive benchmark. A lower asking price versus the model median is not automatically evidence of objective undervaluation because vehicle condition, equipment, history, specification, seller context, and other factors can differ.

## 6. Limitations

- The data represents listings, not completed transactions.
- Asking price does not equal realised selling price.
- Seller/listing information may contain missing or inconsistent values.
- Some vehicle attributes are sparsely populated.
- The dataset is a snapshot and does not support a robust listing-level time-series analysis.
- Benchmark comparisons are descriptive and not appraisal models.

## 7. Source

**Source: AutoScout24 listings via Kaggle | Independent portfolio analysis**

Dataset: [AutoScout24 Car Listings Dataset — 2025 Snapshot](https://www.kaggle.com/datasets/clkmuhammed/autoscout24-car-listings-dataset)
