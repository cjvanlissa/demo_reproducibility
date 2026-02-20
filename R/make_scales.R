make_scales <- function(df, scales_list){
  suppressWarnings({
    scls <- lapply(names(scales_list), function(nam){
      tidySEM::tidy_sem(df[, scales_list[[nam]]]) |>
        tidySEM::measurement() |>
        tidySEM::run_lavaan() ->
        res_cfa
      out <- tidySEM::table_fit(res_cfa)[, c("Parameters", "chisq", "df", "cfi", "tli", "rmsea", "srmr")]
      out$rel_comp <- semTools::compRelSEM(res_cfa)
      out$rel_alpha <- psych::alpha(df[, scales_list[[nam]]], check.keys = TRUE)$total$raw_alpha
      tab_res <- tidySEM::table_results(res_cfa, columns = NULL, format_numeric = FALSE)
      lds <- abs(tab_res$est[tab_res$op == "=~"])
      out$l_min <- min(lds)
      out$l_max <- max(lds)
      cbind("Variable" = nam, out)
    })

  })

tab_scales <- do.call(rbind, scls)
write.csv(as.matrix(tab_scales), "tab_scales.csv", row.names = FALSE)

df[names(scales_list)] <- lapply(scales_list, function(n){
  rowMeans(df[, n], na.rm = TRUE)
})

df_lca <- df[, names(scales_list)]
return(df_lca)
}
