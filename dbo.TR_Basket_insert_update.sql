CREATE TRIGGER TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    IF (SELECT COUNT(*) FROM inserted GROUP BY ID_SKU HAVING COUNT(*) >= 2) > 0
    BEGIN
        UPDATE b
        SET DiscountValue = i.Value * 0.05
        FROM dbo.Basket b
        INNER JOIN inserted i ON b.ID = i.ID
        INNER JOIN (SELECT ID_SKU FROM inserted GROUP BY ID_SKU HAVING COUNT(*) >= 2) c ON b.ID_SKU = c.ID_SKU;
    END
    ELSE
    BEGIN
        UPDATE b
        SET DiscountValue = 0
        FROM dbo.Basket b
        INNER JOIN inserted i ON b.ID = i.ID;
    END
END;