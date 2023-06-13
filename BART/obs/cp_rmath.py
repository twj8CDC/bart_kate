# Databricks notebook source
# MAGIC %sh
# MAGIC ls -ll 
# MAGIC cp -r ./rmath /dbfs/packages 
# MAGIC ls -llR /dbfs/packages

# COMMAND ----------

# MAGIC %sh
# MAGIC cd /dbfs/packages/rmath
# MAGIC mkdir build && cd build
# MAGIC cmake ..
