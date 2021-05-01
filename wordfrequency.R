install.packages("stringr")
library(stringr)
install.packages("dplyr")
library(dplyr)
install.packages("tidytext")
library(tidytext)


raw_moon <- readLines("C:/Temp/Data/speech_moon.txt", encoding = "UTF-8")
head(raw_moon)
moon <- raw_moon %>%
  str_replace_all("[^°¡-ÆR]", " " ) %>% # ÇÑ±Û¸¸ ³²±â±â
  str_squish() %>% # ¿¬¼ÓµÈ °ø¹é Á¦°Å
  as_tibble() # tibble·Î º¯È¯

word_space <- moon %>%
  unnest_tokens(input = value,
                output = word,
                token = "words")

word_space <- word_space %>%  count(word, sort = T)
word_space

word_space <- word_space %>% filter(str_count(word) > 1)
word_space


top20 <- word_space %>% head(20)
top20
 

install.packages("ggplot2")
library(ggplot2)

ggplot(top20, aes(x = reorder(word, n), y = n)) +  # ´Ü¾î ºóµµ¼ø Á¤·Ä
  geom_col() +
  coord_flip() # È¸Àü

ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = 0) + # ¸·´ë ¹Û ºóµµ Ç¥½Ã
  labs(title = "¹®ÀçÀÎ ´ëÅë·É Ãâ¸¶ ¿¬¼³¹® ´Ü¾î ºóµµ", # ±×·¡ÇÁ Á¦¸ñ
       x = NULL, y = NULL) + # Ãà ÀÌ¸§ »èÁ¦
  theme(title = element_text(size = 12)) # Á¦¸ñ Å©±â


install.packages("ggwordcloud")
library(ggwordcloud)
ggplot(word_space, aes(label = word, size = n)) +
  geom_text_wordcloud(seed = 1234) +
  scale_radius(limits = c(3, NA), # ÃÖ¼Ò, ÃÖ´ë ´Ü¾î ºóµµ
               range = c(3, 30)) # ÃÖ¼Ò, ÃÖ´ë ±ÛÀÚ Å©±â


ggplot(word_space, aes(label = word, size = n, col = n)) + # ºóµµ¿¡ µû¶ó »ö±ò Ç¥Çö
  geom_text_wordcloud(seed = 1234) +
  scale_radius(limits = c(3, NA), range = c(3, 30)) +
  scale_color_gradient(low = "#66aaf2", # ÃÖ¼Ò ºóµµ »ö±ò
                       high = "#004EA1") + # ÃÖ°í ºóµµ »ö±ò
  theme_gray()
# ¹è°æ ¾ø´Â Å×¸¶ Àû¿ë


p1<- ggplot(word_space, aes(label = word, size = n, col = n)) + # ºóµµ¿¡ µû¶ó »ö±ò Ç¥Çö
  geom_text_wordcloud(seed = 1234) +
  scale_radius(limits = c(3, NA), range = c(3, 30)) +
  scale_color_gradient(low = "#66aaf2", # ÃÖ¼Ò ºóµµ »ö±ò
                       high = "#004EA1")  # ÃÖ°í ºóµµ »ö±ò
p1+theme_minimal()      # ¹è°æ ¾ø´Â Å×¸¶ Àû¿ë

install.packages("showtext")
library(showtext)

font_add_google(name = "Nanum Brush Script", family = "nanumgothic2")
showtext_auto()

p1 <- ggplot(word_space, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "nanumgothic2") +  # ÆùÆ® Àû¿ë
  scale_radius(limits = c(3, NA), range = c(3, 30)) +
  scale_color_gradient(low = "#31609e", high = "#b52155") 
p1+ theme_minimal()


font_add_google(name = "Gamja Flower", family = "gamjaflower")
showtext_auto()

ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.3) +
  labs(title = "¹®ÀçÀÎ ´ëÅë·É Ãâ¸¶ ¿¬¼³¹® ´Ü¾î ºóµµ",
       x = NULL, y = NULL) +
  theme(title = element_text(size = 12), text = element_text(family = "gamjaflower")) # ÆùÆ® Àû¿ë
