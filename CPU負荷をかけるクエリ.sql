DECLARE @i INT = 0;
DECLARE @max INT = 100;  -- 繰り返し回数

-- 繰り返し処理
WHILE @i < @max
BEGIN
    -- 任意の処理
    WITH cte AS (
        SELECT TOP 1000000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    )
    SELECT SUM(CAST(CHECKSUM(NEWID()) AS BIGINT))
    FROM cte
    OPTION (MAXDOP 8);

    -- ループカウンタを増やす
    SET @i = @i + 1;
END
