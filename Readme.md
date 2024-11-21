
# Database Design Summary: 

This document provides a summary of the database schema defined in the SQL file for a banking system.

## Tables and Their Descriptions

### 1. Branch
- **Columns**:
  - `branch_id` (Primary Key)
  - `branch_name`: Name of the branch
  - `branch_city`: City where the branch is located
  - `branch_contact`: Contact information for the branch
- **Purpose**: Stores details about branches of the bank.

---

### 2. Customer
- **Columns**:
  - `customer_id` (Primary Key)
  - `customer_name`: Full name of the customer
  - `customer_type`: Type of customer (e.g., Individual, Business)
  - `customer_address`: Address of the customer
  - `customer_contact`: Contact information for the customer
- **Purpose**: Maintains customer details.

---

### 3. Account
- **Columns**:
  - `account_number` (Primary Key)
  - `account_type`: Type of the account (e.g., Savings, Current)
  - `branch_id` (Foreign Key): References `Branch(branch_id)`
  - `opening_date`: Date the account was opened
  - `balance`: Current balance in the account (default: 0)
- **Relationships**:
  - Linked to `Branch` via `branch_id` with **cascade on delete/update**.
- **Purpose**: Represents bank accounts and their details.

---

### 4. Customer_Account (Associative Table)
- **Columns**:
  - `customer_id` (Foreign Key): References `Customer(customer_id)`
  - `account_number` (Foreign Key): References `Account(account_number)`
- **Composite Primary Key**: (`customer_id`, `account_number`)
- **Relationships**:
  - Links `Customer` and `Account` with **cascade on delete/update**.
- **Purpose**: Establishes many-to-many relationships between customers and accounts.

---



### 5. Employee

- **Columns**:

  - `employee_id`: Unique identifier for the employee

  - `employee_name`: Full name of the employee

  - `branch_id` (Foreign Key): References `Branch(branch_id)`

  - `employee_role`: Role of the employee in the bank (e.g., Manager, Teller)

  - `employee_contact`: Contact information for the employee

- **Relationships**:

  - Linked to `Branch` via `branch_id`.

- **Purpose**: Holds information about employees, including their roles and branch assignments.



---




### 6. Loan
- **Columns**:
  - `loan_id`: Unique identifier for the loan
  - `branch_id` (Foreign Key): References `Branch(branch_id)`
  - `account_number` (Foreign Key): References 'Account (account_number)'
  - `loan_type`: Type of loan (e.g., Home, Personal, Vehicle)
  - `loan_amount`: Total amount of the loan
  - `interest_rate`: Interest rate applicable to the loan
  - `starting_date`: Date the loan started
  - `ending_date`: Expected end date of the loan
  - `loan_status`: Current status of the loan (e.g., Active, Closed, Defaulted)
- **Relationships**:
  - Linked to `Branch` and `Account` via foreign keys.
- **Purpose**: Tracks loan details associated with accounts and branches

---

### 7. EMI
- **Columns**:
- `loan_id `(Primary Key, Foreign Key): References Loan(loan_id)
- `current_payment_number`: Current EMI installment number
- `remaining_payments`: Number of payments left
- `payment_amount`: Amount to be paid per EMI
- `paid_amount`: Amount already paid
- `due_date`: Next payment due date
- `emi_status`: Status of the EMI (e.g., Paid, Pending, Overdue)
- **Relationships**:
  - Linked to `Loan` with cascade on delete/update
- **Purpose**: Manages EMI schedules and payment tracking for loans

---

### 8. Transaction
- **Columns**:
-  `transaction_id` (Primary Key): Unique identifier for the transaction
- `account_number` (Foreign Key): References Account(account_number)
- `timestamp`: Date and time of the transaction
- `transaction_type`: Type of transaction (e.g., Credit, Debit)
- `transaction_amount`: Amount involved in the transaction
- **Relationships**:
  - Linked to `Account` via foreign key
- **Purpose**: Records all financial transactions related to accounts, including deposits, withdrawals, and fund transfers.

---

### 9. EMI_Transactions
- **Columns**:
- `loan_id` (Foreign Key): References Loan(loan_id)
- `emi_number`: EMI installment number
- `transaction_id` (Foreign Key): References Transactions(transaction_id)
- **Relationships**:
  - Linked to `Loan` and `Transaction` via foreign keys
- **Purpose**: Records all transaction ids for EMIs paid for each loan

---
## Key Features
- **Referential Integrity**: Enforced via foreign key constraints with cascade operations.
- **Multi-Entity Relationships**: Efficient linking of customers, accounts, and branches.
- **Structured Design**: Includes separate tables for entities like branches, customers, accounts, and employees.
