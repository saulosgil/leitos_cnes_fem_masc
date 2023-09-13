# pacote --------------------------------------------------------------------------------------
library(basedosdados)
library(dplyr)

# Acessando projeto na BD ---------------------------------------------------------------------
basedosdados::set_billing_id("analise-dados-curso-bda")

# pegando a query -----------------------------------------------------------------------------
query <-
  "
SELECT
  ano,
  sigla_uf AS uf,
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
  `basedosdados.br_ms_cnes.estabelecimento`
WHERE
  ano = 2022
GROUP BY
  ano,
  uf
"

# lendo a query -------------------------------------------------------------------------------
df <-
  basedosdados::read_sql(query)

# verificando a query -------------------------------------------------------------------------
dplyr::glimpse(df)

# salvando o df -------------------------------------------------------------------------------
readr::write_rds(x = df, file = "tabela")

