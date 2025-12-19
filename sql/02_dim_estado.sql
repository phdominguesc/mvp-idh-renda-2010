-- Criação da dimensão de estados (dim_estado_v3)

CREATE OR REPLACE TABLE schema_v3.dim_estado_v3 AS
WITH estados_distintos AS (
    SELECT DISTINCT Estados
    FROM schema_v3.idh_estados_clean_v3
)
SELECT
    ROW_NUMBER() OVER (ORDER BY Estados) AS id_estado,
    Estados
FROM estados_distintos;
