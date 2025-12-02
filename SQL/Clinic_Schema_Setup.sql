-- Clinics
DROP TABLE IF EXISTS clinics;
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

-- Customers
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(20)
);

-- Clinic Sales
DROP TABLE IF EXISTS clinic_sales;
CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Expenses
DROP TABLE IF EXISTS expenses;
CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(255),
    amount DECIMAL(10,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Sample Data
INSERT INTO clinics VALUES 
('cnc-0100001','XYZ Clinic','lorem','ipsum','dolor');

INSERT INTO customer VALUES 
('bk-09f3e-95hj','Jon Doe','97XXXXXXXX');

INSERT INTO clinic_sales VALUES
('ord-00100-00100','bk-09f3e-95hj','cnc-0100001',24999,'2021-09-23 12:03:22','sodat');

INSERT INTO expenses VALUES
('exp-0100-00100','cnc-0100001','first-aid supplies',557,'2021-09-23 07:36:48');
