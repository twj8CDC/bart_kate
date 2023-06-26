# Databricks notebook source
# MAGIC %sh make clean

# COMMAND ----------

# MAGIC %sh make all

# COMMAND ----------

# MAGIC %sh ./_runscript.sh

# COMMAND ----------

# MAGIC %sh find /usr/ -name "*Rmath*"

# COMMAND ----------

# MAGIC %sh find /usr/ -name "*libR*so*"

# COMMAND ----------

# MAGIC %md
# MAGIC we only have the libR.so and no libRmath.so (which is the Rmath standalone). I belive that the Rmath components are in the "libR.so" and can be accessed with "R.h", however there is some issues with the way the code is written that the "Rmath.h" has different names with the library is standalone. The c++ src code for pmain expects Rmath standalone and those "Rmath.h" names. When I try excluding the `-DRMATH_STANDALONE` flag it results in errors in the pmain src code due to the expectation of the standalone library.
