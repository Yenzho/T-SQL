CREATE FUNCTION dbo.udf_GetSKUPrice
(
    @ID_SKU INT
)
RETURNS DECIMAL(18, 2) 
AS
BEGIN
    DECLARE @Price DECIMAL(18, 2);

    SELECT @Price = SUM(Value) / NULLIF(SUM(Quantity), 0)
    -- Используем NULLIF для избежания деления на ноль
    FROM dbo.Basket
    WHERE ID_SKU = @ID_SKU;

    RETURN @Price;
END;