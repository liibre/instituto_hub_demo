# Script para download dos dados de covid19 no Amapa
## por Sara Mortara & Andrea Sánchez-Tapia

# Para instalar o pacote use:
#remotes::install_github("liibre/coronabr")

# bibliotecas
library(coronabr)

# Criando diretorio para guardar os dados
caminho <- "dados/brutos"  #poderia ser "./dados/brutos"
## Cria apenas se o caminho ainda nao existe
if (!dir.exists(caminho)) {dir.create(path = caminho, recursive = TRUE)}

amapa <- get_corona_br(dir = caminho, filename = "01-amapa", uf = "AP")

# Checando os arquivos
list.files("dados/brutos")

# Entendendo o arquivo de metadado
meta <- read.csv("dados/brutos/01-amapa_metadado.csv")

meta
