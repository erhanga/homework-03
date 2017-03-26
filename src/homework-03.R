#######################
# Házi feladat 3.     #
# Programozás I.      #
# 2016/17. II. félév  #
# Erdélyi Hanga       #
# 2017-03-20          #
#######################

# II. feladat

# 1. feladat

# generálok egy véletlen kezdőszámot

set.seed(567356)

# létrehozom a listát, amit feltöltök for ciklus segítségével
# a for ciklus 5 vektort generál
# létrehozok egy hossz változót, ami egy 10 és 20 közötti számot generál
# ez adja meg a vektorok hosszait
# a vektorok (1,2) intervallumon, egyenletes eloszlásból származnak

l1 <- list()

for (i in 1:5) {
  hossz <- round(runif(1, min=10, max=20), digits=0)
  v <- runif(hossz, min=1, max=2)
  l1[[i]] <- v
}

l1

# 2. feladat

# létrehozok egy üres vektort
# for ciklussal feltöltöm, megnézem a létrehozott lista elemeinek hosszát

v1 <- c()

for (i in 1:5) {
  v1[i] <- length(l1[[i]])
}

v1

# 3. feladat

# az apply függvénycsaládból a lapply használatos listák esetén
# így a végeredmény egy lista
# lapply segítségével megnézem az l1 lista elemeinek hosszát

lapply(l1, length)

# 4. feladat

# az apply függvénycsaládból a sapply függvény segítségével is megnézem
#a vektor elemeinek hosszát
# sapply-jal az eredmény egy vektor lesz

sapply(l1, length)

########################################

# III. feladat

# 1. feladat

# behívom az R alapértelmezett "chickwts" nevű datasetjét

data("chickwts")
head(chickwts)

# 2. feladat

# aggregate függvénnyel csoportosítom a különbözőképpen táplált csirkéket
# megnézem a csoportok átlagsúlyát

aggregate(chickwts$weight, by = list(feed = chickwts$feed), mean)

# 3. feladat

# az előbb nem hoztam létre az aggregáló függvénnyel új dataframet, 
#ezt most megteszem

# rendezem az új dataframet
# az order alapbeállítás szerint növekvő sorrendbe állít,
#ezért - jellel megfordítottam a rendezést


uj_df <- aggregate(chickwts$weight, by = list(feed = chickwts$feed), mean)

uj_df[order(-uj_df$x),] 

########################################

# IV. feladat

# 1. feladat

# a set.seeddel elindítom a véletlenszámok generálását
# létrehozok egy üres, 50*10-es mátrixot
# a scale függvénnyel standardizálok 10 darab normál eloszlású számot,
#ez a szórás
# for ciklussal végigiterálok a sorokon, mindegyik esetén megszorzom a 
#standardizált számsort a sor számával - így a szórás egyenlő lesz a sor 
#számával

set.seed(567356)

m <- matrix(NA, nrow=50, ncol=10)

for (i in 1:nrow(m)) {
  m[i, ] <- i * scale(rnorm(10))
}

m

# 2. feladat

# for ciklussal megnézem minden sor szórását, ez egy vektorba kerül

m_rowsd <- c()

for (i in 1:nrow(m)) {
  m_rowsd[i] <- sd(m[i, ])
}

m_rowsd

# 3. feladat

# az apply függvénnyel is kiszámolom a szórást, ez is egy vektorba kerül

m_rowsd_app <- apply(m, 1, sd)
m_rowsd_app

# 4. feladat

# normalizálom a mátrix értékeit
# erre a "(m - min(m)) / (max(m) - min(m))" képletet találtam, de mivel ez
#0 és 1 közötti értékeket képez, megszorzom 2-vel (0 és 2 között) és kivonok 
#belőle 1-et (-1 és 1 között)

m_norm <- (m - min(m)) / (max(m) - min(m)) * 2 - 1
m_norm

# megnézem apply függvénnyel a sorok átlagát, vektorba kerül

m_nrowmean <- apply(m, 1, mean)
m_nrowmean

########################################

# V. feladat

# 1. feladat

# behívom a "fivethirtyeight" packaget
# beolvasom a "comic_characters" datasetet

if (!("fivethirtyeight" %in% installed.packages())) {
  install.packages("fivethirtyeight")
}
library(fivethirtyeight)

data("comic_characters")

# 2. feladat

# a lapply és strsplit függvényeket használva levágom 
#a karakterek neveinek végét (szóközre is ügyelve)

comic_characters$name <- lapply(comic_characters$name, function(name) {
  strsplit(name, split=" (", fixed=TRUE)[[1]][1]
})
head(comic_characters)

# 3. feladat

# létrehozom a get_gender függvényt
# if else szerkezetet használok: hogyha a gsm oszlopban NA érték van, akkor
#a sex oszlop tartalmát írja ki a függvény; ha a gsm oszlop értéke nem NA, 
#akkor a gsm oszlop tartalmát írja ki
# strsplit függvénnyel levágom a " Characters" részt
# a többször visszatérő neveknél minden egyező név esetén meg kell nézni a
#gendert; az értékek egy vektorba kerülnek

# lásd functions.R

# 4. feladat

# a megadott nevekkel kipróbálom a functions scriptbe írt függvényt

get_gender("Thor")
get_gender("Katherine Pryde")
get_gender("Loki Laufeyson")
