// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    _id: "P101",
    name: "Samsung Smart TV 55 inch",
    category: "Electronics",
    price: 55000,
    brand: "Samsung",
    warranty_years: 2,
    specifications: {
      resolution: "4K UHD",
      voltage: "220V",
      screen_type: "LED"
    },
    features: ["Smart TV", "WiFi Enabled", "Dolby Audio"],
    stock: 25
  },
  {
    _id: "P201",
    name: "Men's Cotton T-Shirt",
    category: "Clothing",
    price: 799,
    brand: "Nike",
    material: "Cotton",
    sizes_available: ["S", "M", "L", "XL"],
    colors: ["Black", "White", "Blue"],
    variants: [
      { size: "M", color: "Black", stock: 10 },
      { size: "L", color: "White", stock: 5 }
    ],
    care_instructions: "Machine wash"
  },
  {
    _id: "P301",
    name: "Amul Milk 1L",
    category: "Groceries",
    price: 60,
    brand: "Amul",
    expiry_date: new Date("2024-12-30"),
    weight: "1L",
    nutrition: {
      calories: 150,
      protein: "8g",
      fat: "8g"
    },
    storage_instructions: "Keep refrigerated",
    tags: ["dairy", "fresh", "daily-use"]
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: new Date("2025-01-01") }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { _id: "P101" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });

// Why this index?
// Because many application queries filter by category first
// (Electronics, Clothing, Groceries). An index on category
// reduces full collection scans and improves lookup speed.
