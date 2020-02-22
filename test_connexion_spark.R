#install.packages("sparklyr")

Sys.setenv(HADOOP_CONF_DIR = '/etc/hadoop/conf')
Sys.setenv(YARN_CONF_DIR = '/etc/hadoop/conf')
Sys.setenv(SPARK_HOME="/usr/lib/spark")

# SPARKLYR

library(sparklyr)
library(dplyr)

sc <- spark_connect(master = "yarn-client")

spark_read_csv(sc, name="test", path="gs://twitter_rstudio/fishharvest.csv")

spark_read_csv(sc, name="test2", path="gs://twitter_rstudio/fishharvest.csv")

test  <- spark_read_csv(sc, name="test2", path="gs://twitter_rstudio/fishharvest.csv")


test_df <- test %>% 
  group_by(species) %>%
  summarise(nb_lignes=n()) %>% collect()


# SPARKR

library(SparkR)

if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/usr/lib/spark")
}
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session(master = "yarn-client", sparkConfig = list(spark.driver.memory = "2g"))

people <- read.df("gs://twitter_rstudio/fishharvest.csv", "csv")
head(people)
