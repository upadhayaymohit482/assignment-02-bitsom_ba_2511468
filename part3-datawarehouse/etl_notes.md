## ETL Decisions

### Decision 1 — Standardized mixed date formats
Problem: The raw `date` column used multiple formats such as `29/08/2023`, `12-12-2023`, and `2023-02-05`. If loaded directly, month-based reporting would be unreliable because the same business date format was represented in three different ways.
Resolution: I parsed every raw date and converted it to a single ISO standard (`YYYY-MM-DD`) before loading into `dim_date`. This made joins, sorting, and month-level aggregations deterministic.

### Decision 2 — Normalized category casing and labels
Problem: The raw `category` values were inconsistent: `Electronics`, `electronics`, `Grocery`, and `Groceries` all appeared in the file. Without cleaning, BI reports would split the same category into multiple groups.
Resolution: I standardized the values to `Electronics`, `Clothing`, and `Groceries` before loading `dim_product`. This ensures that category totals in the warehouse reflect business reality rather than source-system spelling differences.

### Decision 3 — Filled missing store_city values from store_name
Problem: Nineteen rows had `NULL` in `store_city`, even though the `store_name` was present. Leaving those values null would create incomplete dimension records and make store-level reporting messy.
Resolution: I inferred the missing city from the known `store_name` mapping already present in other rows (for example, `Delhi South` → `Delhi`, `Pune FC Road` → `Pune`). This preserved all valid transactions while keeping `dim_store` complete and standardized.
