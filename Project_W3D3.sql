-- Question 01: Retrieve Title, First Name, Last Name, and Date of Birth from the Customer table

USE Sports_Gambling;
SELECT Title, FirstName, LastName, DateOfBirth
FROM Sports_Gambling.`sql test data_customer`;


-- Question 02: Count the number of customers in each customer group

-- To get the count of customers in each customer group, I used the GROUP BY clause
-- along with the COUNT function:
USE Sports_Gambling;
SELECT CustomerGroup, COUNT(*) AS CustomerCount
FROM Sports_Gambling.`sql test data_customer`
GROUP BY CustomerGroup;
-- This query groups the rows from the customer table by the Customer_Group column and 
-- counts the number of rows in each group using the COUNT(*) function.
-- The result shows the Customer_Group and the corresponding Customer_Count.



-- Question 03: Retrieve customer data with currency code from the Account table

-- To retrieve all customer data along with the currency code from the account table, I joined the customer 
-- and account tables:
USE Sports_Gambling;
SELECT CurrencyCode
FROM Sports_Gambling.`sql test data_account` a
JOIN Sports_Gambling.`sql test data_customer` c
	ON Sports_Gambling.`sql test data_customer`.Custid = ports_Gambling.`sql test data_account`.Custid;
    -- The intention of this query is to join the Customer table with the Account table  using the Custid column as the join
    -- condition. It is suppose to selects various columns from the Customer table along with the CurrencyCode column from the
    -- account table.



-- Question 04: Summarize the bet amount by product and day
-- To generate a summary report showing the total bet amount by product and day, I joined the betting, product, and 
-- potentially other relevant tables:
USE Sports_Gambling;
SELECT p.SourceProd AS Product, b.BetDate, SUM(b.Bet_Amt) AS TotalBetAmount
FROM Betting b
JOIN Account a ON b.AccountNo = a.AccountNo
JOIN Product p ON a.SourceProd = p.SourceProd
GROUP BY p.SourceProd, b.BetDate;

-- This query joins the Betting table (aliased as b) with the Account table (aliased as a) and the Product table (aliased as p) 
-- using the AccountNo and SourceProd columns as join conditions. It calculates the sum of Bet_Amt grouped by
--  SourceProd (aliased as Product) and BetDate



-- Question 05: Summarize Sportsbook transactions on or after November 1st
-- To modify the report from Question 4 to include only Sportsbook transactions on or after November 1st, I added a WHERE clause
--  to filter the data:
USE Sports_Gambling;
SELECT p.SourceProd AS Product, b.BetDate, SUM(b.Bet_Amt) AS TotalBetAmount
FROM Betting b
JOIN Account a ON b.AccountNo = a.AccountNo
JOIN Product p ON a.SourceProd = p.SourceProd
WHERE p.SourceProd LIKE 'Sportsbook%' AND b.BetDate >= '2023-11-01'
GROUP BY p.SourceProd, b.BetDate;
-- This query is similar to Question 04, but it adds a WHERE clause to filter the results. It selects only the transactions where the SourceProd starts with 'Sportsbook' and the BetDate is on or
--  after '2023-11-01'.



-- Question 06: Summarize transactions after December 1st by currency code and customer group
-- To generate the report with the requested modifications, we need to join the betting, product, customer, and account tables:
USE Sports_Gambling;
SELECT p.SourceProd AS Product, a.CurrencyCode, c.CustomerGroup, SUM(b.Bet_Amt) AS TotalBetAmount
FROM Betting b
JOIN Account a ON b.AccountNo = a.AccountNo
JOIN Customer c ON a.Custid = c.Custid
JOIN Product p ON a.SourceProd = p.SourceProd
WHERE b.BetDate > '2023-12-01'
GROUP BY p.SourceProd, a.CurrencyCode, c.CustomerGroup;
-- This query joins the Betting table (aliased as b) with the Account table (aliased as a), the Customer table (aliased as c), 
-- and the Product table (aliased as p) using the appropriate join conditions. It calculates the sum of Bet_Amt grouped by 
-- SourceProd (aliased as Product), CurrencyCode, and CustomerGroup. The WHERE clause filters the results to include only 
-- transactions after '2023-12-01'.



-- Question 07: Retrieve all players with their bet amount summary for November
-- To retrieve all players' information along with their total bet amount for November, I performed a left join between the 
-- customer and betting tables:
USE Sports_Gambling;
SELECT c.Title, c.FirstName, c.LastName, COALESCE(SUM(b.Bet_Amt), 0) AS TotalBetAmount
FROM Customer c
LEFT JOIN Account a ON c.Custid = a.Custid
LEFT JOIN Betting b ON a.AccountNo = b.AccountNo AND b.BetDate BETWEEN '2023-11-01' AND '2023-11-30'
GROUP BY c.Title, c.FirstName, c.LastName;
-- Note: This query uses a LEFT JOIN to include all customers from the Customer table (aliased as c), even if they don't have any 
-- associated records in the Account table (aliased as a) or the Betting table (aliased as b). It calculates the sum of Bet_Amt 
-- for each customer during the month of November (between '2023-11-01' and '2023-11-30'). The COALESCE function is used to 
-- replace NULL values with 0 for customers who didn't have any bets.



-- Question 08: Count the number of products per player and identify players playing both Sportsbook and Vegas
-- Number of products per player
USE Sports_Gambling;
SELECT a.AccountNo, COUNT(DISTINCT p.SourceProd) AS ProductCount
FROM Account a
JOIN Betting b ON a.AccountNo = b.AccountNo
JOIN Product p ON a.SourceProd = p.SourceProd
GROUP BY a.AccountNo;

-- Players playing both Sportsbook and Vegas
SELECT c.Title, c.FirstName, c.LastName
FROM Customer c
JOIN Account a ON c.Custid = a.Custid
JOIN Betting b ON a.AccountNo = b.AccountNo
JOIN Product p ON a.SourceProd = p.SourceProd
WHERE p.SourceProd LIKE 'Sportsbook%' AND EXISTS (
    SELECT 1
    FROM Betting b2
    JOIN Account a2 ON b2.AccountNo = a2.AccountNo
    JOIN Product p2 ON a2.SourceProd = p2.SourceProd
    WHERE a2.Custid = c.Custid AND p2.SourceProd LIKE 'Vegas%'
)
GROUP BY c.Title, c.FirstName, c.LastName;

-- This solution consists of two separate queries.
-- The first query counts the number of distinct SourceProd values for each AccountNo by joining the Account table (aliased as a) 
-- with the Betting table (aliased as b) and the Product table (aliased as p). It groups the results by AccountNo and counts 
-- the distinct SourceProd values using COUNT(DISTINCT p.SourceProd).

-- The second query identifies players who have played both 'Sportsbook' and 'Vegas' products. It joins the Customer table 
-- (aliased as c) with the Account table (aliased as a), the Betting table (aliased as b), and the Product table (aliased as p). 
-- The WHERE clause filters the results to include only transactions where the SourceProd starts with 'Sportsbook', 
-- and it uses an EXISTS subquery to check if the customer has also played a product starting with 'Vegas'. The results are 
-- grouped by Title, FirstName, and LastName.



-- Question 09: Retrieve players who only play Sportsbook with their bet amount.
-- To retrieve players who only play Sportsbook and show the sum of their bets for both Sportsbook and Vegas products, I used
--  the following query:
USE Sports_Gambling;
SELECT c.Title, c.FirstName, c.LastName, SUM(b.Bet_Amt) AS TotalBetAmount
FROM Customer c
JOIN Account a ON c.Custid = a.Custid
JOIN Betting b ON a.AccountNo = b.AccountNo
JOIN Product p ON a.SourceProd = p.SourceProd
WHERE p.SourceProd LIKE 'Sportsbook%'
AND NOT EXISTS (
    SELECT 1
    FROM Betting b2
    JOIN Account a2 ON b2.AccountNo = a2.AccountNo
    JOIN Product p2 ON a2.SourceProd = p2.SourceProd
    WHERE a2.Custid = c.Custid AND p2.SourceProd NOT LIKE 'Sportsbook%'
)
GROUP BY c.Title, c.FirstName, c.LastName;

-- Note: This query retrieves players who have only played 'Sportsbook' products by joining the Customer table (aliased as c) with the
-- Account table (aliased as a), the Betting table (aliased as b), and the Product table (aliased as p). The WHERE clause filters 
-- the results to include only transactions where the SourceProd starts with 'Sportsbook'. It uses a NOT EXISTS subquery to exclude 
-- customers who have played products other than 'Sportsbook'. The results are grouped by Title, FirstName, and LastName, and the 
-- sum of Bet_Amt is calculated for each player.



-- Question 10: Determine each player's favorite product based on the highest bet amount
-- To determine each player's favorite product based on the highest total bet amount, we can use the following query:
WITH PlayerBets AS (
    SELECT c.Title, c.FirstName, c.LastName, p.SourceProd, SUM(b.Bet_Amt) AS TotalBetAmount
    FROM Customer c
    JOIN Account a ON c.Custid = a.Custid
    JOIN Betting b ON a.AccountNo = b.AccountNo
    JOIN Product p ON a.SourceProd = p.SourceProd
    GROUP BY c.Title, c.FirstName, c.LastName, p.SourceProd
)
SELECT Title, FirstName, LastName, SourceProd AS FavoriteProduct
FROM (
    SELECT Title, FirstName, LastName, SourceProd, TotalBetAmount,
           RANK() OVER (PARTITION BY Title, FirstName, LastName ORDER BY TotalBetAmount DESC) AS Rank
    FROM PlayerBets
) t
WHERE Rank = 1;
-- This query uses a common table expression (CTE) named PlayerBets to calculate the total bet amount for each player and product 
-- combination. It joins the Customer table (aliased as c) with the Account table (aliased as a), the Betting table (aliased as b),
--  and the Product table (aliased as p), and groups the results by Title, FirstName, LastName, and SourceProd.

-- The main query then uses the RANK() window function to rank the products for each player based on the TotalBetAmount in 
-- descending order. It partitions the ranking by Title, FirstName, and LastName to ensure that the ranking is done separately for 
-- each player. The WHERE clause filters the results to include only the rows with Rank = 1, which represents the product with 
-- the highest bet amount for each player. The SourceProd column is aliased as FavoriteProduct in the output.



-- Question 11: Retrieve the top 5 students based on GPA
USE Hogeschool;
SELECT student_name, GPA
FROM student_school
ORDER BY GPA DESC
LIMIT 5;

-- This query selects the Name and GPA columns from the Student_School table, orders the results by GPA in descending order, 
-- and limits the output to the first 5 rows using the LIMIT clause.


-- Question 12: Count the number of students in each school
USE Hogeschool;
SELECT
    school_id,
    school_name,
    COUNT(student_id) AS TotalStudents
FROM
    Student_School
GROUP BY
    school_id,
    school_name;

-- This query counts the number of students for each school by grouping the results based on school_id and school_name.



-- Question 13: Retrieve the top 3 GPA students' names from each university

USE student_school;
SELECT school_name, student_name, GPA
FROM (
    SELECT school_name, student_name, GPA, RANK() OVER (PARTITION BY school_name ORDER BY GPA DESC) 
    AS GpaRank
    FROM Student_School
) 
WHERE GPA <= 3
ORDER BY school_name, GPA DESC;

 -- This query uses a derived table (subquery) to rank the students within each school based on their GPA in descending order using 
 -- the RANK() window function. It partitions the ranking by School to ensure that the ranking is done separately for each school. 
 -- The outer query then selects the School and Name columns from the derived table, filters the results to include only the rows 
 -- with Rank <= 3 (top 3 GPA students), and orders the output by School and Rank.