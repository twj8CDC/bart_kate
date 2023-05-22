# Databricks notebook source
# MAGIC %md
# MAGIC two flavors of McCullough et al BART:  
# MAGIC https://cran.r-project.org/web/packages/rbart/index.html  
# MAGIC
# MAGIC https://cran.r-project.org/web/packages/BART/index.html  

# COMMAND ----------

# MAGIC %md
# MAGIC ###Snake-ify using SWIG to create interface.c  
# MAGIC
# MAGIC https://swig.org/tutorial.html

# COMMAND ----------

# MAGIC %md
# MAGIC RCPP configuration decode to understand what this is doing now  
# MAGIC
# MAGIC https://www.r-bloggers.com/2014/02/three-ways-to-call-cc-from-r

# COMMAND ----------

# MAGIC %md
# MAGIC BART paper  
# MAGIC https://www.jstatsoft.org/article/view/v097i01  

# COMMAND ----------

# MAGIC %sh
# MAGIC # get BART source code, unzip
# MAGIC mkdir ./BART
# MAGIC cd ./BART
# MAGIC wget -O BART.pdf https://cran.r-project.org/web/packages/BART/BART.pdf
# MAGIC wget -O BART.tar.gz https://cran.r-project.org/src/contrib/BART_2.9.4.tar.gz
# MAGIC tar -xvf ./BART.tar.gz

# COMMAND ----------

# MAGIC %sh
# MAGIC
# MAGIC ls -llR ./BART/ | grep surv
