-- Q1: last booked room per user
SELECT u.user_id,
       b.room_no,
       b.booking_date
FROM users u
LEFT JOIN (
    SELECT booking_id, user_id, room_no, booking_date,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) AS rn
    FROM bookings
) b ON u.user_id = b.user_id AND b.rn = 1;

-- Q2: booking_id and total billing amount for bookings created in Nov 2021
SELECT bc.booking_id,
       SUM(bc.item_quantity * it.item_rate) AS total_amount
FROM booking_commercials bc
JOIN items it ON bc.item_id = it.item_id
JOIN bookings b ON bc.booking_id = b.booking_id
WHERE YEAR(b.booking_date) = 2021 AND MONTH(b.booking_date) = 11
GROUP BY bc.booking_id;

-- Q3: bills in Oct 2021 with amount > 1000
SELECT bc.bill_id,
       SUM(bc.item_quantity * it.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items it ON bc.item_id = it.item_id
WHERE YEAR(bc.bill_date) = 2021
  AND MONTH(bc.bill_date) = 10
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * it.item_rate) > 1000;

-- Q4: most and least ordered item per month in 2021
SELECT
    DATE_FORMAT(bc.bill_date, '%Y-%m') AS `year_month`,
    bc.item_id,
    it.item_name,
    SUM(bc.item_quantity) AS total_qty
FROM booking_commercials AS bc
JOIN items AS it
    ON bc.item_id = it.item_id
WHERE YEAR(bc.bill_date) = 2021
GROUP BY
    `year_month`,
    bc.item_id,
    it.item_name;
