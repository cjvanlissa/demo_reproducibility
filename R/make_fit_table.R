make_fit_table <- function(res_lpa){
tab_fit <- tidySEM::table_fit(res_lpa)
write.csv(tab_fit, "tab_fit.csv", row.names = FALSE)
return(tab_fit)
}
