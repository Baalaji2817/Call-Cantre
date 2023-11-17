CREATE DATABASE callcentre;
USE callcentre;
CREATE TABLE CallData( ID CHAR(30) PRIMARY KEY,
CustomerName CHAR(30),
Sentiment CHAR(20),
CsatScore INT,
CallDate CHAR(10),
Reason CHAR(30),
City CHAR(30),
State CHAR(30),
ChannelType CHAR(20),
ResponseDate CHAR(20),
CallDuration INT,
CallCentre CHAR(30) 
);

SELECT * FROM CallData;
-- DROP TABLE CallData;

-- UPDATE CallData  SET CallTime = str_to_date(CallTime, "%m,%d,%Y");

-- ALTER TABLE CallData CHANGE CallDate DATETIME;

-- alter table CallData MODIFY COLUMN calldate DATE;
-- SET GLOBAL sql_mode = '';

SET SQL_SAFE_UPDATES = 0;
UPDATE CallData SET CallDate = str_to_date(CallDate, "%m/%d/%Y");
SET SQL_SAFE_UPDATES = 1;

-- update CallData set CallDate=NULL where CallDate<'0000-01-01';

-- SELECT str_to_date(CallDate, "%m/%d/%Y") from CallData where 1; 	

SELECT COUNT(*) AS ROWS_NUM FROM CallData;
SELECT COUNT(*) AS COLS_NUM FROM information_schema.columns WHERE table_name = 'CallData';

SELECT DISTINCT Sentiment from CallData;
SELECT DISTINCT ResponseDate from CallData;
SELECT DISTINCT Channeltype from CallData;
SELECT DISTINCT Reason from CallData;
SELECT DISTINCT CallCentre from CallData;

SELECT Sentiment, count(*), ROUND((COUNT(*)/(SELECT COUNT(*) FROM CallData))*100, 1) AS PCT FROM CallData GROUP BY 1 ORDER BY 3 DESC;
SELECT Reason, count(*), ROUND((COUNT(*)/(SELECT COUNT(*) FROM CallData))*100, 1) AS PCT FROM CallData GROUP BY 1 ORDER BY 3 DESC;
SELECT ChannelType, count(*), ROUND((COUNT(*)/(SELECT COUNT(*) FROM CallData))*100, 1) AS PCT FROM CallData GROUP BY 1 ORDER BY 3 DESC;
SELECT ResponseDate, count(*), ROUND((COUNT(*)/(SELECT COUNT(*) FROM CallData))*100, 1) AS PCT FROM CallData GROUP BY 1 ORDER BY 3 DESC;
SELECT CallCentre, count(*), ROUND((COUNT(*)/(SELECT COUNT(*) FROM CallData))*100, 1) AS PCT FROM CallData GROUP BY 1 ORDER BY 3 DESC;
SELECT State, count(*) FROM CallData GROUP BY 1 ORDER BY 2 DESC;

SELECT DAYNAME(CallDate) as Day_of_call, count(*) num_of_calls FROM CallData GROUP BY 1 ORDER BY 2 DESC;

-- AGGREGATIONS:

SELECT MIN(CsatScore) as min_csat_score, MAX(CsatScore) as max_csat_score, ROUND(AVG(CsatScore),1) FROM CallData WHERE CsatScore !=0;
SELECT MIN(CallDate) as earliest_date, MAX(CallDate) as most_recent FROM CallData;
SELECT MIN(CallDuration) as min_call_duration, MAX(CallDuration) as max_call_duration, AVG(CallDuration) as avg_call_duration FROM CallData;
SELECT CallCentre, ResponseDate, COUNT(*) FROM CallData GROUP BY 1,2 ORDER BY 1,3 DESC;
SELECT CallCentre, AVG(CallDuration) FROM CallData Group BY 1 ORDER BY 2 DESC;
SELECT ChannelType, AVG(CallDuration) FROM CallData Group BY 1 ORDER BY 2 DESC;
SELECT State, COUNT(*) FROM CallData Group BY 1 ORDER BY 2 DESC;
SELECT State,Reason, COUNT(*) FROM CallData Group BY 1,2 ORDER BY 1,2,3 DESC;
SELECT State,Sentiment, COUNT(*) FROM CallData Group BY 1,2 ORDER BY 1,3 DESC;
SELECT State, AVG(CsatScore) as avg_csat_score FROM CallData WHERE CsatScore !=0 Group BY 1 ORDER BY 2 DESC;
SELECT Sentiment, AVG(CallDuration) as avg_call_duration FROM CallData Group BY 1 ORDER BY 2 DESC;
SELECT CallDate, MAX(CallDuration) OVER(PARTITION BY CallDuration) as max_call_duration FROM CallData GROUP BY 1 ORDER BY 2 DESC;


