/*
 * Create a rocky concrete database without any integrity constraints. 
 */  

/* Set date format */
alter session set nls_date_format = 'DD/MM/YYYY'; 
 
/* Remove any existing tables
 * Customers, Products, Orders, Order_details
 */
 
drop table order_details;
drop table orders;
drop table products;
drop table customers; 

/*  Data Definition */
 
CREATE TABLE CUSTOMERS
        (CUST_NO        INTEGER         ,
        CUST_NAME       VARCHAR(40)     ,
        STREET          VARCHAR(40)     ,
        TOWN            VARCHAR(40)     ,
        POSTCODE        INTEGER         ,
        CR_LIMIT        INTEGER         ,
        CURR_BALANCE    INTEGER         ,
        PRIMARY KEY (CUST_NO));
 
CREATE TABLE PRODUCTS
        (PROD_COD       VARCHAR(10)     ,
        DESCRIPTION     VARCHAR(50)     ,
        PROD_GROUP      CHAR(1)         , 
        LIST_PRICE      INTEGER         ,
        QTY_ON_HAND     INTEGER         ,
        REMAKE_LEVEL    INTEGER         ,
        REMAKE_QTY      INTEGER         ,
        PRIMARY KEY     (PROD_COD)      );
       
 
CREATE TABLE ORDERS
        (ORDER_NO       INTEGER         ,
        ORDER_DATE      DATE            ,
        CUST_NO         INTEGER         ,
        PRIMARY KEY (ORDER_NO)          ,
        FOREIGN KEY     (CUST_NO) REFERENCES CUSTOMERS(CUST_NO));
 
CREATE TABLE ORDER_DETAILS
        (ORDER_NO       INTEGER         ,
        PROD_COD        VARCHAR(10)     ,
        ORDER_QTY       INTEGER         ,
        ORDER_PRICE     INTEGER         ,
        PRIMARY KEY (ORDER_NO, PROD_COD),
        FOREIGN KEY (ORDER_NO) REFERENCES ORDERS(ORDER_NO),
        FOREIGN KEY (PROD_COD) REFERENCES PRODUCTS(PROD_COD));

INSERT INTO Customers VALUES (1066, 'Nev''s Nursery', 'White Hart Lane', 'Bundoora', 3083, 500, 450);
INSERT INTO Products VALUES('MOO', 'Medium Cattle trough', 'A', 150, 6, 3, 5);
INSERT INTO Orders VALUES(1, '07-07-1993', 1066);
INSERT INTO Order_Details VALUES(1, 'MOO', 10, 45);
