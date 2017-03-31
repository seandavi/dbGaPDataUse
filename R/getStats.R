#' @importFrom htmltab htmltab
#' @importFrom httr modify_url
#' @importFrom tibble as_tibble
#' @importFrom dplyr right_join select
#' @importFrom magrittr %>%
#'
#' @export
.getStats = function() {
    fix_names = function(n) gsub('\\s+','_',n)
    DAC = 'all'
    actType='appDAR'
    stdAcc='all_studies'
    stDate = '01/01/2004'
    endDate = strftime(Sys.Date(),format='%m/%d/%Y')
    url = httr::modify_url('https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/DataUseSummary.cgi?stDate=01%2F01%2F2004&endDate=12%2F31%2F2017&retTable=tabled1#')
    ovv = suppressMessages(htmltab(url, rm_nodata_cols = FALSE))
    colnames(ovv) = fix_names(colnames(ovv))
    url = httr::modify_url("https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/DataUseSummary.cgi?DAC=all&actType=appDAR&stdAcc=%20all_studies&stDate=01/01/2004&endDate=12/31/2017")
    res = suppressMessages(htmltab(url, rm_nodata_cols = FALSE))
    colnames(res) = fix_names(colnames(res))
    res$`Submitted_by_PI` = as.POSIXct(strptime(res$`Submitted_by_PI`,'%m/%d/%Y %H:%M'))
    res$`Approved_by_SO`  = as.POSIXct(strptime(res$`Approved_by_SO`,'%m/%d/%Y %H:%M'))
    res$`Approved_by_DAC`  = as.POSIXct(strptime(res$`Approved_by_DAC`,'%m/%d/%Y %H:%M'))
    res$`Rejected_by_DAC`  = as.POSIXct(strptime(res$`Rejected_by_DAC`,'%m/%d/%Y %H:%M'))
    res$`Revision_requested_by_DAC` = as.POSIXct(strptime(res$`Revision_requested_by_DAC`, '%m/%d/%Y %H:%M'))
    as_tibble(ovv %>%
              select(Study_Accession,Study_Name) %>%
              merge(res,by.x='Study_Accession',by.y='Study_accesion', all.x=TRUE))
}

#' dbGaP data use downloader
#'
#' This function simply queries the NCBI dbGaP data use
#' summary endpoint to generate a data.frame for local
#' use. The function uses queries to download the most
#' fine-grained data possible with the expectation that
#' the downloaded data will be processed in R for summaries,
#' etc.
#'
#' @importFrom memoise memoise
#'
#' @export
getStats = memoise::memoise(.getStats)
