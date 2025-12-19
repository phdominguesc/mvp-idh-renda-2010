-- 5.1 Qualidade dos dados

-- Nulos
SELECT
  SUM(CASE WHEN id_estado IS NULL THEN 1 END) AS nulos_id_estado,
  SUM(CASE WHEN idhm_2010 IS NULL THEN 1 END) AS nulos_idhm,
  SUM(CASE WHEN idhm_renda_2010 IS NULL THEN 1 END) AS nulos_idhm_renda,
  SUM(CASE WHEN idhm_longevidade_2010 IS NULL THEN 1 END) AS nulos_idhm_longevidade,
  SUM(CASE WHEN idhm_educacao_2010 IS NULL THEN 1 END) AS nulos_idhm_educacao,
  SUM(CASE WHEN renda_media_2010 IS NULL THEN 1 END) AS nulos_renda
FROM schema_v3.fato_idh_renda_v3;

-- Duplicidade
SELECT id_estado, COUNT(*) AS registros
FROM schema_v3.fato_idh_renda_v3
GROUP BY id_estado
HAVING COUNT(*) > 1;

-- Intervalos
SELECT
  MIN(idhm_2010) AS min_idh,
  MAX(idhm_2010) AS max_idh,
  MIN(renda_media_2010) AS min_renda,
  MAX(renda_media_2010) AS max_renda
FROM schema_v3.fato_idh_renda_v3;


-- 5.2 Análises

-- Correlação renda x IDH
SELECT CORR(renda_media_2010, idhm_2010) AS correlacao_idh_renda
FROM schema_v3.fato_idh_renda_v3;

-- Ranking por renda
SELECT
  e.Estados,
  f.renda_media_2010,
  f.idhm_2010
FROM schema_v3.fato_idh_renda_v3 f
JOIN schema_v3.dim_estado_v3 e
  ON f.id_estado = e.id_estado
ORDER BY f.renda_media_2010 DESC;

-- Ranking por IDH
SELECT
  e.Estados,
  f.idhm_2010,
  f.renda_media_2010
FROM schema_v3.fato_idh_renda_v3 f
JOIN schema_v3.dim_estado_v3 e
  ON f.id_estado = e.id_estado
ORDER BY f.idhm_2010 DESC;

-- Correlação por componente
SELECT
    CORR(renda_media_2010, idhm_renda_2010) AS corr_idh_renda,
    CORR(renda_media_2010, idhm_educacao_2010) AS corr_idh_educacao,
    CORR(renda_media_2010, idhm_longevidade_2010) AS corr_idh_longevidade
FROM schema_v3.fato_idh_renda_v3;

-- Baixa renda x componentes
SELECT
  e.Estados,
  f.renda_media_2010,
  f.idhm_educacao_2010,
  f.idhm_longevidade_2010
FROM schema_v3.fato_idh_renda_v3 f
JOIN schema_v3.dim_estado_v3 e
  ON f.id_estado = e.id_estado
ORDER BY f.renda_media_2010 ASC;

-- Estados destoantes
SELECT
  e.Estados,
  f.renda_media_2010,
  f.idhm_2010,
  ABS(f.idhm_renda_2010 - f.idhm_educacao_2010) AS dif_renda_educacao,
  ABS(f.idhm_renda_2010 - f.idhm_longevidade_2010) AS dif_renda_longevidade
FROM schema_v3.fato_idh_renda_v3 f
JOIN schema_v3.dim_estado_v3 e
  ON f.id_estado = e.id_estado
ORDER BY dif_renda_educacao DESC;
