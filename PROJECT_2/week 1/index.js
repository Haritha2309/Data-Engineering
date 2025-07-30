use inventory_management;

db.audit_logs.createIndex({ product_id: 1 });
db.audit_logs.createIndex({ warehouse_id: 1 });