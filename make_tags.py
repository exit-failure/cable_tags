"""
This script calls openscad to automatically crate cable tags
with the content of the tags being specified in a text file or read from command line.
"""

import subprocess
import os
import multiprocessing as mp

INPUT_FILE = "tags.txt"
OUTPUT_DIR = "output"




def generate_stl(line):
    """generates the stl file by calling openscad"""

    line = line.strip()

    #skip empty lines and comments
    if len(line) == 0 or line[0:2] == "//":
        return

    # skip malformed line (format is "line1","line2" incl. quotes)
    if line[0] != "\"" or line[-1] != "\"" or "\",\"" not in line:
        print("Malformed line found \"" + line + "\". Skipping.")
        return

    [line1, line2] = line.split("\",\"")
    [line1, line2] = line1[1:].strip(" "), line2[:-1].strip(" ")

    print("Generating tag ", line1 + "_" + line2 + ".stl" + "...")
    subprocess.run(["openscad",
                    #"--export-format", "stl"
                    "-o", "output" + os.sep + line1 + "_" + line2 + ".stl",
                    "-D", "line_1=\""+ line1 + "\"",
                    "-D", "line_2=\""+ line2 + "\"",
                    "-q",
                    "--hardwarnings",
                    "cable_tags.scad"
                    ],
                    check=False)


def print_input_file_format_info():
    """print information about the expected formatting of the input text file"""

    print("\nThis script expects a file called tags.txt in the same directory\n")
    print("tags.txt formatting:")
    print("Empty lines and lines starting with \"\\\\\" will be ignored.\n")
    print("The format of a line in tags.txt is:")
    print("\"line 1\",\"line 2\"")
    print("line 1 and line2 are the texts that will be printed on the tag.\n\n")
    print("===============================================================\n\n\n")


def main():
    """main"""
    print_input_file_format_info()

    if not os.path.isdir(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)

    # create thread pool with at least one thread but alway leave at least one cpu thread unused.
    with mp.Pool(processes = max(mp.cpu_count()-1, 1)) as thread_pool:
        with open(INPUT_FILE, mode="r", encoding="utf8") as lines:
            thread_pool.map_async(generate_stl, lines)
        # synchronize
        thread_pool.close()
        thread_pool.join()
        print("done\n")

if __name__ == "__main__":
    main()
