#!/bin/bash

set -e

echo "PostgreSQL starting..."
# Disable log messages 
command >/dev/null 2>&1 
# Execute your init scripts here 


# PostgreSQL hizmetini başlat
service postgresql start

sleep 5

# "test" adında bir veritabanı oluştur
su - postgres -c "psql -U postgres -c 'CREATE DATABASE test;'"
# "test" veritabanına bağlan
su - postgres -c "psql -U postgres -d test -c \"CREATE TABLE customers (
CustomerID SERIAL PRIMARY KEY, 
CustomerName varchar(100) DEFAULT NULL, 
ContactName varchar(100) DEFAULT NULL, 
City varchar(100) DEFAULT NULL, 
Address varchar(100) DEFAULT NULL, 
PostalCode varchar(10) DEFAULT NULL, 
Country varchar(100) DEFAULT NULL);
copy public.customers FROM '/mock/customers.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE categories( 
CategoryID SERIAL PRIMARY KEY, 
CategoryName varchar(100) DEFAULT NULL, 
Description text DEFAULT NULL);
copy public.categories FROM '/mock/categories.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE employees( 
EmployeeID SERIAL PRIMARY KEY, 
LastName varchar(100) DEFAULT NULL, 
FirstName varchar(100) DEFAULT NULL, 
Date varchar(25) DEFAULT NULL, 
Photo bytea DEFAULT NULL, 
Notes text DEFAULT NULL);
copy public.employees FROM '/mock/employees.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE shippers( 
ShipperID SERIAL PRIMARY KEY, 
ShipperName varchar(100) DEFAULT NULL, 
Phone varchar(20) DEFAULT NULL);
copy public.shippers FROM '/mock/shippers.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE orders( 
OrderID SERIAL PRIMARY KEY, 
CustomerID  int REFERENCES customers(CustomerID), 
EmployeeID int REFERENCES employees(EmployeeID), 
OrderDate varchar(25) DEFAULT NULL, 
ShipperID int REFERENCES shippers(ShipperID));
copy public.orders FROM '/mock/orders.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE suppliers( 
SupplierID SERIAL PRIMARY KEY, 
SupplierName varchar(100) DEFAULT NULL, 
ContactName varchar(100) DEFAULT NULL, 
Address varchar(100) DEFAULT NULL, 
City varchar(100) DEFAULT NULL, 
PostalCode varchar(10) DEFAULT NULL, 
Country varchar(100) DEFAULT NULL, 
Phone varchar(20) DEFAULT NULL);
copy public.suppliers FROM '/mock/suppliers.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE products( 
ProductID SERIAL PRIMARY KEY, 
ProductName varchar(100) DEFAULT NULL, 
SupplierID int REFERENCES suppliers(SupplierID), 
CategoryID int REFERENCES categories(CategoryID), 
Unit varchar(50) DEFAULT NULL, 
Price decimal(10, 2) DEFAULT NULL);
copy public.products FROM '/mock/products.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE orderDetails( 
OrderDetailID SERIAL PRIMARY KEY, 
OrderID int REFERENCES orders(OrderID), 
ProductID int REFERENCES products(ProductID), 
Quantity int DEFAULT NULL);
copy public.orderDetails FROM '/mock/orderDetails.csv' DELIMITER ';' CSV HEADER; \""

# Re-enable log messages 
# command >/dev/tty 2>&1 
echo "PostgreSQL started success"
# Redirect output to console

# Shell'i başlat
#su - postgres
#/bin/bash

exec "$@"