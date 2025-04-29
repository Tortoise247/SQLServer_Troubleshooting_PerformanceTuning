WITH cte1 AS (
    SELECT TOP (50000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
),
cte2 AS (
    SELECT 
        a.n AS n1,
        b.n AS n2
    FROM 
        cte1 a
    CROSS JOIN 
        cte1 b
)
SELECT 
    SUM(CHECKSUM(NEWID()) + CHECKSUM(NEWID()) * n1 - CHECKSUM(NEWID()) * n2)
FROM 
    cte2
OPTION (MAXDOP 8, RECOMPILE);


-- cte1で5万行作って、それを5万行とCROSS JOIN → 25億件
-- CHECKSUM(NEWID())を大量に生成・計算する
-- MAXDOP 8で最大8コア並列処理する
-- OPTION (RECOMPILE)でプランキャッシュを無効化して、毎回コンパイルさせる
-- （＝SQL Serverにさらに負荷がかかる）