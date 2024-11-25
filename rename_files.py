#!/usr/bin/env python3
import os

def rename_files(directory):
    for root, dirs, files in os.walk(directory):
        for filename in files:
            new_name = "H3_" + filename
            os.rename(os.path.join(root, filename), os.path.join(root, new_name))

if __name__ == "__main__":
    directory = "models/Marts_3_hechos"
    rename_files(directory)