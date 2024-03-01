CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255)
AS
BEGIN
    -- Проверка наличия переданной фамилии в таблице dbo.Family
    IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        RAISERROR ('Family does not exist.', 16, 1);
        RETURN;
    END;

    -- Обновление данных в таблице dbo.Family
    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - (
        SELECT ISNULL(SUM(Value), 0) 
        FROM dbo.Basket 
        WHERE ID_Family = (SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName))
    WHERE SurName = @FamilySurName;
END;