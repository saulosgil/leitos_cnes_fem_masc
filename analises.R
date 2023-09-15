# pacotes -------------------------------------------------------------------------------------
library(geobr)
library(ggplot2)
library(dplyr)
library(patchwork)

# objeto com todos os estados -----------------------------------------------------------------
states <-
  geobr::read_state(
    year = 2020,
    showProgress = FALSE
)

# dataset CNES - leitos -----------------------------------------------------------------------
df <-
  readr::read_rds("tabela")

df_joined <-
  dplyr::inner_join(x = states,
                    y = df,
                    by = c("abbrev_state" = "uf"))

dplyr::glimpse(df_joined)

# grafico -------------------------------------------------------------------------------------
# mapa indi
g1 <-
  df_joined |>
  ggplot() +
  geom_sf(
    aes(fill = as.integer(total_leito_repouso_ind_urgencia)),
    color = NA,
    size = .15
  ) +
  labs(subtitle = "Leitos disponíveis para repouso em emergência indiferenciado (2022)",
       size = 8) +
  scale_fill_distiller(
    palette = "YlOrRd",
    name = "Nº leitos",
    limits = c(0,80000),
    direction = 2) +
  theme_minimal() +
  geom_sf_text(aes(label = abbrev_state),
               size = 2) +
  xlab("") +
  ylab("")

# coluna indiferenciado
g2 <-
  df_joined |>
  mutate(total_leito_repouso_ind_urgencia = as.integer(total_leito_repouso_ind_urgencia) /
           1000) |>
  mutate(name_state = forcats::fct_reorder(name_state, total_leito_repouso_ind_urgencia)) |>
  ggplot(
    aes(x = name_state,
        y = total_leito_repouso_ind_urgencia,
        fill = total_leito_repouso_ind_urgencia)
  ) +
  geom_bar(stat = "identity",
           colour = "black",
           show.legend = FALSE) +
  xlab("") +
  ylab("Nº de Leitos/1000 indivíduos") +
  scale_fill_distiller(palette = "YlOrRd",
                       limits = c(0, 100),
                       direction = 2) +
  theme_minimal() +
  scale_y_continuous(limits = c(0,80)) +
  coord_flip()

# mapa mulheres
g3 <-
  df_joined |>
  ggplot() +
  geom_sf(
    aes(fill = as.integer(total_leito_repouso_fem_urgencia)),
    color = NA,
    size = .15
  ) +
  labs(subtitle = "Leitos disponíveis para repouso em emergência exclusivo para mulheres (2022)",
       size = 8) +
  scale_fill_distiller(
    palette = "PuRd",
    name = "Nº leitos",
    limits = c(0,30000),
    direction = 1) +
  theme_minimal() +
  geom_sf_text(aes(label = abbrev_state),
               size = 2)  +
  xlab("") +
  ylab("")

# coluna mulheres
g4 <-
  df_joined |>
  mutate(total_leito_repouso_fem_urgencia = as.integer(total_leito_repouso_fem_urgencia) /
           1000) |>
  mutate(name_state = forcats::fct_reorder(name_state, total_leito_repouso_fem_urgencia)) |>
  ggplot(
    aes(x = name_state,
        y = total_leito_repouso_fem_urgencia,
        fill = total_leito_repouso_fem_urgencia)
  ) +
  geom_bar(stat = "identity",
           colour = "black",
           show.legend = FALSE) +
  xlab("") +
  ylab("Nº de Leitos/1000 indivíduos") +
  scale_fill_distiller(palette = "PuRd",
                       limits = c(0, 30),
                       direction = 2) +
  theme_minimal() +
  scale_y_continuous(limits = c(0,80)) +
  coord_flip()

# mapa homens
g5 <-
  df_joined |>
  ggplot() +
  geom_sf(
    aes(fill = as.integer(total_leito_repouso_masc_urgencia)),
    color = NA,
    size = .15
  ) +
  labs(subtitle = "Leitos disponíveis para repouso em emergência exclusivo para homens (2022)",
       size = 8) +
  scale_fill_distiller(
    palette = "Blues",
    name = "Nº leitos",
    limits = c(0,30000),
    direction = 2) +
  theme_minimal() +
  geom_sf_text(aes(label = abbrev_state),
               size = 2) +
  xlab("") +
  ylab("")

# coluna homens
g6 <-
  df_joined |>
  mutate(total_leito_repouso_masc_urgencia = as.integer(total_leito_repouso_masc_urgencia) /
           1000) |>
  mutate(name_state = forcats::fct_reorder(name_state, total_leito_repouso_masc_urgencia)) |>
  ggplot(
    aes(x = name_state,
        y = total_leito_repouso_masc_urgencia,
        fill = total_leito_repouso_masc_urgencia)
  ) +
  geom_bar(stat = "identity",
           colour = "black",
           show.legend = FALSE) +
  xlab("") +
  ylab("Nº de Leitos/1000 indivíduos") +
  scale_fill_distiller(palette = "Blues",
                       limits = c(0, 30),
                       direction = 2) +
  theme_minimal() +
  scale_y_continuous(limits = c(0,80)) +
  coord_flip()

(g1+g2)/(g3+g4)/(g5+g6)
