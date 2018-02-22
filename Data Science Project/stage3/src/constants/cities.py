import os
import pandas as pd

working_dir = os.path.dirname(os.getcwd())
path_to_csv_dir = working_dir + os.sep + 'csv_files'+ os.sep
df = pd.read_csv(path_to_csv_dir + "aom_list.csv")

inputs = df['Input'].values
outputs = df['Output'].values

CITIES = dict(zip(inputs,outputs))
