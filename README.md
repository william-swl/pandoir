
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pandoir

<!-- badges: start -->
<!-- badges: end -->

## installation

``` r
devtools::install_github("william-swl/pandoir")
```

## doi

- get doi from url in parallel

``` r
future::plan(future::multisession)
url <- "https://www.nature.com/articles/s41586-022-05644-7"
url2doi(url)
#> [1] "10.1038/s41586-022-05644-7"
```
