CREATE DATABASE IF NOT EXISTS mydatabase;
USE mydatabase;

CREATE TABLE IF NOT EXISTS Regions (
    RegionID INT AUTO_INCREMENT PRIMARY KEY,
    RegionName VARCHAR(255) NOT NULL
);

-- Create the People table
CREATE TABLE IF NOT EXISTS People (
    PersonID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

-- Create the Customers table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(255),
    Email VARCHAR(255),
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

-- Create the Suppliers table
CREATE TABLE IF NOT EXISTS Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(255),
    Email VARCHAR(255),
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

-- Create the Products table
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

-- Create the Stores table
CREATE TABLE IF NOT EXISTS Stores (
    StoreID INT AUTO_INCREMENT PRIMARY KEY,
    StoreName VARCHAR(255) NOT NULL,
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

-- Create the Orders table
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    StoreID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

-- Create the OrderDetails table
CREATE TABLE IF NOT EXISTS OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert meaningful data into Regions table
INSERT INTO Regions (RegionName) VALUES
    ('North America'),
    ('South America'),
    ('Europe'),
    ('Asia');

-- Insert meaningful data into People table
INSERT INTO People (FirstName, LastName, Email, RegionID) VALUES
    ('John', 'Smith', 'john.smith@example.com', 1),
    ('Jane', 'Doe', 'jane.doe@example.com', 2),
    ('Robert', 'Johnson', 'robert.johnson@example.com', 3),
    ('Emily', 'Brown', 'emily.brown@example.com', 4);

-- Insert meaningful data into Customers table
INSERT INTO Customers (CustomerName, ContactPerson, Email, RegionID) VALUES
    ('ABC Inc.', 'Alice Anderson', 'alice@abcinc.com', 1),
    ('XYZ Corporation', 'David Davis', 'david@xyzcorp.com', 2),
    ('Global Enterprises', 'Eva Evans', 'eva@globalent.com', 3);

-- Insert meaningful data into Suppliers table
INSERT INTO Suppliers (SupplierName, ContactPerson, Email, RegionID) VALUES
    ('SupplierCo Ltd.', 'Sam Smith', 'sam@supplierco.com', 1),
    ('Tech Parts Inc.', 'Tina Taylor', 'tina@techparts.com', 2),
    ('Quality Goods Ltd.', 'Quincy Quinn', 'quincy@qg.com', 3);

-- Insert meaningful data into Products table
INSERT INTO Products (ProductName, Price) VALUES
    ('Laptop', 899.99),
    ('Smartphone', 599.99),
    ('Tablet', 349.99),
    ('Desktop PC', 999.99);

-- Insert meaningful data into Stores table
INSERT INTO Stores (StoreName, RegionID) VALUES
    ('Tech Haven', 1),
    ('Gadget World', 2),
    ('ElectroMart', 3),
    ('Digital Nexus', 4);

-- Insert meaningful data into Orders table
INSERT INTO Orders (OrderDate, CustomerID, StoreID) VALUES
    ('2023-09-15', 1, 1),
    ('2023-09-16', 2, 2),
    ('2023-09-17', 3, 3);

-- Insert meaningful data into OrderDetails table
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
    (1, 1, 5),
    (1, 2, 10),
    (2, 3, 8),
    (3, 4, 12);

DELIMITER $$
CREATE PROCEDURE GetAllOrders()
BEGIN
    SELECT 
	o.OrderId,
	o.OrderDate,
	c.CustomerName, 
	c.ContactPerson,
	c.Email, 
	od.Quantity,
	p.ProductName,
	p.Price 
FROM orders o
	INNER JOIN customers c
    ON o.CustomerID = c.CustomerID
	INNER JOIN orderdetails od
		INNER JOIN products p
        ON od.ProductId = p.ProductId
    ON o.OrderId = od.OrderId;
END$$

DELIMITER ;