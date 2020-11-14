# Script para construir gráficos de covid19
## por Sara Mortara & Andrea Sánchez-Tapia

# Casos diarios Macapa
macapa <- read.csv("dados/processados/02-municipio_Macapa.csv")
# convertendo para classe data
macapa$date <- as.Date(macapa$date)

# um grafico basico -------------------------
plot(new_confirmed ~ date, data = macapa)
lines(new_confirmed ~ date, data = macapa)

# um grafico melhor
# usando a funcao par para controlar parametros
par(bty = "l", las = 1)
# adicionando nome dos eixos
plot(new_confirmed ~ date, data = macapa,
     xlab = "Data",
     ylab = "Casos diários")
lines(new_confirmed ~ date, data = macapa)
#funcao dev.off()

# Lidando com cores ----------------------------
vermelho <- "#A70000" #ou rgb(167, 0, 0, maxColorValue = 255)
vermelho_trans <- rgb(167, 0, 0, alpha = 150, maxColorValue = 255)

plot(new_confirmed ~ date, data = macapa,
     xlab = "Data",
     ylab = "Casos diários",
     col = vermelho) # muda cor
lines(new_confirmed ~ date, data = macapa,
      col = vermelho_trans) # muda cor

# Mudando o ponto
plot(new_confirmed ~ date, data = macapa,
     xlab = "Data",
     ylab = "Casos diários",
     col = vermelho_trans,
     pch = 19,# muda tipo de ponto
     log = "y") # escala log no eixo y
lines(new_confirmed ~ date, data = macapa,
      col = vermelho_trans)
mtext("Fonte: Brasil.io", side = 1, adj = 1,
      padj = 8, cex = 0.8)

# para exportar o grafico ----------------------
png("figs/casos_diarios_Macapa.png", res = 300,
    width = 1500, height = 1200)
par(bty = "l", las = 1)
plot(new_confirmed ~ date, data = macapa,
     xlab = "Data",
     ylab = "Casos diários",
     col = vermelho_trans, # muda tipo de ponto
     pch = 19, log = "y")
lines(new_confirmed ~ date, data = macapa,
      col = vermelho_trans)
mtext("Fonte: Brasil.io", side = 1, adj = 1,
      padj = 8, cex = 0.8)
dev.off()
