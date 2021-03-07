WITH newTemp AS (WITH temptable AS (
SELECT * FROM invoices WHERE "customerId" IN (SELECT "customerId" FROM invoices WHERE "organizationId" IN (SELECT id FROM ORGANIZATIONS WHERE name = 'Blue Consulting')
) AND "status" = 'OVERDUE')
Select *,
CASE WHEN (CURRENT_TIMESTAMP > "dueDate") AND (CURRENT_TIMESTAMP <= "dueDate" + '30 day'::interval) THEN "amountOutstanding"
ELSE '0'
END 
AS ThirtyDayBracket,
CASE WHEN (CURRENT_TIMESTAMP >= "dueDate" + '31 day'::interval) AND (CURRENT_TIMESTAMP <= "dueDate" + '60 day'::interval) THEN "amountOutstanding"
ELSE '0'
END 
AS SixtyDayBracket,
CASE WHEN (CURRENT_TIMESTAMP >= "dueDate" + '61 day'::interval) AND (CURRENT_TIMESTAMP <= "dueDate" + '90 day'::interval) THEN "amountOutstanding"
ELSE '0'
END 
AS NintyDayBracket,
CASE WHEN (CURRENT_TIMESTAMP >= "dueDate" + '91 day'::interval) THEN "amountOutstanding"
ELSE '0'
END 
AS GreaterThanNintyBracket from temptable)
Select SUM ("amountOutstanding") AS totalAmountOutstanding, SUM(ThirtyDayBracket) AS ThirtyDayBracket,SUM(SixtyDayBracket) AS SixtyDayBracket,SUM(NintyDayBracket) AS NintyDayBracket,SUM(GreaterThanNintyBracket) AS GreaterThanNintyBracket from newTemp;

