library(shiny)

ui <- fluidPage(
  titlePanel("Graccu"),
  
  hr(),
  
  sidebarLayout(
    
    #input panel
    sidebarPanel(
      tabsetPanel(
        tabPanel("Main",
                 fileInput("x", "Dataset CSV File:",
                     accept = c(
                       "text/csv",
                       ".csv",
                       "text/comma-separated-vales,text/plain")),
           
           
           sliderInput("epsRange", "eps Range:",
                       min = 1, max = 50, value = c(1,50)),
           
           
           sliderInput("minPtsRange", "minPts Range:",
                       min = 1, max = 50, value = c(1,50))
        ), # end main parameters tab panel
           
           
           #submitButton("Generate")),
        
        
        tabPanel("Optional",
           checkboxInput("borderPoints", "Border Points", TRUE),
           
           
           # FALSE is NULL
           checkboxInput("weights", "Weights", FALSE),
           conditionalPanel(
             condition = "input.weights == true",
             numericInput("weightsValue", "Weights:", 0)),
           
           
           selectInput("searchType", "Search Type:",
                       choices = c(
                         "kdtree",
                         "linear",
                         "dist"),
                       selected = "kdtree"),
           
           
           # only if kdtree is selected
           conditionalPanel(
             condition = "input.searchType == 'kdtree'",
             
             numericInput("bucketSize", "Bucket Size:", 10),
             
             
             selectInput("splitRule", "Split Rule:",
                       choices = c(
                         "SUGGEST",
                         "STD",
                         "MIDPT",
                         "FAIR",
                         "SL_MIDPT",
                         "SL_FAIR"),
                       selected = "SUGGEST")),
           
           
           numericInput("approx", "Relative Error Bound:", 0)
        ) # end optional parameters tab panel
      )
    ),
  
    
    # output panel
    mainPanel(
      tabsetPanel(
        tabPanel("Numeric Cluster Labels"
                 #tableOutput(),
                 #downloadButton()
                 ),
        tabPanel("Histogram"
                 #plotOutput()
                 ),
        tabPanel("2-Element Cluster Labels"
                 #tableOutput(),
                 #downloadButton()
                 ),
        tabPanel("Cloud Object"),
        tabPanel("Line Graph"
                 #plotOutput()
                 )
      )
    )
  ) # end sidebarLayout
)


server <- function(input, output) {}

shinyApp(ui = ui, server = server)