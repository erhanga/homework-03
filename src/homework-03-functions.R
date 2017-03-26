# V. feladat függvénye
# 3. feladat

get_gender <- function(name) {
  chars <- comic_characters[comic_characters$name == name,]
  genders <- apply(chars, 1, function(char) {
    if (is.na(char$gsm)) {
      gender <- char$sex
    } else {
      gender <- char$gsm
    }
    strsplit(gender, split=" Characters", fixed=TRUE)[[1]][1]
  })
  as.character(genders)
}

########################################

# többi függvény helyben van definiálva