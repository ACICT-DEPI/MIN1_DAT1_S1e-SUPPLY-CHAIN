CREATE DATABASE supply_chain_db;
USE supply_chain_db;

CREATE TABLE supply_chain_data (
    SKU VARCHAR(50) NOT NULL PRIMARY KEY,
    product_type VARCHAR(100),
	price DECIMAL(10, 2) NOT NULL,
    availability INT NOT NULL,
    products_sold INT NOT NULL,
    revenue_generated DECIMAL(15, 2) NOT NULL,
    customer_demographics VARCHAR(50),
    stock_levels INT,
    customer_lead_time INT,  -- Lead times: time to deliver product to customer
    order_quantities INT,
    shipping_times INT,
    shipping_carriers VARCHAR(100),
    shipping_costs DECIMAL(10, 2) NOT NULL,
    supplier_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    supplier_lead_time INT NOT NULL,  -- Lead time: time to receive from supplier
    production_volumes INT,
    manufacturing_lead_time INT,
    manufacturing_costs DECIMAL(10, 2),
    inspection_results VARCHAR(50),
    defect_rates DECIMAL(5, 4),
    transportation_modes VARCHAR(50),
    routes VARCHAR(50),
    costs DECIMAL(10, 2),
    price_per_unit DECIMAL(10, 2),
    profit_margin DECIMAL(10, 2),
    stock_to_sales_ratio DECIMAL(5, 4),
    total_lead_time INT,
    defect_rate_category VARCHAR(50),
    cost_per_unit_transport DECIMAL(10, 2)
);


-- About Sales 
Select SKU, product_type,Sum(products_sold) AS "Total_Number_of_products_sold" 
FROM supply_chain_data
GROUP BY SKU
ORDER BY Sum(products_sold) DESC
LIMIT 10;

Select SKU, product_type,Sum(profit_margin) AS "Total_profit_margin_(Top 10)"
FROM supply_chain_data
GROUP BY SKU
ORDER BY avg(profit_margin) DESC
LIMIT 10;


Select product_type,avg(price) AS "price", avg(products_sold) AS "Total_Number_of_products_sold" 
FROM supply_chain_data
GROUP BY product_type
ORDER BY price DESC
LIMIT 10;

-- SKU10
SELECT SKU, product_type, products_sold 
FROM supply_chain_data
ORDER BY products_sold DESC
LIMIT 1;

-- SKU51
SELECT SKU, product_type, profit_margin 
FROM supply_chain_data
ORDER BY profit_margin DESC
LIMIT 1;

SELECT product_type,price, products_sold
FROM supply_chain_data;

-- Stock to Sales Ratio = Inventory / Sales 
SELECT SKU, product_type, stock_to_sales_ratio 
FROM supply_chain_data
ORDER BY stock_to_sales_ratio DESC;

-- SKU68 stock out
SELECT SKU, product_type, stock_to_sales_ratio 
FROM supply_chain_data
WHERE stock_to_sales_ratio < 1
ORDER BY stock_to_sales_ratio ASC;


SELECT SKU, product_type, customer_lead_time 
FROM supply_chain_data
ORDER BY customer_lead_time DESC
LIMIT 5;

-- ما هي العلاقة بين وقت التصنيع وكفاءة المبيعات
SELECT manufacturing_lead_time, products_sold 
FROM supply_chain_data;

--  ما هي المنتجات التي تواجه أعلى معدلات العيوب؟
SELECT SKU, product_type, defect_rates 
FROM supply_chain_data
ORDER BY defect_rates DESC
LIMIT 5;

-- هل هناك علاقة بين طريقة النقل وعيوب المنتجات؟
SELECT transportation_modes, AVG(defect_rates) AS avg_defect_rate
FROM supply_chain_data
GROUP BY transportation_modes
ORDER BY avg_defect_rate DESC;

--  ما هي تكلفة النقل لكل وحدة للمنتجات المختلفة؟
SELECT SKU, product_type, cost_per_unit_transport 
FROM supply_chain_data
ORDER BY cost_per_unit_transport DESC
LIMIT 5;

-- ما هي أفضل طرق النقل من حيث الكفاءة والتكلفة؟
SELECT transportation_modes, AVG(cost_per_unit_transport) AS avg_transport_cost
FROM supply_chain_data
GROUP BY transportation_modes
ORDER BY avg_transport_cost ASC;

SELECT product_type,location, COUNT(*) 
From   supply_chain_data
group BY product_type, location
ORDER BY COUNT(*) DESC , product_type DESC; 

SELECT product_type,Avg(price) AS Avg_Price
From   supply_chain_data
group BY product_type;

SELECT product_type,SUM(revenue_generated) AS Total_revenue
From   supply_chain_data
group BY product_type
ORDER BY Total_revenue DESC , product_type DESC;

SELECT product_type,SUM(profit_margin) AS profit_margin
From   supply_chain_data
group BY product_type
ORDER BY profit_margin DESC , product_type DESC;

SELECT product_type, products_sold , SUM(revenue_generated) AS Total_revenue
From   supply_chain_data
group BY product_type,products_sold
ORDER BY Total_revenue DESC
LIMIT 5;

SELECT product_type, SKU, MAX(revenue_generated) AS MaxRevenue
FROM supply_chain_data
GROUP BY product_type,SKU;
























