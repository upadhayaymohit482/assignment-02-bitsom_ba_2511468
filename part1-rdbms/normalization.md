## Anomaly Analysis

### Insert Anomaly
In `orders_flat.csv`, product details are stored only inside order rows. For example, CSV data row 12 stores product `P008` with columns `product_id`, `product_name`, `category`, and `unit_price`, but the same row also requires `order_id`, `customer_id`, `order_date`, and sales-rep columns. This means a brand-new product cannot be inserted independently; to add a new product, the company would have to invent an order row first. The same issue exists for a new sales representative, because rep data only appears beside an order.

### Update Anomaly
`SR01` appears repeatedly across the file, so a change to one rep attribute must be made in many rows. A clear inconsistency already exists in the dataset: CSV data row 2 shows `sales_rep_id = SR01` with `office_address = "Mumbai HQ, Nariman Point, Mumbai - 400021"`, while CSV data row 38 shows the same `sales_rep_id = SR01` with `office_address = "Mumbai HQ, Nariman Pt, Mumbai - 400021"`. Because the sales-rep details are duplicated across order rows, one partial update creates inconsistent data.

### Delete Anomaly
Product `P008` (`Webcam`) appears only once in the CSV: data row 12 (`order_id = ORD1185`). If that order row is deleted, the system also loses the only stored details for that product (`product_name`, `category`, `unit_price`). In other words, deleting one order can accidentally delete master data about a product.

## Normalization Justification

Keeping everything in one table may feel simpler at first, but this dataset shows why that simplicity is misleading. In `orders_flat.csv`, customer data, product data, order data, and sales-representative data are all repeated across many rows. That duplication creates real data-quality problems. The best example is `sales_rep_id = SR01`: the same representative appears repeatedly, yet the office address is not even consistent across the file. One row uses “Nariman Point” while another uses “Nariman Pt.” A single-table design makes these partial updates very likely because the same fact is stored over and over again.

The dataset also shows delete risk. Product `P008` (`Webcam`) appears only once, in the row for `ORD1185`. If that one row is removed because the order is cancelled or archived, the business loses the only stored record of the product itself. That is not just inconvenient; it is dangerous for reporting and inventory management. Insert operations are also awkward because new products or sales reps cannot be added independently. Since product columns appear only beside order columns, a new product would require a fake order row just to exist in the system.

Normalizing to 3NF solves these issues by separating entities into Customers, Products, SalesReps, Orders, and OrderItems. Each fact is stored once, updates happen in one place, and deleting an order no longer removes product or customer master data. In this case, normalization is not over-engineering; it is the minimum needed for correctness, consistency, and maintainability.
