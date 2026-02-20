Untitled
================
20 February, 2026

This manuscript uses the Workflow for Open Reproducible Code in Science
(Van Lissa et al. 2021) to ensure reproducibility and transparency. All
code <!--and data--> are available at <demo_reproducibility>.

This is an example of a non-essential citation (@ Van Lissa et al.
2021). If you change the rendering function to `worcs::cite_essential`,
it will be removed.

``` r
knitr::kable(tab_fit, caption = "Model fit of latent class analyses.")
```

| Name | Classes | LL | n | Parameters | AIC | BIC | saBIC | Entropy | prob_min | prob_max | n_min | n_max | np_ratio | np_local |
|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| equal var 1 | 1 | -1641.077 | 513 | 8 | 3298.155 | 3332.077 | 3306.684 | 1.0000000 | 1.0000000 | 1.0000000 | 1.0000000 | 1.0000000 | 64.12500 | 64.125000 |
| equal var 2 | 2 | -1397.433 | 513 | 13 | 2820.865 | 2875.989 | 2834.725 | 0.8220482 | 0.9442713 | 0.9523238 | 0.4678363 | 0.5321637 | 39.46154 | 40.000000 |
| equal var 3 | 3 | -1331.992 | 513 | 18 | 2699.984 | 2776.309 | 2719.174 | 0.8045037 | 0.8494470 | 0.9469447 | 0.2748538 | 0.3918129 | 28.50000 | 26.437500 |
| equal var 4 | 4 | -1287.308 | 513 | 23 | 2620.616 | 2718.143 | 2645.137 | 0.7895169 | 0.8583324 | 0.8912787 | 0.1559454 | 0.3508772 | 22.30435 | 16.000000 |
| equal var 5 | 5 | -1234.275 | 513 | 28 | 2524.551 | 2643.278 | 2554.402 | 0.8521906 | 0.8278121 | 0.9476906 | 0.1267057 | 0.2709552 | 18.32143 | 13.541667 |
| equal var 6 | 6 | -1221.916 | 513 | 33 | 2509.832 | 2649.761 | 2545.014 | 0.8529282 | 0.5863217 | 0.9516243 | 0.0253411 | 0.2670565 | 15.54545 | 2.785714 |

Model fit of latent class analyses.

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-vanlissaWORCSWorkflowOpen2021" class="csl-entry">

Van Lissa, Caspar J., Andreas M. Brandmaier, Loek Brinkman, Anna-Lena
Lamprecht, Aaron Peikert, Marijn E. Struiksma, and Barbara M. I. Vreede.
2021. “WORCS: A Workflow for Open Reproducible Code in Science.” *Data
Science* 4 (1): 29–49. <https://doi.org/10.3233/DS-210031>.

</div>

</div>
