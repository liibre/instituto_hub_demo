# Script para manipulacao de dados de covid19 no Amapa

# 1. Lendo os dados ------------------------------------------------------------
amapa <- read.csv("dados/brutos/01-amapa.csv", stringsAsFactors = FALSE)

# checando os dados
head(amapa)

# municipios do Amapa
unique(amapa$city)

# coluna place_type
table(amapa$place_type)

# municipios tipo onde municipio é NA
unique(amapa$place_type[is.na(amapa$city)])


# 2. a classe data -------------------------------------------------------------
class(amapa$date)
class(amapa$last_available_date)

# Conversão para data
data1 <- as.Date(amapa$date[1])
data1
# Mudando o formato com a função format()
format(data1, "%d/%m/%y")
format(data1, "%d/%m/%Y")

# Modificando as colunas de data para a classe date
amapa$date <- as.Date(amapa$date)
amapa$last_available_date <- as.Date(amapa$last_available_date)

class(amapa$date)

range(amapa$date)

# 3. Entendendo as colunas com os dados ----------------------------------------
# Olhando para os dados de casos e obitos
## casos acumulados
acu <- aggregate(last_available_confirmed ~ city, FUN = max, data = amapa)
acu

# Um grafico de barras
barplot(acu[, 2], names.arg = acu[, 1])

# Ordenando as barras com a funcao order()
acu_or <- acu[order(acu$last_available_confirmed), ]
acu_or

# Novamente o grafico de barras
barplot(acu_or[, 2], names.arg = acu_or[, 1], las = 2)

# 4. Juntando duas tabelas ------------------------------------------------------
# Lendo os dados
muni_apagao <- read.csv("dados/brutos/municipios_apagao_11-2020.csv",
                        stringsAsFactors = FALSE)

# Quantos municipios
table(muni_apagao$apagao)

# Juntando duas tabelas a partir de uma coluna comum
acu_or_apagao <- merge(acu_or, muni_apagao,
                       by = "city", sort = FALSE)

# inspecionando a saida
head(acu_or)
head(acu_or_apagao)
head(muni_apagao)

# Mais uma vez o barplot, agora com cores para os municipios com luz
barplot(acu_or_apagao[, 2], names.arg = acu_or_apagao[, 1],
        col = ifelse(acu_or_apagao$apagao == "sim", "grey", "orange"), las = 2)

# 5. Separando dados de estado e municipio -------------------------------------
estado <- amapa[amapa$place_type == "state", c(-15)]
dim(estado)

# outra forma: onde a coluna city é NA
estado2 <- amapa[is.na(amapa$city), c(-15)]
## as duas formas tem o mesmo resultado:
all.equal(estado2, estado)

head(estado)
tail(estado)

# dados apenas de Macapa por meio do geocode do IBGE
macapa <- amapa[amapa$city_ibge_code == "1600303", c(-15)]

dim(macapa)
head(macapa)
tail(macapa)

# Escrevendo os dados
if (!dir.exists("dados/processados/")) {
  dir.create("dados/processados/")
}

write.csv(estado,
          "dados/processados/02-estado_AP.csv",
          row.names = FALSE)

write.csv(macapa,
          "dados/processados/02-municipio_Macapa.csv",
          row.names = FALSE)


# 6. Explorando os dados com gráficos ------------------------------------------

# Casos acumulados por data no municipio
plot(last_available_confirmed ~ date, data = macapa)
lines(last_available_confirmed ~ date, data = macapa)

# Casos acumulados por dada no estado todo
plot(last_available_confirmed ~ date, data = estado,
     xlab = "Data de notificação", ylab = "Casos acumulados")
lines(last_available_confirmed ~ date, data = estado)

# Adicionando linha do município
lines(last_available_confirmed ~ date, data = macapa, col = "red")
points(last_available_confirmed ~ date, data = macapa, col = "red")
# Legenda
legend("topleft", c("estado AP", "município Macapá"),
       pch = 1, col = c("black", "red"))

# Grafico de dispersao
plot(x = amapa$estimated_population,
     y = amapa$last_available_confirmed)

# Boxplot
boxplot(last_available_death_rate ~ city,
        data = amapa)
