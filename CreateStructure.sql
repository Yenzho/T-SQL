CREATE TABLE dbo.SKU
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Code AS ('s' + CAST(ID AS VARCHAR(255))),
    Name VARCHAR(255),
    CONSTRAINT Unique_Code UNIQUE (Code)
);

CREATE TABLE dbo.Family
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    SurName VARCHAR(255),
    BudgetValue DECIMAL(18,2)
);

CREATE TABLE dbo.Basket
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ID_SKU INT,
    ID_Family INT,
    Quantity INT,
    Value INT,
    PurchaseDate DATE DEFAULT GETDATE(),
    DiscountValue INT,
    CONSTRAINT FK_Basket_SKU FOREIGN KEY (ID_SKU) REFERENCES dbo.SKU(ID),
    CONSTRAINT FK_Basket_Family FOREIGN KEY (ID_Family) REFERENCES dbo.Family(ID),
    CONSTRAINT Check_Quantity_Value CHECK (Quantity >= 0 AND Value >= 0)
);