#install.packages("sparklyr")


library(sparklyr)
library(dplyr)

Sys.setenv(HADOOP_CONF_DIR = '/etc/hadoop/conf')
Sys.setenv(YARN_CONF_DIR = '/etc/hadoop/conf')
Sys.setenv(SPARK_HOME="/usr/lib/spark")

sc <- spark_connect(master = "yarn-client")

spark_read_csv(sc, name="test", path="gs://twitter_rstudio/fishharvest.csv")