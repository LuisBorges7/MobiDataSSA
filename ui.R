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
        title = "Frota de cada operadora (média)",status = "primary", solidHeader = TRUE,
        plotOutput("frota", height = 250),
      ),
      box(
        title = "Média de linhas por ano",status = "primary", solidHeader = TRUE,
        plotlyOutput("media_linhas", height = 250))
      ),
    fluidRow(
      box(width=4,
        title = "Média de idade da frota",status = "primary", solidHeader = TRUE,
        plotlyOutput("media_idade")
        ),

      box(width=8,
      h3("Principais corredores"),
      tabsetPanel(
        tabPanel("Corredores 1", plotlyOutput("corredores1",width = "100%", height = "340")),
        tabPanel("Corredores 2", plotlyOutput("corredores2",width = "100%", height = "340")),
        tabPanel("Corredores 3", plotlyOutput("corredores3",width = "100%", height = "340")),
        tabPanel("Corredores 4", plotlyOutput("corredores4",width = "100%", height = "340")),
        tabPanel("Corredores 5", plotlyOutput("corredores5",width = "100%", height = "340")),
        tabPanel("Corredores 6", plotlyOutput("corredores6",width = "100%", height = "340"))
      )
    ),
    )
    )
)
