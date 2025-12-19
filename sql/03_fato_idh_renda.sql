-- Criação da tabela fato com indicadores de IDH e renda

CREATE OR REPLACE TABLE schema_v3.fato_idh_renda_v3 AS
SELECT
    d.id_estado,
    i.idhm_2010,
    i.idhm_renda_2010,
    i.idhm_longevidade_2010,
    i.idhm_educacao_2010,
    r.renda_media_2010
FROM schema_v3.idh_estados_clean_v3 AS i
JOIN schema_v3.renda_estados_clean_v3 AS r
    ON i.Estados = r.Estados
JOIN schema_v3.dim_estado_v3 AS d
    ON i.Estados = d.Estados;
