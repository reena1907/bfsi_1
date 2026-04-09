create database if not exists bank_system;
use bank_system;
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    account_type ENUM('savings', 'current'),
    account_balance DECIMAL(10 , 2 ) DEFAULT 0
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10 , 2 ),
    transaction_type VARCHAR(10),
    transaction_mode VARCHAR(20),
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
);

insert into customer(name,email,city,account_type,account_balance)values

('Amit Sharma', 'amit.sharma@gmail.com', 'Delhi', 'Savings', 5000.00),
('Priya Reddy', 'priya.reddy@gmail.com', 'Hyderabad', 'Current', 12000.50),
('Rahul Verma', 'rahul.verma@gmail.com', 'Mumbai', 'Savings', 8000.75),
('Sneha Iyer', 'sneha.iyer@gmail.com', 'Chennai', 'Savings', 6500.00),
('Karan Mehta', 'karan.mehta@gmail.com', 'Pune', 'Current', 15000.00),
('Anjali Gupta', 'anjali.gupta@gmail.com', 'Kolkata', 'Savings', 7200.25),
('Vikram Singh', 'vikram.singh@gmail.com', 'Jaipur', 'Current', 11000.00),
('Neha Patel', 'neha.patel@gmail.com', 'Ahmedabad', 'Savings', 5400.00),
('Arjun Nair', 'arjun.nair@gmail.com', 'Kochi', 'Savings', 9000.00),
('Pooja Das', 'pooja.das@gmail.com', 'Bangalore', 'Current', 13000.00);

INSERT INTO transactions (customer_id, amount, transaction_type, transaction_mode, transaction_date) VALUES
(1, 1000, 'credit', 'UPI', '2026-04-01 10:00:00'),
(1, -200, 'debit', 'ATM', '2026-04-02 12:00:00'),
(2, -500, 'debit', 'NEFT', '2026-04-03 09:30:00'),
(3, 1500, 'credit', 'IMPS', '2026-04-04 11:15:00'),
(4, -300, 'debit', 'UPI', '2026-04-05 14:20:00'),
(5, 2000, 'credit', 'ATM', '2026-04-06 16:45:00'),
(6, -700, 'debit', 'NEFT', '2026-04-07 18:00:00'),
(7, 800, 'credit', 'IMPS', '2026-04-08 08:10:00'),
(8, -400, 'debit', 'UPI', '2026-04-08 19:00:00'),
(9, 1200, 'credit', 'ATM', '2026-04-09 07:50:00');

SELECT 
    name, account_balance
FROM
    customer
WHERE
    account_balance > 1500;

SELECT 
    *
FROM
    transactions
ORDER BY transaction_date DESC;

SELECT DISTINCT
    transaction_mode
FROM
    transactions;

SELECT 
    *
FROM
    transactions
ORDER BY amount DESC
LIMIT 5;

SELECT 
    *
FROM
    customer
WHERE
    name LIKE 'a%';

SELECT 
    customer_id, SUM(amount) AS total_amount
FROM
    transactions
GROUP BY customer_id;

SELECT 
    c.name, t.amount, t.transaction_type
FROM
    customer c
        JOIN
    transactions t ON c.customer_id = t.customer_id;

select customer_id,amount,sum(amount) over(partition by customer_id order by transaction_date) as running_total from transactions;

select customer_id,name,account_balance,dense_rank() over(order by account_balance desc) as rank_position from customer;

SELECT 
    customer_id, AVG(amount) AS avg_amount
FROM
    transactions
GROUP BY customer_id
HAVING AVG(amount) > (SELECT 
        AVG(amount)
    FROM
        transactions);
        
      SELECT 
    customer_id, SUM(amount) AS total_amount
FROM
    transactions
GROUP BY customer_id
HAVING SUM(amount) > 2000;
