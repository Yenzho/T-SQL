# T-SQL Project

## Description
This is a small training task that I completed using T-SQL.

## GitHub Repository Setup
- Create a repository on GitHub.
- Each subsequent paragraph must be published in the "lesson 0" thread.
- Create a Pull Request for the branch "lesson 0" in "master".

## Tables
### Create tables (output: file in the CreateStructure.sql repository in the Tables branch)
- dbo.SKU (ID identity, Code, Name)
    - Restriction on the uniqueness of the Code field.
    - Calculated Code field: "s" + ID.
- dbo.Family (ID identity, SurName, BudgetValue)
- dbo.Basket (ID identity, ID_SKU (foreign key to table dbo.SKU), ID_Family (Foreign key to table dbo.Family), Quantity, Value, PurchaseDate, DiscountValue)
    - Restriction that the Quantity and Value fields cannot be less than 0.
    - Add a default value for the PurchaseDate field: the date the record was added (current date).

## Functions
### Create a function (output: file in the repository dbo.udf_GetSKUPrice.sql in the Functions branch)
- Input parameter @ID_SKU.
- Calculates the cost of the transferred product from the dbo.Basket table using the formula:
    - Value amount for the transferred SKU / Quantity amount for the transferred SKU.
- The output is a value of type decimal(18, 2).

## Views
### Create a view (output: file in the repository dbo.vw_SKUPrice in the VIEWs branch)
- Returns all product attributes from the dbo.SKU table and the calculated attribute with the cost of one product (using the dbo.udf_GetSKUPrice function).

## Procedures
### Create a procedure (output: file in the repository dbo.usp_MakeFamilyPurchase in the Procedures branch)
- Input parameter (@FamilySurName varchar(255)) one of the values of the SurName attribute of the dbo.Family table.
- The procedure, when called, updates data in the dbo.Family table in the BudgetValue field according to logic:
    - dbo.Family.BudgetValue - sum(dbo.Basket.Value), where dbo.Basket.Value of purchases for the family passed to the procedure.
    - When passing a non-existent dbo.Family.SurName, the user receives an error that there is no such family.

## Triggers
### Create a trigger (output: file in the repository dbo.TR_Basket_insert_update in the Triggers branch)
- If 2 or more records of the same ID_SKU are added to the dbo.Basket table at a time, then the value in the DiscountValue field, for this ID_SKU is calculated using the formula: Value * 5%, otherwise DiscountValue = 0.
