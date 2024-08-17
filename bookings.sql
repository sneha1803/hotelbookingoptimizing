USE hotel_otpmzn;
SELECT * FROM hotel_bookings;
SET SQL_SAFE_UPDATES=0;

-- Add a Column for the Month Number of Arrival Date 
SELECT DISTINCT arrival_date_month, COUNT(*) FROM hotel_bookings GROUP BY arrival_date_month;
ALTER TABLE hotel_bookings ADD COLUMN arrival_date_month_number VARCHAR(20);
UPDATE hotel_bookings SET arrival_date_month_number='1' WHERE arrival_date_month LIKE 'Jan%';
UPDATE hotel_bookings SET arrival_date_month_number='2' WHERE arrival_date_month LIKE 'Feb%';
UPDATE hotel_bookings SET arrival_date_month_number='3' WHERE arrival_date_month LIKE 'Mar%';
UPDATE hotel_bookings SET arrival_date_month_number='4' WHERE arrival_date_month LIKE 'Apr%';
UPDATE hotel_bookings SET arrival_date_month_number='5' WHERE arrival_date_month LIKE 'May%';
UPDATE hotel_bookings SET arrival_date_month_number='6' WHERE arrival_date_month LIKE 'Jun%';
UPDATE hotel_bookings SET arrival_date_month_number='7' WHERE arrival_date_month LIKE 'Jul%';
UPDATE hotel_bookings SET arrival_date_month_number='8' WHERE arrival_date_month LIKE 'Aug%';
UPDATE hotel_bookings SET arrival_date_month_number='9' WHERE arrival_date_month LIKE 'Sep%';
UPDATE hotel_bookings SET arrival_date_month_number='10' WHERE arrival_date_month LIKE 'Oct%';
UPDATE hotel_bookings SET arrival_date_month_number='11' WHERE arrival_date_month LIKE 'Nov%';
UPDATE hotel_bookings SET arrival_date_month_number='12' WHERE arrival_date_month LIKE 'Dec%';


-- D A T A   A N A L Y S I S

-- A] LOST REVENUE DUE TO CANCELLATIONS
SELECT SUM(adr) AS LossofRev, reservation_status FROM hotel_bookings GROUP BY reservation_status;

-- B] GENERAL EXPLORATIONS
-- i. What are the Top 10 Companyies by Reveneue?
SELECT DISTINCT company, SUM(adr) AS Revenue FROM hotel_bookings GROUP BY company ORDER BY Revenue DESC LIMIT 11 ;

-- ii. What are the Top 10 Agents by Revenue
SELECT DISTINCT agent, SUM(adr) AS Revenue FROM hotel_bookings GROUP BY agent ORDER BY Revenue DESC LIMIT 11 ;

-- iii. what are the Top Market Segments by Revenue
SELECT DISTINCT market_segment, SUM(adr) AS Revenue FROM hotel_bookings
GROUP BY market_segment ORDER BY Revenue DESC;

-- iv. what are the Top 10 Countries by Revenue
SELECT DISTINCT country, SUM(adr) AS Revenue FROM hotel_bookings GROUP BY country ORDER BY Revenue DESC LIMIT 10;

-- v. How are differnet Countries's revenues distributed in terms of market segments?
SELECT DISTINCT country,market_segment, SUM(adr) AS Revenue FROM hotel_bookings
GROUP BY country, market_segment ORDER BY Revenue DESC;


-- C] LEARNING ABOUT CANCELLATIONS
-- i. Do the Cancellations co-relate to higher room rates?
SELECT DISTINCT reservation_status, COUNT(*), AVG(adr) FROM hotel_bookings GROUP BY reservation_status;

-- ii. Do the Cancellations co-relate to a high waiting list?
SELECT DISTINCT reservation_status, COUNT(*), AVG(days_in_waiting_list) FROM hotel_bookings GROUP BY reservation_status;

-- iii. Do the Cancellations co-relate to room types?
SELECT DISTINCT  assigned_room_type, reservation_status, COUNT(*) FROM hotel_bookings
GROUP BY reservation_status, assigned_room_type ORDER BY assigned_room_type,reservation_status ;

SELECT DISTINCT(assigned_room_type), AVG(ADR) FROM hotel_bookings
GROUP BY assigned_room_type ORDER BY AVG(ADR) DESC;

-- iv. Do the Cancellations co-relate to market segments?
SELECT DISTINCT  market_segment, reservation_status, COUNT(*) FROM hotel_bookings
GROUP BY reservation_status, market_segment ORDER BY market_segment,reservation_status ;



