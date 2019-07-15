library(mleap)

mleap_model <- mleap_load_bundle("mleap_model.zip")

#* @post /predict
score_spark <- function(age, sex, drinks, drugs, essay_length) {
  new_data <- data.frame(
    age = as.double(age),
    sex = sex,
    drinks = drinks,
    drugs = drugs,
    essay_length = as.double(essay_length),
    stringsAsFactors = FALSE
  )
  mleap_transform(mleap_model, new_data)$prediction
}
