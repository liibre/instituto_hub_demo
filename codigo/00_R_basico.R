# para saber onde estou trabalhando
getwd()

# listar arquivos
list.files()
list.files("codigo")   # subpasta
list.files("./codigo") # outra maneira de se referir à subpasta (. == "aqui")

## criar objetos com <-
2 + 2 # vai mostar o resultado sem fazer mais nada
soma <- 2 + 2 # não vai mostrar o resultado
soma # precisa chamar o nome do objeto para ver

# explorar o que está armazenado na memória (espaço de trabalho/workspace)
ls() # "list"
soma2 <- 2 + 3 # outro objeto
soma2
ls() # agora tem dois objetos

#####
# Cria vetores com c()
populacao <- c(1500, 2000)

estados <- c("Acre", "Alagoas", "Amapá", "Amazonas", "Tocantins")

# checar a classe
class(estados)
class(populacao)

# vetores lógicos
verdadeiro_falso <- c(FALSE, TRUE)
verdadeiro_falso
class(verdadeiro_falso)

# números inteiros
posicao <- c(1L, 2L)
posicao
class(posicao)

## ----str_length------------
str(estados) #estrutura
length(estados) # comprimento


## ----subsetting de vetores com []
estados <- c("Acre", "Alagoas", "Amapá", "Amazonas", "Tocantins")
estados[1] # primeiro elemento
estados[c(TRUE, FALSE, TRUE, FALSE, TRUE)] #subsetting com um vetor lógico
estados[1:3] # 1:3 cria um vetor 1, 2, 3
estados[1:4] # 1:4 cria um vetor 1, 2, 3, 4
#estados[ 1,3,5] #NAO! a vírgula marca dimensões
estados[c(1,3,5)] # tem que ser um vetor criado com c() para ele entender

## ----cláusulas lógicas
casos <- c(150, 200, 400, 500, 500, 600)
casos > 150
casos[casos > 150]
casos >= 150 # superior ou igual
casos < 300
casos == 200
casos != 200 # diferente

#  as cláusulas lógicas simplesmente criam os vetores lógicos, para fazer o subsetting o vetore vai dentro dos colchetes.
casos[casos > 150]


## ---vetores numéricos
1:10
seq(1, 10, 2) # sequencias (veja o help!)
rep(1:4, 2)
rep(1:4, each = 2) #veja o help para ver a diferença
unique(casos)

--------
# instalar pacotes

## # Para instalar pacotes desde CRAN
## install.packages("remotes") # tire o # para rodar.
##
## # Para instalar desde GitHub precisa saber o endereço do pacote. no caso coronabr está em https://github.com/liibre/coronabr
## remotes::install_github("liibre/coronabr")
##
## # Para carregar pacotes:
## os pacotes instalados devem ser carregados com library
### se só precisa de uma função pode chamar ela com :: como fizemos antes: remotes::install_github() L,81. só usa uma vez então não precisa carregar

## library(coronabr)

## # Para buscar ajuda
## ?coronabr
## help(get_corona_br)
## ??palavra_chave: mas em geral a gente procura na internet qual é o pacote e a função que faz o que a gente quer fazer.

## ----coronabr, echo = TRUE------------------------------
library(coronabr)


## ----get_corona_br, eval = FALSE-------------------
## caminho <- "dados/brutos" #criar um texto
## if (!dir.exists(caminho)) { #se a pasta NAO (!) existe,
##   dir.create(caminho, recursive = T) # crie o diretório. recursive aqui é porque precisa criar a pasta e a subpasta.
## }
## para fazer download dos arquivos na pasta escolhida e com o nome escolhido:
## get_corona_br(dir = caminho, filename = "01-amapa", uf = "AP")


## ----ler o arquivo-----------------------------
## veja a função read.csv. tem uma funçãõ mais genérica read.table que permite ler diferentes formatos, com ou sem cabeçalho (HEADER)
amapa <- read.csv("dados/brutos/01-amapa.csv", stringsAsFactors = FALSE)
class(amapa) # é um data.frame


## ----explorando o objeto amapa-
names(amapa)
dim(amapa)
nrow(amapa)
ncol(amapa)
head(amapa) # 6 linhas por padrão
tail(amapa)
length(amapa) # numero de colunas
summary(amapa) # quantis e a média


## -par subsetting é também com colchetes mas uma vrígula separa ambas dimensoes, primeiro linhas, depois colunas
amapa[, 1:3] # três primeiras colunas (todas as linhas)
amapa[4, 13] # quarto elemento da coluna 13
amapa[1:4, ] # quatro primeiras linhas, todas as colunas


am <- amapa[ , 1:3]
names(am)
amapa[1:3, ]
