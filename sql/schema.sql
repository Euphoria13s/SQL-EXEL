
DROP TABLE IF EXISTS dim_city;
DROP TABLE IF EXISTS dim_manager;
DROP TABLE IF EXISTS dim_category;
DROP TABLE IF EXISTS fact_sales;

CREATE TABLE dim_city      (city_id INTEGER PRIMARY KEY, city_name TEXT UNIQUE);
CREATE TABLE dim_manager   (manager_id INTEGER PRIMARY KEY, manager_name TEXT UNIQUE);
CREATE TABLE dim_category  (category_id INTEGER PRIMARY KEY, category_name TEXT UNIQUE);

CREATE TABLE fact_sales (
  order_id    TEXT,
  date        TEXT,
  product     TEXT,
  category_id INTEGER,
  quantity    INTEGER,
  unit_price  REAL,
  discount    REAL,
  city_id     INTEGER,
  manager_id  INTEGER,
  segment     TEXT,
  cost        REAL,
  revenue     REAL,
  profit      REAL
);
CREATE INDEX ix_sales_date ON fact_sales(date);
CREATE INDEX ix_sales_city ON fact_sales(city_id);
CREATE INDEX ix_sales_manager ON fact_sales(manager_id);
