library("readxl")
library("lubridate")
library("tidyverse")
theme_set(
  theme_bw() +
  theme(panel.grid.minor.x = element_blank(),
        axis.title.y = element_text(angle = 0, vjust = .5)
  )
)

tb <- read_xlsx(".\\data\\data.xlsx", skip = 2)

head(tb)
dim(tb)

dat_2 <- tb |> 
  rename(county = "County Name") |> 
  gather(-1, key = "date", value = "cases") |> 
  mutate(date = str_extract(date, "[0-9]{2}-[0-9]{2}-[0-9]{4}"),
         date = mdy(date))
  

head(dat_2)
dim(dat_2)
