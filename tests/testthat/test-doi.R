test_that("url2doi_", {
  url <- "https://www.nature.com/articles/s41586-022-05644-7"
  expect_identical(url2doi_(url), "10.1038/s41586-022-05644-7")
})

test_that("url2doi", {
  future::plan(future::multisession)
  urls <- c(
    "https://www.nature.com/articles/s41586-022-05644-7",
    "https://www.sciencedirect.com/science/article/pii/S2352304222001623",
    "https://science.sciencemag.org/content/early/2020/06/15/science.abd0827"
  )
  expect_identical(
    url2doi(urls),
    c(
      "10.1038/s41586-022-05644-7",
      "10.1016/j.gendis.2022.05.027",
      "10.1126/science.abd0827"
    )
  )
})
