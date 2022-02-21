# load required packages
library(leaflet);library(dplyr)

# import data from openflights.org

## permanent link to the dataset
url <- "https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat"

## read in data. column names are based on the website's note
## <http://openflights.org/data.html>
airports <- read.delim(url, sep = ",", header = FALSE,
                       col.names = c("Airport_ID", "Name", "City",
                                     "Country","IATA_FAA", "ICAO",
                                     "Latitude", "Longitude","Altitude",
                                     "Timezone", "DST", "TZ")
                       ) %>%
        mutate(Label = paste(paste0("<b>Airport</b>: ",
                                    Name, " (", IATA_FAA, ")"),
                             paste0("<b>City</b>: ", City),
                             paste0("<b>Country</b>: ", Country),
                             sep = "<br/>"))
# map the airports
airport.icon <- makeIcon("./assignments/pa1/black-plane.png",
                         iconWidth = 16, iconHeight = 16)
map <- airports %>% leaflet() %>% addTiles() %>%
        addMarkers(icon = airport.icon,
                   lng = airports$Longitude, lat = airports$Latitude,
                   popup = airports$Label,
                   clusterOptions = markerClusterOptions()
                   ) %>%
        setView(lng = -99.0721, lat = 19.4363, zoom = 2)

map
