-- Bài tập: Cơ sở dữ liệu quản lý bán hàng
CREATE DATABASE QuanLyBanHang;
USE QuanLyBanHang;

CREATE TABLE Customer (
    cId INT AUTO_INCREMENT PRIMARY KEY,
    cName VARCHAR(100) NOT NULL,
    cAge TINYINT UNSIGNED
);

-- ORDER là từ khóa của MySQL, vì vậy tên bảng được đặt trong dấu backtick.
CREATE TABLE `Order` (
    oId INT AUTO_INCREMENT PRIMARY KEY,
    cId INT NOT NULL,
    oDate DATETIME NOT NULL,
    oTotalPrice DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT FK_Order_Customer
        FOREIGN KEY (cId) REFERENCES Customer(cId)
);

CREATE TABLE Product (
    pId INT AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(100) NOT NULL,
    pPrice DECIMAL(12, 2) NOT NULL CHECK (pPrice >= 0)
);

-- Bảng trung gian: một hóa đơn có nhiều sản phẩm và một sản phẩm thuộc nhiều hóa đơn.
CREATE TABLE OrderDetail (
    oId INT NOT NULL,
    pId INT NOT NULL,
    odQTY INT NOT NULL CHECK (odQTY > 0),
    PRIMARY KEY (oId, pId),
    CONSTRAINT FK_OrderDetail_Order
        FOREIGN KEY (oId) REFERENCES `Order`(oId),
    CONSTRAINT FK_OrderDetail_Product
        FOREIGN KEY (pId) REFERENCES Product(pId)
);
