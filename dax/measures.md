# Core DAX Measures

The following measures power the main dashboard analysis.

## Marketplace KPIs

```DAX
Total Listings =
COUNTROWS(Fact_Listings)

Median Asking Price =
MEDIAN(Fact_Listings[price])

Dealer Listing Share =
DIVIDE(
    CALCULATE(
        [Total Listings],
        Fact_Listings[seller_type] = "Dealer"
    ),
    [Total Listings]
)

Private Seller Listing Share =
DIVIDE(
    CALCULATE(
        [Total Listings],
        Fact_Listings[seller_type] = "Private Seller"
    ),
    [Total Listings]
)

Electrified Listing Share =
DIVIDE(
    CALCULATE(
        [Total Listings],
        Fact_Listings[Electrified_Flag] = "Electrified"
    ),
    [Total Listings]
)

Median Mileage =
MEDIAN(Fact_Listings[mileage_km_raw])

Median Vehicle Age =
MEDIAN(Fact_Listings[Vehicle_Age])
```

## Model benchmark

```DAX
Brand-Model Median Asking Price =
VAR SelectedBrand =
    SELECTEDVALUE(Fact_Listings[make])
VAR SelectedModel =
    SELECTEDVALUE(Fact_Listings[Model Display])
RETURN
    CALCULATE(
        [Median Asking Price],
        REMOVEFILTERS(Fact_Listings),
        Fact_Listings[make] = SelectedBrand,
        Fact_Listings[Model Display] = SelectedModel
    )
```

The benchmark represents the median asking price for the selected brand + model in the analytical population.

## Vehicle-level benchmark comparison

```DAX
Price vs Model Median =
DIVIDE(
    [Selected Asking Price] - [Brand-Model Median Asking Price],
    [Brand-Model Median Asking Price]
)
```

## Vehicle display helpers

```DAX
Selected Vehicle Age Display =
VAR Age =
    SELECTEDVALUE(Fact_Listings[Vehicle_Age])
RETURN
    IF(
        ISBLANK(Age),
        BLANK(),
        FORMAT(Age, "0") & " years"
    )
```

```DAX
Selected Mileage =
VAR Mileage =
    SELECTEDVALUE(Fact_Listings[mileage_km_raw])
RETURN
    IF(
        ISBLANK(Mileage),
        BLANK(),
        SWITCH(
            TRUE(),
            Mileage >= 1000000,
                FORMAT(Mileage / 1000000, "0.0") & "M km",
            Mileage >= 1000,
                FORMAT(Mileage / 1000, "0") & "K km",
            FORMAT(Mileage, "#,0") & " km"
        )
    )
```

## Supporting value-opportunity logic

```DAX
Brand-Model Listing Count =
CALCULATE(
    [Total Listings],
    ALLEXCEPT(
        Fact_Listings,
        Fact_Listings[make],
        Fact_Listings[model]
    )
)
```

```DAX
Potential Value Opportunity Flag =
VAR Price =
    SELECTEDVALUE(Fact_Listings[price])
VAR Benchmark =
    [Brand-Model Median Asking Price]
VAR ComparableCount =
    [Brand-Model Listing Count]
VAR Age =
    SELECTEDVALUE(Fact_Listings[Vehicle_Age])
VAR Mileage =
    SELECTEDVALUE(Fact_Listings[mileage_km_raw])
VAR PriceVsBenchmark =
    DIVIDE(
        Price - Benchmark,
        Benchmark
    )
RETURN
    IF(
        NOT ISBLANK(Price)
            && NOT ISBLANK(Benchmark)
            && NOT ISBLANK(Age)
            && NOT ISBLANK(Mileage)
            && ComparableCount >= 20
            && Age <= 5
            && Mileage <= 50000
            && PriceVsBenchmark <= -0.15,
        1,
        0
    )
```

The opportunity flag is used as supporting analysis only. It is not presented as an automated valuation model.
