
import os

def rename_files_with_prefix(directory, prefix):
    for filename in os.listdir(directory):
        if not filename.startswith(prefix):
            new_name = prefix + filename
            os.rename(os.path.join(directory, filename), os.path.join(directory, new_name))

if __name__ == "__main__":
    directory = os.path.dirname(os.path.abspath(__file__))
    prefix = "H3_"
    rename_files_with_prefix(directory, prefix)