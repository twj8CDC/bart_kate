# Databricks notebook source
# MAGIC %md
# MAGIC TODO
# MAGIC 1. write cgbart.i file
# MAGIC 2. write gbart.py file
# MAGIC 3. write surv.bart.py file

# COMMAND ----------

# MAGIC %sh
# MAGIC ls src

# COMMAND ----------

# MAGIC %md
# MAGIC # Run SWIG 

# COMMAND ----------

# MAGIC %sh swig -python cgbart.i

# COMMAND ----------

# Keep this for now in the case the path changes

# from sysconfig import get_paths
# from pprint import pprint
# info = get_paths()  # a dictionary of key-paths
# # pretty print it for now
# pprint(info)

# COMMAND ----------

# MAGIC %md
# MAGIC # Run c++ compiler

# COMMAND ----------

# MAGIC %sh gcc -v -c example.c example_wrap.c -I/usr/include/python3.10 -I/usr/share/R/include
