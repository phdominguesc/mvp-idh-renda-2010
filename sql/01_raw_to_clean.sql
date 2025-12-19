-- Criação das tabelas tratadas (clean) a partir das tabelas raw

CREATE OR REPLACE TABLE schema_v3.idh_estados_clean_v3 AS
SELECT
    TRIM(Estados) AS Estados,
    CAST(idhm_2010 AS DOUBLE) AS idhm_2010,
    CAST(idhm_renda_2010 AS DOUBLE) AS idhm_renda_2010,
    CAST(idhm_longevidade_2010 AS DOUBLE) AS idhm_longevidade_2010,
    CAST(idhm_educacao_2010 AS DOUBLE) AS idhm_educacao_2010
FROM schema_v3.idh_estados_atlas_v3;

CREATE OR REPLACE TABLE schema_v3.renda_estados_clean_v3 AS
SELECT
    TRIM(Estados) AS Estados,
    CAST(renda_media_2010 AS DOUBLE) AS renda_media_2010
FROM schema_v3.renda_estados_2010_csv;
