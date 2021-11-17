library("readxl")
library("lubridate")
library("tidyverse")
library("bbplot")
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

pop_dat <- read_csv(".\\data/county-populations.csv")

part_2 <- left_join(dat_2, pop_dat)

## Find top 16 counties.
top_count <- tail(pop_dat[order(pop_dat$population), ], n = 17) |> pull(county)

part_2 |> filter(county %in% top_count) |> 
  filter(county != "Total") |> 
  ggplot(aes(x = date, y = cases, group = county)) +
  geom_line(aes(color = county), size = 1, alpha = .5) +
  scale_color_viridis_d() +
  labs(title = "Incident Cases", 
       subtitle = "For 16 Largest Counties in Texas", 
       x = "Date",
       y = "New Cases")


