#' get doi from url
#'
#' @param url url
#'
#' @return doi
#' @export
#'
#' @examples
#' url <- "https://www.nature.com/articles/s41586-022-05644-7"
#' url2doi_(url)
#'
url2doi_ <- function(url) {
  try({
    web <- xml2::read_html(url, encoding = "UTF-8")
    domain <- urltools::domain(url)
    doi <- web %>%
      html_element(doi_selector[domain, "selector"]) %>%
      html_attr(doi_selector[domain, "attr"])
    doi <- str_replace(doi, "^doi:", "")

    return(doi)
  })
}


#' get doi from url in parallel
#'
#' @param urls urls
#' @param retry the time of retries
#'
#' @return dois
#' @export
#'
#' @examples
#' future::plan(future::multisession)
#' url <- "https://www.nature.com/articles/s41586-022-05644-7"
#' url2doi(url)
#'
url2doi <- function(urls, retry = 5) {
  res <- urls %>% future_map_chr(url2doi_,
    .options = furrr_options(seed = 123)
  )

  for (i in seq_len(retry)) {
    error_mask <- str_detect(res, "^Error") | is.na(res)
    if (sum(error_mask) > 0) {
      res[error_mask] <- urls[error_mask] %>%
        future_map_chr(url2doi_, .options = furrr_options(seed = 123))
    }
  }

  return(res)
}
