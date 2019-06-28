library(sparklyr)
sc <- spark_connect(master = "local", version = "2.3")
spark_model <- ml_load(sc, "spark_model")

#* @post /predict
score_spark <- function(age, sex, drinks, drugs, essay_length) {
  new_data <- data.frame(
    age = age,
    sex = sex,
    drinks = drinks,
    drugs = drugs,
    essay_length = essay_length,
    stringsAsFactors = FALSE
  )
  new_data_tbl <- copy_to(sc, new_data, overwrite = TRUE)

  ml_transform(spark_model, new_data_tbl) %>%
    dplyr::pull(prediction)
}
