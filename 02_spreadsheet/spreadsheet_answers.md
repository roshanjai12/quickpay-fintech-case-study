````md
# Spreadsheet Answers

---

## Cleaning Steps

- Imported transactions_raw.csv into Google Sheets
- Reviewed the dataset for inconsistencies and formatting issues
- Cleaned merchant names by converting them into uppercase standardized format
- Standardized transaction date formatting for consistent reporting
- Standardized transaction status values into operational categories
- Extracted numeric values from raw risk score patterns
- Standardized gateway regions into unified region codes
- Converted all transaction amounts into USD using exchange_rates.csv
- Enriched transactions using merchant_master.csv
- Added merchant-level information into the transaction dataset
- Created high_value_flag using region-based transaction thresholds
- Created high_risk_flag using risk score and chargeback conditions
- Generated merchant-level summary reporting using Pivot Tables

---

## Standardization Rules

### Merchant Name Standardization

Merchant names were standardized using uppercase formatting and whitespace trimming.

Examples:
- alpha mart → ALPHA MART
- Alpha Mart → ALPHA MART
- beta stores → BETA STORES

Formula used:

```excel
=UPPER(TRIM(D2))
```

---

### Status Standardization

Transaction statuses were normalized into standard operational values.

Standardized values:
- CAPTURED
- FAILED
- CHARGEBACK

Examples:
- captured → CAPTURED
- failed e05 timeout → FAILED
- chargeback → CHARGEBACK

---

### Risk Score Standardization

Risk score values were extracted into numeric format.

Examples:
- score:62 → 62
- risk-83 → 83

Regex extraction logic was used to isolate numeric values.

---

### Gateway Region Standardization

Gateway regions were standardized into:
- APAC
- EU
- US

Examples:
- apac → APAC
- eu → EU
- us → US

---

## Lookup and Enrichment Logic

### Exchange Rate Conversion

exchange_rates.csv was imported into a separate Google Sheets tab.

Transaction amounts were converted into USD using exchange rate lookup formulas.

The exchange rate table was used as a reference dataset for currency normalization.

---

### Merchant Enrichment

merchant_master.csv was imported into a separate sheet.

Merchant records were enriched using lookup operations based on standardized merchant names.

Additional merchant attributes added:
- merchant_id
- account_manager
- merchant_category
- default_region

INDEX-MATCH logic was used for merchant enrichment.

---

## Final Answers

### Dataset Processing Summary

The cleaned dataset includes:
- standardized merchant names
- standardized transaction statuses
- standardized risk scores
- standardized gateway regions
- USD-normalized transaction amounts
- merchant enrichment columns
- high value transaction flags
- high risk transaction flags

The merchant risk summary report includes:
- merchant-level GMV aggregation
- average risk score calculation
- high risk transaction count
- transaction count summary

---

## Formula Samples

### Merchant Name Cleaning

```excel
=UPPER(TRIM(D2))
```

---

### Status Cleaning

```excel
=IF(REGEXMATCH(LOWER(H2),"capture"),"CAPTURED",IF(REGEXMATCH(LOWER(H2),"fail"),"FAILED",IF(REGEXMATCH(LOWER(H2),"chargeback"),"CHARGEBACK","OTHER")))
```

---

### Risk Score Cleaning

```excel
=IFERROR(VALUE(REGEXEXTRACT(J2,"\d+")),0)
```

---

### Currency Conversion

```excel
=F2 * VLOOKUP(G2,exchange_rates!B:C,2,FALSE)
```

---

### Merchant Enrichment

```excel
=INDEX(merchant_master!A:A,MATCH(E2,merchant_master!C:C,0))
```
---

### High Value Flag

```excel
=IF(OR(AND(M2="APAC",Q2>5000),AND(M2="EU",Q2>6000),AND(M2="US",Q2>7000)),1,0)
```

---

### High Risk Flag

```excel
=IF(OR(K2>=70,I2="CHARGEBACK"),1,0)
```

````
