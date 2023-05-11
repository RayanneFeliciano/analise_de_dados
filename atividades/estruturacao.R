library(data.table)
library(dplyr)
library(tidyverse)

# carrega base de análise
fastFoodNutrition <- fread('https://storage.googleapis.com/kagglesdsdata/datasets/3028284/5206752/fastfood.csv?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=gcp-kaggle-com%40kaggle-161607.iam.gserviceaccount.com%2F20230510%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20230510T203855Z&X-Goog-Expires=259200&X-Goog-SignedHeaders=host&X-Goog-Signature=2878ed9baa008c2a8d91f5726917b1604f0d45b5f1af671a5b15c375741378c1c259522323de5f4d0e5a298859d2f4b211e85322159ada18a5c712ff9685f1f5223fbe10d6a1ad0ac88bd2d0827abcbe390681051544f7d8dc361139e79b9a817711f141846f9f529e6aa004a6f1c8a6c656095d118354af4a27406fab322e102e90429efb93a711caba7320693b30a8fb272462ec7932712660e63cf0243c7e1ae50175c4769e2d7a0c02e5aab85ed60a5026b43b477e2eff1c27e464d618b51c78e86c554efcddd4178fea6b8c2d481749169e5bc50fe22967035cd51d18f2293f8e04391b3695e9ba97b9a06a4415a83ac61b6d10388825036c97345b2b4f')

# cria vetor que determina alguns dos restaurantes da base de análise
sampleFastFoods <- c('Subway')

# aplica filtro na base original com o vetor criado anteriormente
goalFastFoods <- fastFoodNutrition %>% filter(restaurant %in% sampleFastFoods)

# criação de matriz, agrupando pelos restaurantes, criando uma nova linha e selecionando apenas algumas variáveis de interesse
mFastFoods <- goalFastFoods %>% group_by(restaurant) %>% mutate(row = row_number()) %>% select(restaurant, protein, calories, item, row)

mFastFoodsnew <- mFastFoods %>% pivot_wider(names_from = calories, values_from = protein) %>% remove_rownames() %>%  column_to_rownames(var = 'item')

view(mFastFoodsnew)
freq(fastFoodNutrition)
