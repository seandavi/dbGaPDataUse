# dbGaP Data Use Stats

## Installation

```{r}
library(devtools)
install.packages(c('memoise','dplyr','magrittr','httr','tibble','htmltab'))
devtools::install_github('seandavi/dbGaPDataUse')
```

## Usage

The following will download all data use stats available from the [dbGaP Data Use Summary webpage](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/DataUseSummary.cgi). The website is a bit slow, so be patient, but the result is a data.frame of all released dbGaP studies and their data access request and download statistics.

```{r}
library(dbGaPDataUse)
gapstats = getStats()
head(gapstats)
```

```
# A tibble: 6 × 14
  Study_Accession                                Study_Name Study_Release_Date Embargo_End_Date   DAC    PI Project      DAR
            <chr>                                     <chr>              <chr>            <chr> <chr> <chr>   <chr>    <chr>
1 phs000001.v3.p1 NEI Age-Related Eye Disease Study (AREDS)         04/05/2012       02/11/2016   NEI   108     328   622.v1
2 phs000001.v3.p1 NEI Age-Related Eye Disease Study (AREDS)         04/05/2012       02/11/2016   NEI  3446    1940  6552.v1
3 phs000001.v3.p1 NEI Age-Related Eye Disease Study (AREDS)         04/05/2012       02/11/2016   NEI   116     996  3305.v2
4 phs000001.v3.p1 NEI Age-Related Eye Disease Study (AREDS)         04/05/2012       02/11/2016   NEI   116     996  3306.v2
5 phs000001.v3.p1 NEI Age-Related Eye Disease Study (AREDS)         04/05/2012       02/11/2016   NEI  3464    1955 6676.v19
6 phs000001.v3.p1 NEI Age-Related Eye Disease Study (AREDS)         04/05/2012       02/11/2016   NEI  1897    1067 37715.v4
# ... with 6 more variables: Submitted_by_PI <dttm>, Approved_by_SO <dttm>, Approved_by_DAC <dttm>, Rejected_by_DAC <dttm>,
#   Revision_requested_by_DAC <dttm>, Data_downloaded <chr>
```
