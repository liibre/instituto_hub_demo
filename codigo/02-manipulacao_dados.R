# Script para manipulacao de dados de covid19 no Amapa

# 1. Lendo os dados ------------------------------------------------------------
amapa <- read.csv("dados/brutos/01-amapa.csv")

# checando os dados
head(amapa)

# municipios do Amapa
unique(amapa$city)

# coluna place_type
table(amapa$place_type)

# 2. a classe data -------------------------------------------------------------
class(amapa$date)
class(amapa$last_available_date)

# Modificando as colunas de data para a classe date
amapa$date <- as.Date(amapa$date)
amapa$last_available_date <- as.Date(amapa$last_available_date)

class(amapa$date)

range(amapa$date)

# 3. Entendendo as colunas com os dados ----------------------------------------
# Olhando para os dados de casos e obitos
## casos acumulados
acu <- aggregate(last_available_confirmed ~ city, FUN = max, data = amapa)
acu[order(acu$last_available_confirmed), ]

b## casos acumulados proporcionais à populacao
acu_pop <- aggregate(last_available_confirmed_per_100k_inhabitants ~ city, FUN = max, data = amapa)
acu_pop[order(acu_pop$last_available_confirmed), ]

# 4. Separando dados de estado e municipio -------------------------------------
estado <- amapa[amapa$place_type == "state", c(-15)]

# outra forma: onde a coluna city é NA
estado2 <- amapa[is.na(amapa$city), c(-15)]
## as duas formas tem o mesmo resultado:
all.equal(estado2, estado)

head(estado)
tail(estado)

# dados apenas de Macapa por meio do geocode do IBGE
macapa <- amapa[amapa$city_ibge_code == "1600303", c(-15)]

head(macapa)
tail(macapa)

# casos novos confirmados
## para o municipio Macapa
plot(last_available_confirmed ~ date, data = macapa)
lines(last_available_confirmed ~ date, data = macapa)

# para o estado todo
plot(last_available_confirmed ~ date, data = estado,
     xlab = "Data de notificação", ylab = "Casos acumulados")
lines(last_available_confirmed ~ date, data = estado)

## adicionando linha do municipio
lines(last_available_confirmed ~ date, data = macapa, col = "red")
points(last_available_confirmed ~ date, data = macapa, col = "red")
legend("topleft", c("estado AP", "município Macapá"), pch = 1, col = c("black", "red"))

# Escrevendo os dados
write.csv(estado, "dados/processados/02-estado_AP.csv", row.names = FALSE)

write.csv(macapa, "dados/processados/02-municipio_Macapa.csv", row.names = FALSE)
