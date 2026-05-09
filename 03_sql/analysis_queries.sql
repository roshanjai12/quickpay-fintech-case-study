-- Q1
query_q1 = """

SELECT
    status_clean,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY status_clean

"""

result_q1 = pd.read_sql(query_q1, conn)

result_q1
------------------------------------------------------------------------
-- Q2
query_q2 = """

SELECT
    merchant_name_clean,
    SUM(amount_usd) AS total_captured_gmv
FROM transactions
WHERE status_clean = 'CAPTURED'
GROUP BY merchant_name_clean
ORDER BY total_captured_gmv DESC

"""

result_q2 = pd.read_sql(query_q2, conn)

result_q2
--------------------------------------------------------------------

-- Q3
query_q3 = """

SELECT
    merchant_name_clean,
    SUM(amount_usd) AS total_captured_gmv
FROM transactions
WHERE status_clean = 'CAPTURED'
GROUP BY merchant_name_clean
ORDER BY total_captured_gmv DESC
LIMIT 10

"""

result_q3 = pd.read_sql(query_q3, conn)

result_q3
--------------------------------------------------------------------------
-- Q4
query_q4 = """

SELECT
    transaction_date_clean,
    SUM(amount_usd) AS daily_gmv,
    COUNT(*) AS successful_transaction_count
FROM transactions
WHERE status_clean = 'CAPTURED'
GROUP BY transaction_date_clean
ORDER BY transaction_date_clean

"""

result_q4 = pd.read_sql(query_q4, conn)

result_q4
----------------------------------------------------------------------
-- Q5 
query_q5 = """

SELECT
    merchant_name_clean,
    
    COUNT(*) AS total_transactions,

    SUM(
        CASE
            WHEN status_clean = 'CHARGEBACK'
            THEN 1
            ELSE 0
        END
    ) AS chargeback_count,

    ROUND(
        (
            SUM(
                CASE
                    WHEN status_clean = 'CHARGEBACK'
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
        2
    ) AS chargeback_ratio

FROM transactions

GROUP BY merchant_name_clean

HAVING chargeback_ratio > 1

ORDER BY chargeback_ratio DESC

"""

result_q5 = pd.read_sql(query_q5, conn)

result_q5
--------------------------------------------
--Q6
query_q6 = """

SELECT
    gateway_region_clean,
    
    COUNT(*) AS total_transactions,

    ROUND(
        AVG(risk_score_clean),
        2
    ) AS average_risk_score

FROM transactions

GROUP BY gateway_region_clean

HAVING
    average_risk_score > 50
    AND total_transactions > 20

ORDER BY average_risk_score DESC

"""

result_q6 = pd.read_sql(query_q6, conn)

result_q6
------------------------------------------------
--Q7
query_q7 = """

SELECT
    user_id,
    transaction_date_clean,

    COUNT(*) AS suspicious_transaction_count

FROM transactions

WHERE
    status_clean IN ('FAILED', 'CHARGEBACK')

GROUP BY
    user_id,
    transaction_date_clean

HAVING
    suspicious_transaction_count >= 3

ORDER BY
    suspicious_transaction_count DESC

"""

result_q7 = pd.read_sql(query_q7, conn)

result_q7
----------------------------------------------------
--Q8
query_q8 = """

SELECT
    merchant_name_clean,

    COUNT(*) AS chargeback_count,

    COUNT(DISTINCT user_id) AS unique_affected_users,

    ROUND(
        SUM(amount_usd),
        2
    ) AS total_chargeback_amount

FROM transactions

WHERE
    status_clean = 'CHARGEBACK'

GROUP BY
    merchant_name_clean

ORDER BY
    total_chargeback_amount DESC

"""

result_q8 = pd.read_sql(query_q8, conn)

result_q8
--------------------------------------------------------