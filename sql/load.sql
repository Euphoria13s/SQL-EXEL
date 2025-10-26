-- Димы
INSERT OR IGNORE INTO dim_city(city_name)
SELECT CityName FROM stg_city
WHERE CityName IS NOT NULL AND CityName <> '' AND CityName <> 'CityName';

INSERT OR IGNORE INTO dim_manager(manager_name)
SELECT ManagerName FROM stg_manager
WHERE ManagerName IS NOT NULL AND ManagerName <> '' AND ManagerName <> 'ManagerName';

INSERT OR IGNORE INTO dim_category(category_name)
SELECT CategoryName FROM stg_category
WHERE CategoryName IS NOT NULL AND CategoryName <> '' AND CategoryName <> 'CategoryName';

-- Факт
INSERT INTO fact_sales (order_id, date, product, category_id, quantity, unit_price, discount,
                        city_id, manager_id, segment, cost, revenue, profit)
SELECT
  OrderID, Date, Product,
  (SELECT category_id FROM dim_category WHERE category_name = stg_sales.Category),
  Quantity, UnitPrice, DiscountNum,
  (SELECT city_id FROM dim_city WHERE city_name = stg_sales.City),
  (SELECT manager_id FROM dim_manager WHERE manager_name = stg_sales.Manager),
  Segment, Cost, Revenue, Profit
FROM stg_sales
WHERE OrderID <> 'OrderID';   -- <-- отсекаем заголовок
