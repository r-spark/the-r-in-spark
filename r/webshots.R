webshots_create <- function() {

  webshots <- list(
    "02-getting-started-jdk-8.png"         = "http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html",
    "02-getting-started-rstudio.png"       = "https://www.rstudio.com/products/rstudio/download/",
    "05-clusters-cloudera.png"             = "https://www.cloudera.com/products/open-source/apache-hadoop/apache-spark.html",
    "05-clusters-hortonworks.png"          = "https://hortonworks.com/apache/spark/",
    "05-clusters-mapr.png"                 = "https://mapr.com/products/apache-spark/",
    "05-clusters-amazon-emr.png"           = "https://aws.amazon.com/emr/",
    "05-clusters-dataproc.png"             = "https://cloud.google.com/dataproc/",
    "05-clusters-azure.png"                = "https://azure.microsoft.com/en-us/services/hdinsight/",
    "05-clusters-apache-livy.png"          = "https://livy.incubator.apache.org/",
    "05-clusters-kubernetes.png"           = "https://kubernetes.io/",
    "05-clusters-mesos.png"                = "http://mesos.apache.org/",
  )

  webshot::webshot(
    as.character(webshots),
    file.path("images", names(webshots)),
    cliprect = "viewport",
    useragent = "Mozilla/5.0 (Macintosh; Intel Mac OS X)"
  )

}
