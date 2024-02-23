-- SELECIONADO TODOS AS COLUNAS DA TABELA
SELECT * FROM TB_SUPERSTORE;


-- SOMA TOTAL DO LUCRO, ARREDONDANDO 3 CASAS PÓS A VIRGULA
SELECT ROUND(SUM(SP.Profit),3) AS SUM_PROFIT 
FROM TB_SUPERSTORE SP;


-- SOMA LUCRO POR CITY ORDEM DECRESCENTE
SELECT SP.City
	,SUM(SP.Profit) AS SUM_PROFIT 
FROM TB_SUPERSTORE SP
GROUP BY SP.City
ORDER BY SUM_PROFIT ASC;


-- SOMA LUCRO POR PRODUCT CATEGORY ORDEM DECRESCENTE
SELECT SP.Product_Category
	,SUM(SP.Profit) AS SUM_PROFIT 
FROM TB_SUPERSTORE SP
GROUP BY SP.Product_Category
ORDER BY SUM_PROFIT DESC;


-- PRODUTOS COM SOMA DE LUCRO > 0
SELECT SP.Product_Name
	,SUM(SP.Profit) AS SUM_PROFIT 
FROM TB_SUPERSTORE SP
GROUP BY SP.Product_Name
HAVING SUM(SP.Profit) > 0;


-- CONTAGEM DE PRODUTOS COM LUCRO > 0
SELECT COUNT(*) AS PRODUTOS_LUCRO_POSITIVO
FROM TB_SUPERSTORE SP
WHERE SP.Profit > 0;


-- MULTIPLACAÇÃO ENTRE 2 COLUNAS, DEPOIS SOMA E ARREDONDAMENTO 2 CASAS PÓS A VIRGULA
SELECT ROUND(SUM(SP.Unit_Price * SP.Quantity_ordered), 2) AS TOTAL_SALES
FROM TB_SUPERSTORE SP;


-- TABELA DE SOMAS PARA VALIDAÇÃO DOS DADOS 
SELECT COUNT(*) AS TOTAL_REGISTER
	,SUM(CASE WHEN SP.Profit > 0 THEN 1 ELSE 0 END) AS QTD_PROFIT_POSITIVE
	,SUM(CASE WHEN SP.Profit < 0 THEN 1 END) AS QTD_PROFIT_NEGATIVE
	,SUM(CASE WHEN SP.Customer_Name IS NULL THEN 1 ELSE 0 END) AS QTD_NULL_CUSTOMER_NAME
	,ROUND(AVG(SP.Profit), 2) as AVG_PROFIT
	,ROUND(SUM(SP.Profit), 2) AS SUM_PROFIT
	,SUM(SP.Quantity_ordered) as SUM_QTT
	,ROUND(SUM(SP.Sales), 2) AS SUM_SALES
	,ROUND(SUM(SP.Product_Margin), 2) as SUM_PRODUCT_MARGIN
	,ROUND(SUM(SP.Shipping_Cost), 2) as SUM_SHIPPING_COST
	,ROUND(SUM(SP.Unit_Price * SP.Quantity_ordered), 2) AS TOTAL_SALES
FROM TB_SUPERSTORE SP;


-- ADD COLUNA COM CONDIÇÃO DE PROFIT POSITIVE E NEGATIVE, > 0 OU < 0
SELECT SP.City
	,SUM(SP.Profit) AS SUM_PROFIT 
	,(CASE WHEN SP.Profit > 0 THEN 'POSITIVE' ELSE 'NEGATIVE' END) as PROFIT_POSITIVE_NEGATIVE
FROM TB_SUPERSTORE SP
GROUP BY SP.City, SP.Profit
ORDER BY SUM_PROFIT DESC;


-- CALCULANDO % DO TOTAL E UTILIZANDO A FUNÇÃO COALESCE PARA SUBSTITUIR DADOS NULLO POR 'N/A'
SELECT 
    SP.City
    ,COALESCE(SP.Product_Name, 'N/A') AS PRODUCT_NAME
    ,SUM(SP.Sales) AS SUM_SALES
    ,ROUND(SUM(SP.Sales) / (SELECT SUM(S.Sales) FROM TB_SUPERSTORE S), 5) * 100 AS PERC_TOTAL
    ,ROUND((SELECT SUM(S.Sales) FROM TB_SUPERSTORE S), 2) AS SALES_TOTAL
FROM TB_SUPERSTORE SP
GROUP BY SP.City, SP.Product_Name
ORDER BY PERC_TOTAL DESC;


-- FILTER BY DATE
SELECT * FROM TB_SUPERSTORE SP 
WHERE SP.Order_Date = '2012-05-30';


-- FILTER BY YEAR
SELECT * FROM TB_SUPERSTORE SP 
WHERE SP.Order_Date = '2012-05-30';


-- COUNT REGISTERS BETWEEN DATES
SELECT COUNT(*) FROM TB_SUPERSTORE SP 
WHERE SP.Order_Date BETWEEN '2012-05-30' AND '2013-05-30';


-- CREATE COLUMNS YEAR, MONTH, DAY, SUM SALES AND COUNT REGISTERS BY DAY 
SELECT SP.Order_Date
		,YEAR(SP.Order_Date) AS ANO
		,MONTH(SP.Order_Date) AS MES
		,DAY(SP.Order_Date) AS DIA
		,COUNT(*) AS COUNT_REGISTER
		,ROUND(SUM(SP.Sales), 2) AS SUM_SALES
FROM TB_SUPERSTORE SP
GROUP BY SP.Order_Date
ORDER BY ANO, MES, DIA;


-- CONTAGEM APENAS DOS VALORES UNICOS
SELECT COUNT(DISTINCT SP.Product_Category) AS COUNTD_Product_Category 
FROM TB_SUPERSTORE SP;


-- MOSTRA OS NOMES DAS CIDADES DISTINTAS/UNICAS
SELECT DISTINCT SP.Product_Category AS COUNTD_Product_Category 
FROM TB_SUPERSTORE SP;


-- PROFIT YEAR AND MONTH
SELECT 
     YEAR(SP.Order_Date) AS ANO
    ,MONTH(SP.Order_Date) AS MES
    ,SP.Profit AS LUCRO
FROM TB_SUPERSTORE SP
ORDER BY 
    YEAR(SP.Order_Date),
    MONTH(SP.Order_Date);


-- SUBTRAÇÃO UNIT PRICE - DISCOUNT
SELECT  SP.Product_Category
		,SP.Unit_Price
		,SP.Discount
		,(SP.Unit_Price - SP.Discount) AS DIFF 
FROM TB_SUPERSTORE SP;









