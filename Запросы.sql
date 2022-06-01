-- КОЛИЧЕСТВО ПРОДУКТОВ В ДАННОЙ КАТЕГОРИИ POSTGRESQL--
SELECT count(*) FROM product
INNER JOIN category ON product."Category_ID" = Category."ID"
WHERE category."Name" = 'Смартфоны и гаджеты'; 

-- ОЦЕНКИ У ТОВАРОВ ПО УБЫВАНИЮ POSTGRESQL --
SELECT *
FROM review
INNER JOIN product ON product."ID" = review."Product_ID"
ORDER BY review."Rating" DESC;


-- Конкретный клиент конкретному курьеру MSSQL--
SELECT courier. "Fullname" as 'Courier name',  client."Fullname" as 'Client name'
FROM Orders
INNER JOIN client ON Orders."Client_ID" = client."ID"
INNER JOIN courier ON courier."ID" = Orders."Courier_ID"
WHERE client."Fullname" = 'Петров Иван Александрович'; 

-- Магазин с наивысшим рейтингом MSSQL--
SELECT TOP 1 Shop.Rating, Shop.Name
FROM Shop
ORDER BY Shop.Rating DESC

-- Вся информация о продукте POSTGRESQL-- 
SELECT product."Brand", product."Model",product."Item_number",
string_agg(review."Rating" || ' - ' || review."Article" || ': ' || review."Content" || '- ' || review."Comment", '; '),
string_agg(question."Content" || ' ' || answer."Content", '; ')
FROM product
INNER JOIN category ON product."Category_ID" = Category."ID"
INNER JOIN review ON product."ID" = review."Product_ID"
INNER JOIN question ON question."Product_ID" = product."ID"
INNER JOIN answer ON answer."Question_ID" = question."ID"
WHERE product."ID" = '1'
group by product."ID";

-- Вопросы и ответы о конкретном продукте POSTGRESQL--
SELECT question."Content", answer."Content", product."Brand", product."Model"
FROM product
INNER JOIN question ON question."Product_ID" = product."ID"
INNER JOIN answer ON answer."Question_ID" = question."ID"
WHERE product."Brand" = 'Lenovo' and product."Model" = 'Legion 5 15ACH6A';