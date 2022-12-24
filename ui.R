library(shinydashboard)
library(plotly)

ui <- dashboardPage(
  dashboardHeader(title = "Mobi Data SSA"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      tags$head(tags$style(HTML(".small-box {height: 120px}"))),
      infoBoxOutput("cidade"),
      valueBoxOutput("linhas"),
      valueBoxOutput("operadoras"),
      valueBoxOutput("passageiros"),
      valueBoxOutput("viagens"),
      valueBoxOutput("quilometragem")
    ),
    fluidRow(
      box(
        title = "Frota de cada operadora",status = "primary", solidHeader = TRUE,
        plotOutput("frota", height = 250),
      ),
      box(
        title = "Media de linhas por ano",status = "primary", solidHeader = TRUE,
        plotOutput("media_linhas", height = 250))
      ),
    fluidRow(
      box(width=4,
        title = "Media de idade da frota",status = "primary", solidHeader = TRUE,
        plotOutput("media_idade")
        ),

      box(width=8,
      h3("Principais corredores"),
      tabsetPanel(
        tabPanel("Corredores 1", plotOutput("corredores1",width = "100%", height = "340")),
        tabPanel("Corredores 2", plotOutput("corredores2",width = "100%", height = "340")),
        tabPanel("Corredores 3", plotOutput("corredores3",width = "100%", height = "340")),
        tabPanel("Corredores 4", plotOutput("corredores4",width = "100%", height = "340")),
        tabPanel("Corredores 5", plotOutput("corredores5",width = "100%", height = "340")),
        tabPanel("Corredores 6", plotOutput("corredores6",width = "100%", height = "340"))
      )
    ),
    )
    )
)
