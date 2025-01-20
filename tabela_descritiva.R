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
  readr::read_csv("tabela")

df_joined <-
  dplyr::inner_join(x = states,
                    y = df,
                    by = c("abbrev_state" = "sigla_uf"))

dplyr::glimpse(df_joined)

# Estatistica descritiva ----------------------------------------------------------------------
tabela <-
  df_joined |>
  select(-name_state,
         -code_state,
         -code_region,
         # -name_region,
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

# salas/consultórios em unidades de emergência/urgência
sum(tabela$total_consultorio_fem_urgencia)
sum(tabela$total_consultorio_masc_urgencia)

# salas de repouso em unidades de emergência/urgência
sum(tabela$total_sala_repouso_fem_urgencia)
sum(tabela$total_sala_repouso_masc_urgencia)

# leitos de repouso/observação em unidades de emergência/urgência
sum(tabela$total_leito_repouso_fem_urgencia)
sum(tabela$total_leito_repouso_masc_urgencia)

# Resumo de cada região -----------------------------------------------------------------------
by_tabela <-
  tabela |>
  group_by(name_region)


# total_leito_repouso_fem/masc/ind_urgencia
## feminino
by_tabela |>
  summarise(
    sum = sum(total_leito_repouso_fem_urgencia),
    minimo = min(total_leito_repouso_fem_urgencia),
    maximo = max(total_leito_repouso_fem_urgencia)
    )

## masculino
by_tabela |>
  summarise(
    sum = sum(total_leito_repouso_masc_urgencia),
    minimo = min(total_leito_repouso_masc_urgencia),
    maximo = max(total_leito_repouso_masc_urgencia)
    )

## indiferenciado
by_tabela |>
  summarise(
    sum = sum(total_leito_repouso_ind_urgencia),
    minimo = min(total_leito_repouso_ind_urgencia),
    maximo = max(total_leito_repouso_ind_urgencia)
    )

# total_consultorio_fem/masc/ind_urgencia
## feminino
by_tabela |>
  summarise(
    sum = sum(total_consultorio_fem_urgencia),
    minimo = min(total_consultorio_fem_urgencia),
    maximo = max(total_consultorio_fem_urgencia)
  )

## masculino
by_tabela |>
  summarise(
    sum = sum(total_consultorio_masc_urgencia),
    minimo = min(total_consultorio_masc_urgencia),
    maximo = max(total_consultorio_masc_urgencia)
  )

## indiferenciado
by_tabela |>
  summarise(
    sum = sum(total_consultorio_ind_urgencia),
    minimo = min(total_consultorio_ind_urgencia),
    maximo = max(total_consultorio_ind_urgencia)
  )

# total_sala_repouso_fem/masc/ind_urgencia
## feminino
by_tabela |>
  summarise(
    sum = sum(total_sala_repouso_fem_urgencia),
    minimo = min(total_sala_repouso_fem_urgencia),
    maximo = max(total_sala_repouso_fem_urgencia)
  )

## masculino
by_tabela |>
  summarise(
    sum = sum(total_sala_repouso_masc_urgencia),
    minimo = min(total_sala_repouso_masc_urgencia),
    maximo = max(total_sala_repouso_masc_urgencia)
  )

## indiferenciado
by_tabela |>
  summarise(
    sum = sum(total_sala_repouso_ind_urgencia),
    minimo = min(total_sala_repouso_ind_urgencia),
    maximo = max(total_sala_repouso_ind_urgencia)
  )
