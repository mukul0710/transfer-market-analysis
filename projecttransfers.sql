CREATE TABLE your_table (
    day DATE,
    name VARCHAR(100),
    age INT,
    positions VARCHAR(50),
    nationality VARCHAR(50),
    from_club VARCHAR(100),
    from_league VARCHAR(50),
    from_country VARCHAR(50),
    to_club VARCHAR(100),
    to_league VARCHAR(50),
    to_country VARCHAR(50),
    MARKET_VALUE DECIMAL(10, 2), 
    TRANSFER_FEE DECIMAL(10, 2) 
);

-- @block
USE transfers;
SELECT count(*) FROM your_table;

-- @block
USE transfers;
LOAD DATA INFILE 'C:/Users/Mukul/OneDrive/Documents/DATATRANSFERS.csv'
INTO TABLE your_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 2 LINES;

-- KEY PERFORMANCE INDICATORS

-- @block
-- total transfers
SELECT count(*) as number_of_transfers FROM your_table;

-- @block
-- Average Transfer Fee
SELECT AVG(TRANSFER_FEE) AS AVG_FEE FROM your_table;

-- @block
-- average age of transfered player
SELECT AVG(age) as avg_age FROM your_table
WHERE TRANSFER_FEE > 0 ;

-- @block
-- largest transfer fee
SELECT MAX(TRANSFER_FEE) AS highest_transfer_fee 
FROM your_table;

-- @block
-- SUM OF MARKET VALUE OF ALL TRANSFERED PLAYERS
SELECT SUM(MARKET_VALUE) AS TOTAL_MARKET_VALUE 
FROM your_table
WHERE TRANSFER_FEE > 0;

-- @block
-- number of free transfers
SELECT COUNT(*) AS no_of_free_transfer FROM your_table
WHERE TRANSFER_FEE = 0 ;

-- GRAPH QUESTIONS
-- @block
-- TRANSFER VOLUME
SELECT 
    day,
    COUNT(*) AS TransferCount
FROM your_table
GROUP BY day
ORDER BY day;


-- @block
-- MARKET VALUE VS TRANSFER FEES
SELECT
    CASE
        WHEN MARKET_VALUE >= 0 AND MARKET_VALUE <= 50 THEN '0-50'
        WHEN MARKET_VALUE > 50 AND MARKET_VALUE <= 100 THEN '50-100'
        WHEN MARKET_VALUE > 100 AND MARKET_VALUE <= 150 THEN '100-150'
        ELSE 'Other'
    END AS MARKET_VALUE_RANGE,
    AVG(TRANSFER_FEE) AS AVG_FEE
FROM
    your_table
WHERE
    TRANSFER_FEE IS NOT NULL
    AND MARKET_VALUE IS NOT NULL
GROUP BY
    CASE
        WHEN MARKET_VALUE >= 0 AND MARKET_VALUE <= 50 THEN '0-50'
        WHEN MARKET_VALUE > 50 AND MARKET_VALUE <= 100 THEN '50-100'
        WHEN MARKET_VALUE > 100 AND MARKET_VALUE <= 150 THEN '100-150'
        ELSE 'Other'
    END
ORDER BY
    MIN(MARKET_VALUE);

-- @block
-- most spending club
SELECT to_league, to_country, count(*) as no_transfer, SUM(TRANSFER_FEE) as total_transfer_fee
FROM your_table
GROUP BY to_league, to_country
ORDER BY total_transfer_fee DESC
LIMIT 20;


-- @block
-- avg transfer fee and age vs player position
SELECT AVG(TRANSFER_FEE) AS AvgTransferFee, AVG(age) AS avg_age, Positions 
FROM your_table
WHERE TRANSFER_FEE > 0
GROUP BY Positions;





