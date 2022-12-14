library(ggplot2)
library(tidyverse)
library(dplyr)


server <- function(input, output){
  #Dados box 1
  localidade <- read.csv(file = "./dados/CSVs/gerais/cidade.csv", sep = ";")
  
  #Dados box 2
  linhas <- read.csv(file = "./dados/CSVs/gerais/linhas.csv", sep = ",")
  
  #Dados box 3
  df_passageiros <- read.csv(file = "./dados/CSVs/gerais/passageiros.csv",
                          sep = " ")
  opp <- read.csv(file = "./dados/CSVs/gerais/operadoras.csv", sep = ",")
  
  #Dados chart idade
  media_idade <- read.csv(file = "./dados/CSVs/gerais/media_idade_frota.csv", sep = ",")
  
  #Dados chart frota
  frota_operadora <- read.csv("./dados/CSVs/gerais/frota.csv", sep = " ")
  dados <- data.frame(select(frota_operadora, operadora, frota))
  dados <- data.frame(rename(dados, group = "operadora", value = "frota"))
  
  #Dados quilometragem
  df_quilometragem <- read.csv("./dados/CSVs/gerais/quilometragem_percorrida.csv",
                               sep = ";")
  df_quilometragem <- filter(df_quilometragem, ano == 2021)
  
  #Dados chart media
  media_linhas <- read.csv("./dados/CSVs/linhas/media.csv", sep = ";")
  
  #Dados corredores
  corredores <- read.csv("./dados/CSVs/corredores/corredores_final.csv", sep = ",")
  #Filtra os corredores
  corredores_sel1 <- filter(corredores, id %in% c(1,2,3,4,5,6,7,8))
  corredores_sel2 <- filter(corredores, id %in% c(9,10,11,12,13,14,15,16))
  corredores_sel3 <- filter(corredores, id %in% c(17,18,19,20,21,22,23))
  #Seleciona ano, corredor, onibus hora
  corredores_sel1 <- select(corredores_sel1, ano, corredor, onibus.hora)
  corredores_sel2 <- select(corredores_sel2, ano, corredor, onibus.hora)
  corredores_sel3 <- select(corredores_sel3, ano, corredor, onibus.hora)
  
  #Dados
  
  ##Box 1
  output$cidade <- renderInfoBox({
    valueBox(
      value = tags$p(icon("fa-sharp fa-solid fa-city"), localidade$cidade,
                     style = "font-size: 50%;",),
      HTML(paste("Área em Km²: ", localidade$area, br(),
                 "População: ", localidade$populacao, br(),
                 " IDH: ", localidade$IDH)),
      input$count
    )
  })
  
  ##Box 2
  output$linhas <- renderValueBox({
    valueBox(
      value = tags$p(icon("fa-sharp fa-solid fa-bus"),
                     "Frota", style = "font-size: 50%;"),
      HTML(paste("Linhas: ", linhas$linhas, br(),
                 "Frota: ", linhas$frota, br(),
                 "Pontos: ", linhas$pontos)),
      input$count
    )
  })
  
  ##Box 3
  output$operadoras <- renderValueBox({
    valueBox(
      value = tags$p(icon("fa-sharp fa-solid fa-bus"),"Operadoras",
                     style = "font-size: 50%;"),
      HTML(paste(opp[,1])),
      input$count
    )
  })
  
  ##Box 4
  output$passageiros <- renderValueBox({
    valueBox(
      value = tags$p(df_passageiros$passageiros,
                     style = "font-size: 50%;"),
      paste0("Passageiros transportados (2021)"),
      input$count
    )
  })
  ##Box 5
  output$viagens <- renderValueBox({
    valueBox(
      value = tags$p(df_passageiros$viagens, style = "font-size: 50%;"),
      paste0("Viagens (2021)"),
      input$count
    )
  })
  ##Box 6
  output$quilometragem <- renderValueBox({
    valueBox(
      value = tags$p(df_quilometragem$quilometragem_percorrida,
                     style = "font-size: 50%;"),
      paste0("Quilometragem percorrida (2021)"),
      input$count
    )
  })
  
  ##Frota pie chart
  output$frota <- renderPlot({
    ggplot(dados, aes(x="", y=value, fill=group)) +
    geom_bar(stat="identity", width=1) +
    coord_polar("y") +
      theme_void() +
      geom_text(aes(label = paste0(value,
        " (", scales::percent(value / sum(value)),
        ")")), position = position_stack(vjust = 0.4))

  })
  
  #Media idade frota
  output$media_idade <- renderPlot({
    ggplot(media_idade, aes(x = ano, y = idade_media_frota, fill=group)) +
      geom_col(width = 0.5, fill = "blue" )
  })
  
  #Media linhas por ano
  output$media_linhas <- renderPlot({
    ggplot(media_linhas, aes(x = ano, y = media, group = operadora)) +
      geom_line(aes(color=operadora))+
      geom_point(aes(color=operadora))
  })
  
  #Corredores
  output$corredores1 <- renderPlot({
    ggplot(corredores_sel1, aes(fill=factor(ano), y=onibus.hora, x=corredor)) + 
      geom_bar(width = 0.7,position="dodge", stat="identity") +
      coord_flip()
  })
  
  output$corredores2 <- renderPlot({
    ggplot(corredores_sel2, aes(fill=factor(ano), y=onibus.hora, x=corredor)) + 
      geom_bar(width = 0.8,position="dodge", stat="identity") +
      coord_flip()
  })
  
  output$corredores3 <- renderPlot({
    ggplot(corredores_sel3, aes(fill=factor(ano), y=onibus.hora, x=corredor)) + 
      geom_bar(width = 0.8,position="dodge", stat="identity") +
      coord_flip()
  })
}


