# Databricks notebook source
# MAGIC %md
# MAGIC Swig isn't pre-installed, it can be installed through pip

# COMMAND ----------

# MAGIC
# MAGIC %sh swig -version

# COMMAND ----------

#pip install swig

# COMMAND ----------

# MAGIC %md
# MAGIC The example.i and the example.c files are created already in the directory

# COMMAND ----------

# MAGIC %md
# MAGIC Running swig works correctly

# COMMAND ----------

# MAGIC %sh swig -python example.i

# COMMAND ----------

# MAGIC %ls

# COMMAND ----------

# MAGIC %md
# MAGIC example_wrap.c and the example.py files are now created

# COMMAND ----------

# get python includes location
from sysconfig import get_paths
from pprint import pprint

info = get_paths()  # a dictionary of key-paths

# pretty print it for now
pprint(info)

# COMMAND ----------

# MAGIC %sh gcc -v -c example.c example_wrap.c -I/usr/include/python3.10

# COMMAND ----------

import example

# COMMAND ----------

example.fact(6)
