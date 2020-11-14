# Script para construir gráficos de covid19
## por Sara Mortara & Andrea Sánchez-Tapia

# Casos diarios Macapa
macapa <- read.csv("dados/processados/02-municipio_Macapa.csv")
# convertendo para classe data
macapa$date <- as.Date(macapa$date)

# um grafico basico -------------------------
plot(new_confirmed ~ date, data = macapa)
lines(new_confirmed ~ date, data = macapa)

# um grafico melhor --------------------------
# usando a funcao par para controlar parametros
par(bty = "l", las = 1)
# adicionando nome dos eixos
plot(new_confirmed ~ date, data = macapa,
     xlab = "Data",
     ylab = "Casos diários")
lines(new_confirmed ~ date, data = macapa)
#funcao dev.off()

# para exportar o grafico ----------------------
png("figs/casos_diarios_Macapa.png", res = 300,
    width = 1400, height = 1200)
par(bty = "l", las = 1)
# adicionando nome dos eixos
plot(new_confirmed ~ date, data = macapa,
     xlab = "Data",
     ylab = "Casos diários")
lines(new_confirmed ~ date, data = macapa)
dev.off()
