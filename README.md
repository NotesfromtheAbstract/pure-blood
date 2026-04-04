# Pure Blood — Chart Package

R code and data supporting the *Notes from the Abstract* piece **"Pure Blood: How a belief the biology already disproved is draining the blood supply and disappearing from the record."**

Published at [andrewrcrocker.substack.com](https://andrewrcrocker.substack.com)

---

## What This Chart Shows

A two-panel stacked bar chart comparing the current U.S. blood donor pool by COVID-19 antibody status against what the 2025 Kentucky House Bill 140 would have required for a donor to remain eligible. The left panel shows that 96.4% of current donors carry COVID-19 antibodies. The right panel shows what the eligible pool would have looked like under the bill's terms: inverted.

---

## Data Sources

| Figure | Source |
|---|---|
| 96.4% antibody prevalence in donor pool | CDC National Blood Donor Serosurveillance, 2022 [Andrew to verify and insert primary citation] |
| Kentucky HB 140 eligibility requirements | Louisville Public Media, January 23, 2025 |

---

## Dependencies

```r
install.packages(c("ggplot2", "patchwork", "scales"))
```

---

## Usage

```r
source("pure_blood_chart.R")
```

Output: `pure_blood_chart.png` at 1456 × 900px, suitable for Substack upload.

---

## Repository Contents

```
pure-blood-chart/
├── pure_blood_chart.R   # Chart code
├── README.md            # This file
├── LICENSE              # MIT
└── .gitignore
```

---

## Notes

The 96.4% figure requires verification against the primary CDC seroprevalence report before publication. Multiple secondary sources cite it; the primary document should be linked directly in the caption once confirmed.

---

## License

MIT. See `LICENSE`.
