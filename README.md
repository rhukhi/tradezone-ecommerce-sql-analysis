# TradeZone E-commerce Analysis (PostgreSQL)

Data cleaning and business analysis of a Nigerian e-commerce marketplace database using PostgreSQL. Includes eight analytical queries and a management memo with recommendations.

> **Note:** This is an early project from my HNG Internship in May 2026.
> I have kept the original work unchanged to show my starting point as I transition into data analysis. See "Limitations" for what I would do differently.

## Dataset
- **Source:** Provided by HNG
- **Database:** 7 tables
  - customers (865), orders (3,015), order_items (6,426)
  - payments (2,262), products (280), reviews (812), sellers (90)
- **Period:** orders from January 2023 to December 2024

## Business Questions
| File | Question |
|---|---|
| `Q1.sql` | What share of 2024 sign-ups bought within 30 days, by state? |
| `Q2.sql` | Which 10 products earned the most revenue in 2024? |
| `Q3.sql` | How fast and how well do sellers fulfil orders? |
| `Q4.sql` | How did revenue and average order value change by quarter? |
| `Q5.sql` | How is 2024 revenue split across spend segments? |
| `Q6.sql` | Which payment methods are used in each state? |
| `Q7.sql` | How do product rating categories relate to revenue? |
| `Q8.sql` | Which sellers qualify for a performance bonus? |

## Data Cleaning (`Part1.sql`)
- Removed duplicate orders using `ROW_NUMBER()`
- Filled missing delivery dates for delivered orders (order date + 5 days)
- Replaced missing product categories with "Uncategorized"
- Trimmed whitespace in names, states, categories, and payment methods
- Standardised price columns to `NUMERIC(10,2)` and recalculated `line_total = quantity x unit_price`
- Removed orders dated in the future

## Techniques Used
CTEs, window functions, multi-table joins, `CASE` segmentation, aggregation with `HAVING`, date arithmetic

## Key Findings
- Q4 2024 revenue was about N350.8M, roughly 390% above Q4 2023 (about N72M). Growth came mainly from order volume (234 to 1,030 orders per quarter), not larger orders.
- 177 of 425 customers who signed up in 2024 (41.6%) bought within 30 days. Lagos converted best (49.3%), Kano worst (31.0%).
- 591 "High Spenders" (N100k+) account for about N834.8M of the N838.0M total 2024 order value.
- The fastest seller on average was RunFast NG (about 91 hours from order to delivery).
- Six sellers met the bonus criteria (10+ orders, rating 4.0+), led by SportsCentral NG (about N7.1M).
- Card is the top payment method in Lagos, FCT, and Rivers; Cash on Delivery leads in Kano and Oyo.

## Limitations (and what I'd do differently)
- Revenue queries (Q4, Q5) include cancelled and returned orders. In Q4 2024, only about N167M of the N350.8M was delivered, and about 26% was cancelled or returned. Next time, I would filter by `order_status`.
- Delivery dates have no time component, so "fulfilment hours" in Q3
  are whole days multiplied by 24.
- Q5 uses `BETWEEN 50000 AND 99999`, which would miss values between 99,999 and 100,000. I would use `>= 50000 AND < 100000`.
- Delivery dates for some delivered orders were estimated (order date + 5 days), which affects fulfilment speed in Q3.
- The dedupe step in `Part1.sql` deletes every row sharing a duplicated `order_id`, including the first copy. A safer version keeps one row.
- Some payment amounts are missing, and 13 orders have more than one payment, which affects the Q6 totals.
- The memo's state names (e.g. "Abuja") differ from the database value "FCT", and the state Title Case step is described in the memo but is not in `Part1.sql`.

## Restoring the Database
1. Create an empty database: `createdb tradezone`
2. Load the dump: `psql -d tradezone -f data/cleaned_dump.sql`

The dump was created with PostgreSQL 18. On older versions, delete the line `SET transaction_timeout = 0;` (and any `\restrict` lines) if the restore fails.

## Files
- `sql/`: cleaning script and Q1-Q8 queries
- `data/cleaned_dump.sql`: cleaned database dump
- `docs/TradeZone_Performance_Memo.pdf`: memo with findings and recommendations

## Author
Rukky Ujara | https://www.linkedin.com/in/rhukhi/ | rukkyujara@gmail.com
