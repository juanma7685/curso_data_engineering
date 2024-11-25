#!/usr/bin/env python3
import os

def rename_files(directory):
    for root, dirs, files in os.walk(directory):
        for filename in files:
            if filename.startswith("2H_"):
                new_name = "H2_" + filename[3:]
                os.rename(os.path.join(root, filename), os.path.join(root, new_name))
                continue

if __name__ == "__main__":
    directory = "models/Marts_2_hechos"
    rename_files(directory)