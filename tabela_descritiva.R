# pacotes -------------------------------------------------------------------------------------
library(geobr)
library(ggplot2)
library(dplyr)
library(patchwork)

# objeto com todos os estados -----------------------------------------------------------------
states <-
  geobr::read_state(year = 2020,
                    showProgress = FALSE)

# dataset CNES - leitos -----------------------------------------------------------------------
df <-
  readr::read_rds("tabela")

df_joined <-
  dplyr::inner_join(x = states,
                    y = df,
                    by = c("abbrev_state" = "sigla_uf"))

dplyr::glimpse(df_joined)

# Estatistica descritiva ----------------------------------------------------------------------
tabela <-
  df_joined |>
  select(-code_state,
         -name_state,
         -code_region,
         -name_region,
         -geom,
         -total_sala_repouso_ind_ambulatorio,
         -total_sala_repouso_fem_ambulatorio,
         -total_sala_repouso_masc_ambulatorio,
         -ano) |>
  mutate(
    total_leito_repouso_fem_urgencia  = (total_leito_repouso_fem_urgencia / populacao) * 100000,
    total_leito_repouso_ind_urgencia  = (total_leito_repouso_ind_urgencia / populacao) * 100000,
    total_leito_repouso_masc_urgencia = (total_leito_repouso_masc_urgencia / populacao) * 100000,
    total_consultorio_fem_urgencia    = (total_consultorio_fem_urgencia / populacao) * 100000,
    total_consultorio_masc_urgencia   = (total_consultorio_masc_urgencia / populacao) * 100000,
    total_consultorio_ind_urgencia    = (total_consultorio_ind_urgencia / populacao) * 100000,
    total_sala_repouso_fem_urgencia   = (total_sala_repouso_fem_urgencia / populacao) * 100000,
    total_sala_repouso_masc_urgencia  = (total_sala_repouso_masc_urgencia / populacao) * 100000,
    total_sala_repouso_ind_urgencia   = (total_sala_repouso_ind_urgencia / populacao) * 100000
  ) |>
  mutate(
    total_leito_repouso_fem_urgencia  = as.integer(total_leito_repouso_fem_urgencia),
    total_leito_repouso_ind_urgencia  = as.integer(total_leito_repouso_ind_urgencia),
    total_leito_repouso_masc_urgencia = as.integer(total_leito_repouso_masc_urgencia),
    total_consultorio_fem_urgencia    = as.integer(total_consultorio_fem_urgencia),
    total_consultorio_masc_urgencia   = as.integer(total_consultorio_masc_urgencia),
    total_consultorio_ind_urgencia    = as.integer(total_consultorio_ind_urgencia),
    total_sala_repouso_fem_urgencia   = as.integer(total_sala_repouso_fem_urgencia),
    total_sala_repouso_masc_urgencia  = as.integer(total_sala_repouso_masc_urgencia),
    total_sala_repouso_ind_urgencia   = as.integer(total_sala_repouso_ind_urgencia)
  )





