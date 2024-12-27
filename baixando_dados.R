# pacote --------------------------------------------------------------------------------------
library(basedosdados)
library(dplyr)

# Acessando projeto na BD ---------------------------------------------------------------------
basedosdados::set_billing_id("analise-dados-curso-bda")

# pegando a query -----------------------------------------------------------------------------
query <-
"
SELECT
  a.ano,
  a.sigla_uf,
  b.populacao,
  SUM(quantidade_leito_repouso_feminino_urgencia) AS total_leito_repouso_fem_urgencia,
  SUM(quantidade_leito_repouso_masculino_urgencia) AS total_leito_repouso_masc_urgencia,
  SUM(quantidade_leito_repouso_indiferenciado_urgencia) AS total_leito_repouso_ind_urgencia,
  SUM(quantidade_consultorio_feminino_urgencia) AS total_consultorio_fem_urgencia,
  SUM(quantidade_consultorio_masculino_urgencia) AS total_consultorio_masc_urgencia,
  SUM(quantidade_consultorio_indiferenciado_urgencia) AS total_consultorio_ind_urgencia,
  SUM(quantidade_sala_repouso_feminino_urgencia) AS total_sala_repouso_fem_urgencia,
  SUM(quantidade_sala_repouso_masculino_urgencia) AS total_sala_repouso_masc_urgencia,
  SUM(quantidade_sala_repouso_indiferenciado_urgencia) AS total_sala_repouso_ind_urgencia,
  SUM(quantidade_sala_repouso_feminino_ambulatorial) AS total_sala_repouso_fem_ambulatorio,
  SUM(quantidade_sala_repouso_masculino_ambulatorial) AS total_sala_repouso_masc_ambulatorio,
  SUM(quantidade_sala_repouso_indiferenciado_ambulatorial) AS total_sala_repouso_ind_ambulatorio
FROM
  basedosdados.br_ms_cnes.estabelecimento a
INNER JOIN
    basedosdados.br_ibge_populacao.uf b
  ON
    a.sigla_uf = b.sigla_uf
WHERE
  a.ano = 2021 AND b.ano = 2021
GROUP BY
  ano,
  a.sigla_uf,
  b.populacao
"

# lendo a query -------------------------------------------------------------------------------
df <-
  basedosdados::read_sql(query)

# verificando a query -------------------------------------------------------------------------
dplyr::glimpse(df)

# salvando o df -------------------------------------------------------------------------------
readr::write_csv(x = df, file = "tabela")

