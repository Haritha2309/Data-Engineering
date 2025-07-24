use e-com_store_analysis

db.products.insertMany([
{ product_id: 1001, name: "Wireless Mouse", category: "Electronics", price: 750,
stock: 120 },
{ product_id: 1002, name: "Bluetooth Speaker", category: "Electronics", price: 2200,
stock: 80 },
{ product_id: 1003, name: "Yoga Mat", category: "Fitness", price: 599, stock: 150 },
{ product_id: 1004, name: "Office Chair", category: "Furniture", price: 7500, stock:
40 },
{ product_id: 1005, name: "Running Shoes", category: "Footwear", price: 3500, stock:
60 }
])

db.orders.insertMany([
{ order_id: 5001, customer: "Ravi Shah", product_id: 1001, quantity: 2, order_date:
new Date("2024-07-01") },
{ order_id: 5002, customer: "Sneha Mehta", product_id: 1002, quantity: 1,
order_date: new Date("2024-07-02") },
{ order_id: 5003, customer: "Arjun Verma", product_id: 1003, quantity: 3,
order_date: new Date("2024-07-03") },
{ order_id: 5004, customer: "Neha Iyer", product_id: 1001, quantity: 1, order_date:
new Date("2024-07-04") },
{ order_id: 5005, customer: "Mohit Jain", product_id: 1005, quantity: 2, order_date:
new Date("2024-07-05") }
])

// 1.
db.products.find({category:"Electronics"})

// 2.
db.orders.find({customer:"Ravi Shah"})

//3.
db.orders.find({order_date:{$gt: new Date("2024-07-02")}})

// 4.
db.products.find({stock:{$lt: 50}})

// 5.
db.products.find({price:{$gt:2000}})

// 6.
db.orders.aggregate([
  {$lookup:{from:"products",localField:"product_id",foreignField:"product_id",as:"product_info"}},
  {$unwind:"$product_info"},
  {$project:{order_id:1,product_name:"$product_info.name",price:"$product_info.price"}}
])

// 7.
db.orders.aggregate([
  {$lookup:{from:"products",localField:"product_id",foreignField:"product_id",as:"product_info"}},
  {$unwind:"$product_info"},
  {$group:{_id:"$customer",total_spent:{$sum:{$multiply:["$quantity","$product_info.price"]}}}},
  {$project:{customer_name:"$_id",total_spent:1,_id:0}}
])

// 8.
db.orders.aggregate([
  {$lookup:{from:"products",localField:"product_id",foreignField:"product_id",as:"product_info"}},
  {$unwind:"$product_info"},
  {$project:{category:"$product_info.category",order_id:1,customer:1}}
])

// 9.
db.orders.aggregate([
  {$lookup:{from:"products",localField:"product_id",foreignField:"product_id",as:"product_info"}},
  {$unwind:"$product_info"},
  {$match:{"product_info.category":"Fitness"}},
  {$group:{_id:"$customer"}},
  {$project:{customer_name:"$_id",_id:0}}
])

// 10.
db.orders.aggregate([
  {$lookup:{from:"products",localField:"product_id",foreignField:"product_id",as:"product_info"}},
  {$unwind:"$product_info"},
  {$group:{_id:"$product_info.category",total_sales: {$sum:{$multiply:["$quantity","$product_info.price"]}}}},
  {$project:{_id:0,category:"$_id",sales:"$total_sales"}}
])

// 11.
db.orders.aggregate([
  { $group: {_id: "$product_id",  total_units_sold: { $sum: "$quantity" }} },
  { $lookup: {  from: "products",  localField: "_id",  foreignField: "product_id",  as: "product_info"} },
  { $unwind: "$product_info" },
  { $project: { _id: 0, product_name: "$product_info.name",total_units_sold: 1 }}
]);

// 12.
db.products.aggregate([
  { $group: {_id: "$category",  avg_price: { $avg: "$price" } } },
  { $project: {_id: 0, category: "$_id", avg_price: 1 }}
]);

// 13.
db.orders.aggregate([
  { $lookup: {from: "products", localField: "product_id", foreignField: "product_id", as: "product"}},
  { $unwind: "$product" },
  { $project: {customer: 1, order_value: { $multiply: ["$quantity", "$product.price"] } } },
  { $sort: { order_value: -1 } },
  { $limit: 1 }
])

// 14.
db.orders.aggregate([
  {$group: {_id: "$product_id",  order_count: { $sum: 1 } } },
  { $sort: { order_count: -1 } },
  { $limit: 3 },
  { $lookup: {from: "products",localField: "_id",foreignField: "product_id",as: "product"} },
  { $unwind: "$product" },
  {$project: {product_name: "$product.name",  order_count: 1 }}
]);

// 15.
db.orders.aggregate([
  { $group: { _id: "$order_date", orders: { $sum: 1 } }},
  { $sort: { orders: -1 } },
  { $limit: 1 },
  {$project: {_id: 0,most_active_date: "$_id", order_count: "$orders"}}
]);

// 16.
db.customers.insertMany([
  { name: "Ravi Shah" },
  { name: "Sneha Mehta" },
  { name: "Arjun Verma" },
  { name: "Neha Iyer" },
  { name: "Mohit Jain" },
  { name: "Priya Kumar" } 
]);
db.customers.aggregate([
  { $lookup: {from: "orders",localField: "name",foreignField: "customer",as: "orders"}},
  { $match: { orders: { $size: 0 } } }
]);

// 17.
db.orders.insertMany([
  { order_id: 5006, customer: "Ravi Shah", product_id: 1003, quantity: 1, order_date: new Date("2024-07-06") },
  { order_id: 5007, customer: "Sneha Mehta", product_id: 1004, quantity: 1, order_date: new Date("2024-07-06") }
])

db.orders.aggregate([
  { $group: { _id: "$customer",order_count: { $sum: 1 } } },
  {$match: {  order_count: { $gt: 1 } } },
  {$project: { _id: 0, customer_name: "$_id", order_count: 1  } }
]);

// 18.
db.products.aggregate([
  {$lookup: {from: "orders",localField: "product_id",foreignField: "product_id",as: "orders"}},
  { $match: { orders: { $size: 0 } } }
]);

// 19.
db.orders.aggregate([
  {$lookup: {from: "products",localField: "product_id",foreignField: "product_id",as: "product" }},
  {$unwind: "$product"},
  {$match: {"product.stock": { $lt: 100 }}},
  {$group: { _id: "$customer" }},
  { $project: { _id: 0,customer_name: "$_id" }}
]);

// 20.
db.products.aggregate([
  {$project: { product_id: 1, name: 1, inventory_value: { $multiply: ["$price", "$stock"] } }}
]);
