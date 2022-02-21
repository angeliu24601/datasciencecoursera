# load required packages
library(shiny); library(dygraphs); library(htmlwidgets); library(dplyr)

# load 'baby names' data set
baby_names <- readRDS("./names.Rds")

# needed functions
valueFormatter<-'function(d){
                return d.toString().replace(/\\B(?=(\\d{3})+(?!\\d))/g, ",");
}'

get_data <- function(data, name, years, gender = "MF"){
        filtered_data <- data %>%
                filter(NAME == name, YEAR >= years[1] & YEAR <= years[2])
        if (gender == "M" | gender == "F"){
                filtered_data <- filtered_data %>%
                        filter(GENDER == gender) %>%
                        select(YEAR, COUNT)
        } else if (gender == "MF"){
                filtered_data <- filtered_data %>%
                        group_by(YEAR, NAME) %>%
                        summarise(COUNT = sum(COUNT)) %>%
                        select(YEAR, COUNT) %>% ungroup
        } else stop ("Bad argument to gender: must be 'M', 'F', or 'MF'")
        filtered_data

        if(setequal(seq(min(filtered_data$YEAR), max(filtered_data$YEAR)),
                    filtered_data$YEAR) == FALSE) {
                # fill in zero if there are years missing
                fill_missing <- data_frame(YEAR = setdiff(seq(min(filtered_data$YEAR),
                                                              max(filtered_data$YEAR)),
                                                          filtered_data$YEAR),
                                           COUNT = 0)
                filtered_data <- rbind(filtered_data, fill_missing) %>%
                        arrange(YEAR)
        }
        filtered_data
}

# Define UI for application that draws a line
ui <- fluidPage(
        # Application title
        titlePanel("Popularity of Baby Names"),

        # sidebar menu
        sidebarLayout(
                sidebarPanel(
                        textInput("NAME", label = "Enter a Name (e.g. Eva)",
                                  value = "Eva"),
                        radioButtons("GENDER",label = "Choose a Gender",
                                     choices = list("Male" = "M",
                                                    "Female" = "F",
                                                    "Both" = "MF"),
                                     selected = "MF"),
                        sliderInput("YEAR",
                                    label = "Select the Birth Years to display",
                                    min = min(baby_names$YEAR),
                                    max = max(baby_names$YEAR),
                                    value = c(min(baby_names$YEAR),
                                              max(baby_names$YEAR))
                )),

                mainPanel(
                        dygraphOutput("dygraph")
                  )
        )

)

# Define server logic required to draw a histogram
server <- function(input, output) {
        plot_dygraph <- reactive({
                name_data <- baby_names %>%
                        get_data(name = input$NAME,
                                 gender = input$GENDER,
                                 years = input$YEAR)
                name_ts <- ts(name_data[,-1], start = min(name_data$YEAR),
                              frequency = 1)
                name_ts
                })

        output$dygraph <- renderDygraph({
                dygraph(plot_dygraph(),
                        main = "# of babies with the chosen name & gender") %>%
                        dyOptions(drawPoints = TRUE, pointSize = 2,
                                  maxNumberWidth = 20, drawXAxis = TRUE,
                                  axisLabelWidth = 100) %>%
                        dyAxis("y", axisLabelFormatter=JS(valueFormatter),
                               valueFormatter = JS(valueFormatter))%>%
                        dyLegend(show = "always", width = 400,
                                 hideOnMouseOut = FALSE) %>%
                        dyRangeSelector()
        })

        #output$
}

# Run the application
shinyApp(ui = ui, server = server)
