webshots_create <- function() {
  webshots <- list(
    "starting-download-r.png"           = "https://r-project.org/",
    "starting-rstudio.png"              = "https://www.rstudio.com/products/rstudio/download/",
    "starting-download-java.png"        = "https://java.com/download",
    "clusters-cloudera.png"             = "https://www.cloudera.com/products/open-source/apache-hadoop/apache-spark.html",
    "clusters-hortonworks.png"          = "https://hortonworks.com/apache/spark/",
    "clusters-mapr.png"                 = "https://mapr.com/products/apache-spark/",
    "clusters-amazon-emr.png"           = "https://aws.amazon.com/emr/",
    "clusters-dataproc.png"             = "https://cloud.google.com/dataproc/",
    "clusters-databricks.png"           = "https://databricks.com/home2",
    # "clusters-azure.png"                = "https://azure.microsoft.com/en-us/services/hdinsight/",
    "clusters-apache-livy.png"          = "https://livy.incubator.apache.org/",
    "clusters-ibm.png"                  = "https://www.ibm.com/cloud/spark",
    "clusters-kubernetes.png"           = "https://kubernetes.io/",
    "clusters-mesos.png"                = "https://mesos.apache.org/",
    "clusters-yarn.png"                 = "https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YARN.html",
    "clusters-rstudio-server.png"       = "https://www.rstudio.com/products/rstudio/",
    "clusters-spark-standalone.png"     = "https://spark.apache.org/docs/latest/spark-standalone.html",
    "clusters-jupyter.png"              = "https://jupyter.org/"
  )

  webshot::webshot(
    as.character(webshots),
    file.path("images", names(webshots)),
    cliprect = "viewport",
    useragent = "Mozilla/5.0 (Macintosh; Intel Mac OS X)",
    zoom = 2
  )

}
