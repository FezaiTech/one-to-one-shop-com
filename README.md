# OneToOneShop


**OneToOneShop** is a Java Web App Project. 

## Web Programming Course Final Project

This is the final project prepared for the Web Programming course. The project requirements are as follows:

- [x] Requirement 1: The project should have a different Bootstrap theme for the management panel and the front-end that customers interact with.

- [x] Requirement 2: In the management panel, there should be CRUD (Create, Read, Update, Delete) and search functionalities for products, customers, and orders.

- [x] Requirement 3: Orders should be listed and their details should be viewable.

- [x] Requirement 4: Customers should be listable, deletable, and addable.

- [x] Requirement 5: Customers should be able to register once via a membership screen and log in repeatedly to place orders. They should also be able to list their previous orders.

- [x] Requirement 6: When a customer enters the system for shopping, they should be able to add multiple products to the cart. On the payment screen, the total amount of products in the cart should be visible. Upon completing the payment, the orders should be added to the database. Session tracking should be used to transfer cart details to the payment screen.

- [x] Requirement 7: On the payment screen, various payment options should be shown to the user, and the selected payment method should be recorded in the orders table in the database.

## Technical Implementation

All database operations, bean definitions, and servlet processes on the backend have been implemented using Java. Tables have been created in the database using the MySQL connector, and bean structures have been prepared with services to facilitate easy access to the tables. On the frontend, JSP, CSS, and JavaScript have been used. The user interface utilizes Bootstrap and jQuery libraries.



<h4 align="center">OneToOneShop</h1>
<p align="center"><img src="src/main/webapp/assets/logo.png"  width=30% height=40%/></p>



## Project Overview (Summary):

The final project for the Web Programming course involves developing an e-commerce system. The backend is implemented using Java, with all database operations, bean definitions, and servlet processes handled accordingly. The MySQL connector is used to create tables in the database. Bean structures are designed with services to facilitate easy access to the tables. The frontend uses JSP, CSS, and JavaScript, and the user interface utilizes Bootstrap and jQuery libraries.

- **Backend Implementation:**
- 1. Database and Beans:

- - - Created using Java and MySQL.
- - - Beans for Cart, Customer, Order, Product, Seller, and User with getter and setter methods are defined in the beans directory.
- - - Encapsulation is applied by defining all parameters as private.
- 2.Services and Interfaces:
- - - Separate services are created for each entity (Cart, Customer, Order, Product, Seller, and User).
- - - Services are defined as interfaces, implemented in the operations subdirectory.
- - - These services include all CRUD operations, ensuring centralized management of database operations.
- 3. Servlets:
- - -Specific servlets handle different operations like adding/editing products, managing categories, initializing database tables, processing images, searching products, handling cart operations, and managing user sessions.
- - - These servlets use HTTP POST and GET methods for processing requests and are mapped to JSP files for accessibility.

- **Frontend Implementation:**
- 1. User Interface:
- - - Built using JSP, CSS, JavaScript, Bootstrap, and jQuery.
  
- **Database Schema::**
- 1. MySQL Schema:
- - - Includes tables for customers, orders, products, sellers, and users.
- - - Optimized with primary and foreign keys for efficient performance.

This structure ensures modularity, code reusability, and ease of maintenance, with encapsulation enhancing security and interface usage allowing flexibility in service implementation.


### Installation
```sh
$ TODO
```

## How can I support developers?
- Star our GitHub repo
- Create pull requests, submit bugs, suggest new features or documentation updates
- Follow our work