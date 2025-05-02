-- 既にテーブルが存在する場合は削除
IF OBJECT_ID('dbo.TestData', 'U') IS NOT NULL
    DROP TABLE dbo.TestData;
    
CREATE TABLE TestData (
    Id INT IDENTITY(1,1),
    Name NVARCHAR(100),
    Value INT
);

DECLARE @Counter INT = 0;
WHILE @Counter < 1000000  -- 100万行挿入（必要に応じて変更）
BEGIN
    INSERT INTO TestData (Name, Value)
    VALUES (NEWID(), FLOOR(RAND() * 1000));
    SET @Counter = @Counter + 1;
END

-- 注意：環境によってはフリーズするので行数を制限してください
SELECT DISTINCT a.Name, b.Name
qFROM TestData a
CROSS JOIN TestData b;