library(shinydashboard)
library(plotly)

ui <- dashboardPage(
  dashboardHeader(title = "Mobi Data SSA"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      tags$head(tags$style(HTML(".small-box {height: 130px}"))),
      valueBoxOutput("cidade"),
      valueBoxOutput("linhas"),
      valueBoxOutput("operadoras"),
      valueBoxOutput("passageiros"),
      valueBoxOutput("viagens"),
      valueBoxOutput("quilometragem"),
      valueBoxOutput("cicloviaria"),
      valueBoxOutput("pnb"),
      valueBoxOutput("infra_apoio_ciclista"),
    ),
    fluidRow(
      box(
        title = "Frota de cada operadora (média)",status = "primary", solidHeader = TRUE,
        plotOutput("frota", height = 300),
      ),
      box(
        title = "Média de linhas por ano",status = "primary", solidHeader = TRUE,
        plotlyOutput("media_linhas", height = 300))
      ),
    fluidRow(
      box(width=4,
        title = "Média de idade da frota",status = "primary", solidHeader = TRUE,
        plotlyOutput("media_idade")
        ),

      box(width=8, status = "primary",
      h3("Principais corredores"),
      tabsetPanel(
        tabPanel("Corredores 1", plotlyOutput("corredores1",width = "100%", height = "340")),
        tabPanel("Corredores 2", plotlyOutput("corredores2",width = "100%", height = "340")),
        tabPanel("Corredores 3", plotlyOutput("corredores3",width = "100%", height = "340")),
        tabPanel("Corredores 4", plotlyOutput("corredores4",width = "100%", height = "340")),
        tabPanel("Corredores 5", plotlyOutput("corredores5",width = "100%", height = "340")),
        tabPanel("Corredores 6", plotlyOutput("corredores6",width = "100%", height = "340"))
      )
    )
    ),
    fluidRow(
      box(width=6,
          title = "Frota operante (histórico)",status = "primary", solidHeader = TRUE,
          plotlyOutput("historico_frota")
      ),
      box(width=6,
          title = "Aquisição de ônibus novos (histórico)",status = "primary", solidHeader = TRUE,
          plotlyOutput("historico_onibus_novos")
      ),
    ),
    fluidRow(
      box(width=6,
          title = "Qtde de passagens x salário mínimo",status = "primary", solidHeader = TRUE,
          plotlyOutput("passagens_sm")
      ),
      box(width=6, height = 460,
          title = "Qtde de passagens x renda mensal domiciliar per capita",status = "primary",
          solidHeader = TRUE,
          plotlyOutput("renda_percapita")
      )
    ),
    fluidRow(
    box(width=12, height = 320,
        title = "Terminologia & Créditos",status = "primary", solidHeader = TRUE,
        htmlOutput("terminologia")
    )
    )
)
)