create database cia;
use cia;

CREATE TABLE branch (
branch_id INT PRIMARY KEY,
branch_name VARCHAR(50),
branch_city VARCHAR(20),
branch_contact VARCHAR(20)
);

CREATE TABLE customer (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
customer_type VARCHAR(20),
customer_address VARCHAR(50),
customer_contact VARCHAR(20)
);

CREATE TABLE account (
account_number INT PRIMARY KEY,
account_type VARCHAR(10),
branch_id INT ,
opening_date DATE,
balance double default 0,
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE ON UPDATE CASCADE
);

create table customer_account (
customer_id INT,
account_number INT,
PRIMARY KEY(customer_id,account_number),
FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(account_number) REFERENCES account(account_number) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE employee (
employee_id INT,
employee_name VARCHAR(50),
branch_id INT,
employee_role VARCHAR(50),
employee_contact VARCHAR(20),
FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE transaction (
transaction_id INT AUTO_INCREMENT,
account_number INT,
time_stamp TIMESTAMP,
amount DOUBLE,
transaction_type ENUM('debit', 'credit'),
reference_id INT DEFAULT NULL,
PRIMARY KEY(transaction_id),
FOREIGN KEY(account_number) REFERENCES account(account_number) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(reference_id) REFERENCES transaction(transaction_id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE Loan (
loan_id INT PRIMARY KEY,
branch_id INT,
account_number INT,
loan_type VARCHAR(20),
Loan_amount DOUBLE,
interest_rate FLOAT,
starting_date DATE,
ending_date DATE,
loan_status VARCHAR(20),
FOREIGN KEY (account_number) REFERENCES account(account_number),
FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

CREATE TABLE Emi (
loan_id INT PRIMARY KEY,
current_payment_number INT,
remaining_payments INT,
payment_amount DOUBLE,
paid_amount DOUBLE,
due_date DATE,
emi_status VARCHAR(20),
FOREIGN KEY (loan_id) REFERENCES loan(loan_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Emi_Transactions (
loan_id INT,
emi_number INT,
transaction_id INT,
FOREIGN KEY (loan_id) REFERENCES loan(loan_id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (transaction_id) REFERENCES transaction(transaction_id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(loan_id,emi_number)
);














