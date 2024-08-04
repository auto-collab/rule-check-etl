-- Query to check landing to staging row count
SELECT 'Check landing to staging row count' AS RuleUnderTest,
       'landing to staging' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM landing) = (SELECT COUNT(*) FROM staging) THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Query to check email validity in staging
SELECT 'Check email validity in staging' AS RuleUnderTest,
       'staging' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM staging WHERE email NOT LIKE '%@%') = 0 THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Query to check is_valid flag in staging
SELECT 'Check is_valid flag in staging' AS RuleUnderTest,
       'staging' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM staging WHERE is_valid = 0) = 0 THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Query to check staging to production row count
SELECT 'Check staging to production row count' AS RuleUnderTest,
       'staging to production' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM staging) = (SELECT COUNT(*) FROM prod) THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Query to check created_at timestamp consistency
SELECT 'Check created_at timestamp consistency' AS RuleUnderTest,
       'staging to production' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM staging s JOIN prod p ON s.id = p.id WHERE s.created_at != p.created_at) = 0 THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Query to check updated_at timestamp in production
SELECT 'Check updated_at timestamp in production' AS RuleUnderTest,
       'production' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM prod WHERE updated_at > DATEADD(minute, -1, CURRENT_TIMESTAMP)) = (SELECT COUNT(*) FROM prod) THEN 'PASS' ELSE 'FAIL' END AS TestResult;
