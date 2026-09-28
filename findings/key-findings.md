# Key Findings

The figures below refer to the **45,485 German listings** used in the analytical population after filtering to Germany and asking price >= €1,000.

## Marketplace overview

| KPI | Result |
|---|---:|
| Listings | 45,485 |
| Median asking price | €42,990 |
| Dealer listing share | 88.46% |
| Private-seller listing share | 11.54% |
| Electrified listing share | 16.63% |
| Median mileage | 34,500 km |
| Median vehicle age | 3 years |

## Marketplace composition by fuel category

The German listing population is predominantly represented by **Petrol** and **Diesel** listings.

Analytical shares:

- Petrol: **49.14%**
- Diesel: **34.07%**
- Electric/Petrol: **9.50%**
- Electric: **5.42%**
- Electric/Diesel: **1.70%**
- Other categories: **0.09%**

The dashboard also provides an aggregated **Electrified Listing Share** of **16.63%**.

These figures describe the composition of the available listings in the snapshot. They should not be interpreted as market share, sales share, or customer preference.

## Seller structure

Dealer listings account for **88.46%** of the German analytical population, while private-seller listings represent **11.54%**.

In the SQL analysis, average asking price and average mileage also differ materially between the two seller types. The dashboard therefore treats seller type as an important dimension for marketplace comparison.

## Fuel-price differences

Median asking prices differ across fuel categories in the snapshot. **Electric listings have a median asking price of €74,980, compared with €35,979.50 for Diesel listings.** This is a descriptive difference within the listing population, not a causal estimate.

## Brand and model landscape

Within the **Top 10 brands by listing volume**, Porsche has **7,709 listings** and a median asking price of **€87,950**.

## Mileage and asking price

The dashboard shows a clear descriptive relationship between mileage bands and asking prices: lower-mileage listings are generally associated with higher asking prices, while higher-mileage bands show lower asking-price levels.

This is an association within the listing data, not a causal estimate of depreciation.

## Brand and model landscape

The project analyses both brand-level and model-level listing volume. The Vehicle Detail page then allows an individual listing to be compared against the median asking price for its brand + model.

This turns the dashboard from a simple marketplace overview into a listing-level analytical tool.

## Potential value analysis

A supporting DAX rule identifies listings that satisfy a defined combination of:

- relatively recent vehicle age
- lower mileage
- at least 20 comparable listings for the same brand + model
- asking price at least 15% below the comparable median

The flag is deliberately described as a **potential value opportunity**, not as proof that a vehicle is objectively undervalued.
