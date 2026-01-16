# Load packages
library(tidySEM)
library(foreign)
library(OpenMx)
library(psych)
library(lavaan)

# Load data
# f <- list.files(path = "../welzijnsmeter/", pattern = "sav$", full.names = TRUE)[4]
# df <- foreign::read.spss(f, to.data.frame = TRUE, use.value.labels = TRUE)
# names(df) <- gsub("(?<=\\w)(\\d{1,})", "_\\1", names(df), perl = TRUE)
df <- read.csv("data.csv", stringsAsFactors = FALSE)

# Scales
scales_list <- list(
  burden = grep("^belast_\\d+$", names(df), value = TRUE),
  entrapment = grep("^vrijheid_\\d+$", names(df), value = TRUE),
  worries = grep("^other_\\d+$", names(df), value = TRUE),
  loneliness = grep("^lon_\\d+$", names(df), value = TRUE)
)
df <- df[c(unlist(scales_list),
           grep("^motiv_\\d+$", names(df), value = TRUE),
           "freq",
           "sexc")]

scls <- lapply(names(scales_list), function(nam){
  tidy_sem(df[, scales_list[[nam]]]) |>
    measurement() |>
    run_lavaan() ->
    res_cfa
  out <- table_fit(res_cfa)[, c("Parameters", "chisq", "df", "cfi", "tli", "rmsea", "srmr")]
  out$rel_comp <- semTools::compRelSEM(res_cfa)
  out$rel_alpha <- psych::alpha(df[, scales_list[[nam]]], check.keys = TRUE)$total$raw_alpha
  tab_res <- table_results(res_cfa, columns = NULL, format_numeric = FALSE)
  lds <- abs(tab_res$est[tab_res$op == "=~"])
  out$l_min <- min(lds)
  out$l_max <- max(lds)
  cbind("Variable" = nam, out)
})

tab_scales <- do.call(rbind, scls)
write.csv(tab_scales, "tab_scales.csv", row.names = FALSE)

df[names(scales_list)] <- lapply(scales_list, function(n){
  rowMeans(df[, n], na.rm = TRUE)
})

df_lca <- df[, names(scales_list)]

if(!file.exists("res_lpa.RData")){
  set.seed(2)
  res_lpa <- mx_profiles(df_lca, classes = 1:6)
  saveRDS(res_lpa, "res_lpa.RData")
} else {
  res_lpa <- readRDS("res_lpa.RData")
}

tab_fit <- table_fit(res_lpa)
write.csv(tab_fit, "tab_fit.csv", row.names = FALSE)

motiv_items <- grep("^motiv_\\d+$", names(df), value = TRUE)
df_mixed <- df[, c(names(scales_list), motiv_items)]
df_mixed[motiv_items] <- lapply(df_mixed[motiv_items], ordered)

if(!file.exists("res_mixed.RData")){
  set.seed(2)
  res_mixed <- mx_mixed_lca(df_mixed, classes = 1:4)
  saveRDS(res_mixed, "res_mixed.RData")
} else {
  res_mixed <- readRDS("res_mixed.RData")
}

if(!file.exists("res_mixed_pmc.RData")){
  set.seed(2)
  res_mixed_pmc <- pmc_srmr(res_mixed, reps = 100)
  saveRDS(res_mixed_pmc, "res_mixed_pmc.RData")
} else {
  res_mixed_pmc <- readRDS("res_mixed_pmc.RData")
}

table_fit(res_mixed)
plot_profiles(res_mixed[[2]], variables = names(scales_list))

table_prob(res_mixed[[2]])
plot_prob(res_mixed[[2]])

res_freq <- BCH(res_mixed[[2]], data = df$freq)
lr_test(res_freq, compare = "M")

res_sex <- BCH(res_mixed[[2]], data = ordered(df$sexc))
lr_test(res_sex)

# Generate fake data
df <- df[, c("burden", "entrapment", "worries", "loneliness", "belast_1",
             "belast_2", "belast_3", "belast_4", "belast_5",
             "belast_6", "belast_7", "belast_8", "belast_9", "belast_10",
             "belast_11", "belast_12", "belast_13", "belast_14", "belast_15",
             "vrijheid_1", "vrijheid_2", "vrijheid_3", "other_1", "other_2",
             "other_3", "other_4", "other_5", "other_6", "other_7", "other_8",
             "other_9", "lon_1", "lon_2", "lon_3", "lon_4", "lon_5", "lon_6",
             "lon_7", "lon_8", "lon_9", "lon_10", "lon_11", "motiv_1", "motiv_2",
             "motiv_3", "motiv_4", "motiv_5", "motiv_6", "motiv_7", "freq",
             "sexc")]
library(synthpop)

df_synthetic <- syn(df, method = c(rep("", 4), rep("ranger", ncol(df)-4L)))
write.csv(df_synthetic$syn[, -c(1:4)], "data.csv", row.names = FALSE)
