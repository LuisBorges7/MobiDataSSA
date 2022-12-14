#testes
#
# Load ggplot2
library(ggplot2)
library(dplyr)
library(reshape)

# Create Data
data <- data.frame(
  group=LETTERS[1:5],
  value=c(13,7,9,21,2)
)
# Basic piechart
ggplot(data, aes(x="", y=value, fill=group)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)

cor <- read.csv("./dados/CSVs/corredores/corredores_final.csv", sep = ",")
#Seleciona os anos de 2018 e 2019 OK!
cor_sel <- filter(cor, ano %in% c(2018,2019,2020,2021))
cor_sel

#Seleciona os id's de 1 a 3 - OK!
cor_sel2 <- filter(cor, id %in% c(1,2,3,4,5,6,7))
cor_sel2
cor_sel3 <- select(cor_sel2, ano, corredor, onibus.hora)
cor_sel3
ggplot(cor_sel3, aes(fill=factor(ano), y=onibus.hora, x=corredor)) + 
  geom_bar(width = 0.4,position="dodge", stat="identity") +
  coord_flip()

######
df_idb <- read.csv("./dados/CSVs/gerais/idade_onibus.csv", sep = ",")
ano_atual <-2022
ateh_tres_anos <- filter(df_idb, df_idb$ano >= (ano_atual-3))
total_ateh_tres_anos <- sum(ateh_tres_anos$qtde)
total_ateh_tres_anos
ateh_cinco_anos <- filter(df_idb, df_idb$ano >= (ano_atual-5))
ateh_cinco_anos <- sum(ateh_cinco_anos$qtde)
ateh_cinco_anos


cor_sel <- select(cor, ano, corredor, onibus.hora)

melt_data <- melt(cor_sel2, cod = c("ano","corredor"))
ggplot(melt_data,aes(x=cod, y='onibus.hora',fill=corredor, label="ano"))+
  geom_col(position=position_dodge()) +
  coord_flip()

#  geom_text(size = 4, position =position_dodge(1),vjust=-.5)

cor_sel <- filter(cor, ano == 2018, corredor == 'onibus.hora')

melt(id.vars="ano",variable.name="corredor")


df$cd<-as.factor(as.character(df$cd))
ggplot(df,aes(x=Month,y=value,fill=cd,label=value))+geom_col(position=position_dodge())+
  geom_text(size = 4, position =position_dodge(1),vjust=-.5)