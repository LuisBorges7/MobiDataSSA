library(ggplot2)
library(tidyverse)
library(dplyr)
library(plotly)

server <- function(input, output){
  #Dados box 1 - Cidade
  df_cidade <- read.csv(file = "./dados/CSVs/gerais/cidade.csv", sep = ";")
  
  #Dados box 2 - Frota
  df_linhas <- read.csv(file = "./dados/CSVs/gerais/linhas.csv", sep = ",")
  
  #Dados box 3 - Operadoras
  df_operadoras <- read.csv(file = "./dados/CSVs/gerais/operadoras.csv", sep = ",")
  
  #Dados box 4 e 5 - Passageiros transportados e viagens
  df_passageiros <- read.csv(file = "./dados/CSVs/gerais/passageiros.csv", sep = " ")
  
  #Dados box 6 - Quilometragem
  df_quilometragem <- read.csv("./dados/CSVs/gerais/quilometragem_percorrida.csv", sep = ";")
  df_quilometragem <- filter(df_quilometragem, ano == 2021)
  
  #Dados box 7 - Infraestrutura cicloviaria
  df_infra_cicloviaria <- read.csv(file = "./dados/CSVs/gerais/infraestrutura_cicloviaria.csv", sep = ";")
  
  #Dados box 8 - PNB
  df_pnb <- read.csv(file = "./dados/CSVs/gerais/pnb.csv", sep = ";")
  
  #Dados box 9 - Infraestrutura de apoio ao ciclista
  df_infra_apoio_ciclista <- read.csv(file = "./dados/CSVs/gerais/infraestrutura_apoio_ciclista.csv", sep = ";")
  
  #Dados chart idade
  media_idade <- read.csv(file = "./dados/CSVs/gerais/media_idade_frota.csv", sep = ",")
  
  #Dados chart frota
  frota_operadora <- read.csv("./dados/CSVs/gerais/frota.csv", sep = " ")
  dados <- data.frame(select(frota_operadora, operadora, frota))
  dados <- data.frame(rename(dados, group = "operadora", value = "frota"))
  
  #Dados chart media
  df_media_linhas <- read.csv("./dados/CSVs/linhas/media.csv", sep = ";")
  
  #Dados corredores
  corredores <- read.csv("./dados/CSVs/corredores/corredores_final.csv", sep = ",")
  
  #Filtra os corredores
  corredores_sel1 <- filter(corredores, id %in% c(1,2,3,4))
  corredores_sel2 <- filter(corredores, id %in% c(5,6,7,8))
  corredores_sel3 <- filter(corredores, id %in% c(9,10,11,12))
  corredores_sel4 <- filter(corredores, id %in% c(13,14,15,16))
  corredores_sel5 <- filter(corredores, id %in% c(17,18,19,20))
  corredores_sel6 <- filter(corredores, id %in% c(21,22,23))
  
  #Seleciona ano, corredor, onibus hora
  corredores_sel1 <- select(corredores_sel1, ano, corredor, onibus.hora)
  corredores_sel2 <- select(corredores_sel2, ano, corredor, onibus.hora)
  corredores_sel3 <- select(corredores_sel3, ano, corredor, onibus.hora)
  corredores_sel4 <- select(corredores_sel4, ano, corredor, onibus.hora)
  corredores_sel5 <- select(corredores_sel5, ano, corredor, onibus.hora)
  corredores_sel6 <- select(corredores_sel6, ano, corredor, onibus.hora)
  
  #Historico frota
  df_historico_frota <- read.csv(file = "./dados/CSVs/gerais/historico_frota_operante.csv", sep = ",")
  
  #Historico onibus novos
  df_historico_onibus_novos <- read.csv(file = "./dados/CSVs/gerais/historico_onibus_novos.csv", sep = ",")
  
  #Passagens e salario minimo
  df_sm_passagens <- read.csv(file = "./dados/CSVs/gerais/salario_minimo_passagem.csv", sep = ";")
  
  #Passagens e renda domiciliar per capita
  df_rp_passagens <- read.csv(file = "./dados/CSVs/gerais/renda_mensal_domiciliar_percapita.csv",
                              sep = ";")

  #Terminologia e creditos
  df_texto <- read.csv("./dados/CSVs/textos/texto.csv", sep = ";")
  df_creditos <- read.csv("./dados/CSVs/textos/creditos.csv", sep = ";")
  
  ##Box 1
  output$cidade <- renderValueBox({
    valueBox(
      color="blue",
      value = tags$p(icon("fa-sharp fa-solid fa-city"), df_cidade$cidade,
                     style = "font-size: 50%;",),
      HTML(paste("Área em Km²: ", df_cidade$area, br(),
                 "População: ", df_cidade$populacao, br(),
                 "IDH: ", df_cidade$IDH
                 )),
      input$count
    )
  })
  
  ##Box 2
  output$linhas <- renderValueBox({
    valueBox(
      color="blue",
      value = tags$p(icon("fa-sharp fa-solid fa-bus"),
                     "Frota", style = "font-size: 50%;"),
      HTML(paste("Linhas: ", df_linhas$linhas, br(),
                 "Frota: ", df_linhas$frota, br(),
                 "Ar-condicionado: ", df_linhas$ar_condicionado , "(",
                 format(round((df_linhas$ar_condicionado*100)/df_linhas$frota, 2)), "%)", br(),
                 "Acessibilidade: ", df_linhas$com_elevador , "(",
                 format(round((df_linhas$com_elevador*100)/df_linhas$frota, 2)), "%)", br()
                 )),
      input$count
    )
  })
  
  ##Box 3
  output$operadoras <- renderValueBox({
    valueBox(
      color="blue",
      value = tags$p(icon("fa-sharp fa-solid fa-bus"),"Operadoras",
                     style = "font-size: 50%;"),
      HTML(paste(df_operadoras[,1])),
      input$count
    )
  })
  
  ##Box 4
  output$passageiros <- renderValueBox({
    valueBox(
      color="yellow",
      value = tags$p(df_passageiros$passageiros,
                     style = "font-size: 50%;"),
      paste0("Passageiros transportados (2021)"),
      input$count
    )
  })
  
  ##Box 5
  output$viagens <- renderValueBox({
    valueBox(
      color="yellow",
      value = tags$p(df_passageiros$viagens, style = "font-size: 50%;"),
      paste0("Viagens (2021)"),
      input$count
    )
  })
  
  ##Box 6
  output$quilometragem <- renderValueBox({
    valueBox(
      color="yellow",
      value = tags$p(df_quilometragem$quilometragem_percorrida,
                     style = "font-size: 50%;"),
      paste0("Quilometragem percorrida (2021)"),
      input$count
    )
  })
  
  ##Box 7
  output$cicloviaria <- renderValueBox({
    valueBox(
      color="green",
      value = tags$p(icon("fa-sharp fa-solid fa-bicycle"),"Infraestrutura Cicloviária em Km",
                     style = "font-size: 50%;"),
      HTML(paste("Ciclovias: ", df_infra_cicloviaria$ciclovias, br(),
                 "Ciclofaixas: ", df_infra_cicloviaria$ciclofaixa, br(),
                 "Ciclorrotas: ", df_infra_cicloviaria$ciclorrota, br(),
                 "Calçadas compartilhadas: ", df_infra_cicloviaria$calcadas_compartilhadas
                 )),
      input$count
    )
  })
  
  ##Box 8
  output$pnb <- renderValueBox({
    valueBox(
      color="green",
      value = tags$p(icon("fa-sharp fa-solid fa-bicycle"),"People Near Bike Lanes (PNB)",
                     style = "font-size: 50%;"),
      HTML(paste("População residente no raio de 300 metros", br(),
                 "de distância de uma ciclovia: ", df_pnb$pnb, "%")),
      input$count
    )
  })
  
  ##Box 9
  output$infra_apoio_ciclista <- renderValueBox({
    valueBox(
      color="green",
      value = tags$p(icon("fa-sharp fa-solid fa-bicycle"),"Infraestrutura de Apoio ao Ciclista",
                     style = "font-size: 50%;"),
      HTML(paste("Oficinas e Lojas: ",df_infra_apoio_ciclista$oficinas_lojas,  br(),
                 "Estações de bicicleta: ", df_infra_apoio_ciclista$estacoes_bicicleta, br(),
                 "Bicicletários: ", df_infra_apoio_ciclista$bicicletarios
                 )
           ),
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
        ")")), position = position_stack(vjust = 0.4)) +
      theme(legend.text = element_text(size = 12))
  })
  
  ##Media linhas por ano
  output$media_linhas <- renderPlotly({
    ggplot(df_media_linhas, aes(x = ano, y = media, group = operadora)) +
      geom_line(aes(color=operadora)) +
      geom_point(color="blue") +
      theme(legend.text = element_text(size = 12)) 
  })
  
  ##Media idade frota
  output$media_idade <- renderPlotly({
    ggplot(media_idade, aes(x = ano, y = idade_media_frota, fill=group)) +
      geom_col(width = 0.5, fill = "blue")
  })
  
  ##Corredores
  output$corredores1 <- renderPlotly({
    ggplot(corredores_sel1, aes(fill=factor(ano), y=onibus.hora, x=corredor)) + 
      geom_bar(width = 0.7,position="dodge", stat="identity") +
      coord_flip() + theme(axis.text = element_text(size = 8)) +
      theme(legend.text = element_text(size = 10))
  })
  
  output$corredores2 <- renderPlotly({
    ggplot(corredores_sel2, aes(fill=factor(ano), y=onibus.hora, x=corredor)) + 
      geom_bar(width = 0.7,position="dodge", stat="identity") +
      coord_flip() + theme(axis.text = element_text(size = 8)) +
      theme(legend.text = element_text(size = 10))
  })
  
  output$corredores3 <- renderPlotly({
    ggplot(corredores_sel3, aes(fill=factor(ano), y=onibus.hora, x=corredor)) + 
      geom_bar(width = 0.7,position="dodge", stat="identity") +
      coord_flip() + theme(axis.text = element_text(size = 8)) +
      theme(legend.text = element_text(size = 10))
  })
  
  output$corredores4 <- renderPlotly({
    ggplot(corredores_sel4, aes(fill=factor(ano), y=onibus.hora, x=corredor)) + 
      geom_bar(width = 0.7,position="dodge", stat="identity") +
      coord_flip() + theme(axis.text = element_text(size = 8)) +
      theme(legend.text = element_text(size = 10))
  })
  
  output$corredores5 <- renderPlotly({
    ggplot(corredores_sel5, aes(fill=factor(ano), y=onibus.hora, x=corredor)) + 
      geom_bar(width = 0.7,position="dodge", stat="identity") +
      coord_flip() + theme(axis.text = element_text(size = 8)) +
      theme(legend.text = element_text(size = 10))
  })
  
  output$corredores6 <- renderPlotly({
    ggplot(corredores_sel6, aes(fill=factor(ano), y=onibus.hora, x=corredor)) + 
      geom_bar(width = 0.7,position="dodge", stat="identity") +
      coord_flip() + theme(axis.text = element_text(size = 8)) +
      theme(legend.text = element_text(size = 10))
  })
  
  ##Historico frota
  output$historico_frota <- renderPlotly({
    ggplot(df_historico_frota, aes(x = ano, y = frota_operante)) +
      geom_line(color="red") +
      geom_point(color="red") +
      theme(panel.grid.major = element_line(color = "blue",size = 0.25,linetype = 1),
            legend.text = element_text(size = 12))
  })
  
  ##Historico onibus novos
  output$historico_onibus_novos <- renderPlotly({
    ggplot(df_historico_onibus_novos, aes(x = ano, y = onibus_novos, fill=group)) +
      geom_col(width = 0.5, fill = "blue" )
  })
  
  ##Passagens e salario minimo
  output$passagens_sm <- renderPlotly({
    ggplot(df_sm_passagens, aes(x = ano, y = sm_passagem, group = 1)) +
      geom_line(color="red") +
      geom_point(color="red") +
      theme(panel.grid.major = element_line(color = "blue",size = 0.25,linetype = 1),
            legend.text = element_text(size = 12)) 
  })
  
  ##  #Passagens e renda domiciliar per capita
  output$renda_percapita <- renderPlotly({
    ggplot(df_rp_passagens, aes(x = ano, y = rp_passagem, group = 1)) +
      geom_line(color="red") +
      geom_point(color="red") +
      theme(panel.grid.major = element_line(color = "blue",size = 0.25,linetype = 1),
            legend.text = element_text(size = 12))
  })
  
  ##Terminologia & Créditos
  output$terminologia <- renderUI({
    str1 <- paste(df_texto[1,1], br())
    str2 <- paste(df_texto[2,1], br())
    str3 <- paste(df_texto[3,1], br())
    str4 <- paste(df_texto[4,1], br())
    str5 <- paste(df_creditos$texto)

    HTML(paste(str1, str2, str3, str4, str5, sep = '<br/>'))
    })
}