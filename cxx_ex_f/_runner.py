# Databricks notebook source
# MAGIC %sh make clean

# COMMAND ----------

# MAGIC %sh make all

# COMMAND ----------

import pmain

# COMMAND ----------

# MAGIC %sh python3.10 _runscript.py

# COMMAND ----------

# MAGIC %sh echo $LD_LIBRARY_PATH

# COMMAND ----------

# MAGIC %sh LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Workspace/Repos/twj8@cdc.gov/bart_kate/cxx_ex_f/slib

# COMMAND ----------

import sys

# COMMAND ----------

sys.path.append("/Workspace/Repos/twj8@cdc.gov/bart_kate/cxx_ex_f/slib")

# COMMAND ----------

sys.path

# COMMAND ----------

import pmain

# COMMAND ----------

# MAGIC %sh export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Workspace/Repos/twj8@cdc.gov/bart_kate/cxx_ex_f/slib
