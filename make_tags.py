import subprocess, os, multiprocessing as mp

inputFile = "tags.txt"
outputDir = "output"

def generate_stl(line):
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
                    ])

def print_input_file_format_info():
    print("\nThis script expects a file called tags.txt in the same directory\n")
    print("tags.txt formatting:")
    print("Empty lines and lines starting with \"\\\\\" will be ignored.\n")
    print("The format of a line in tags.txt is:")
    print("\"line 1\",\"line 2\"")
    print("Where line 1 and line2 are the texts that will be printed on the respective lines of the tag.\n\n")
    print("=============================================================================================\n\n\n")


def main():
    print_input_file_format_info()

    if not os.path.isdir(outputDir):
        os.makedirs(outputDir)

    # create thread pool with at least one thread but alway leave at least one cpu thread unused.
    threadPool = mp.Pool(processes = max(mp.cpu_count()-1, 1))

    with open(inputFile, mode="r") as lines:
        threadPool.map_async(generate_stl, lines)

    # synchronize
    threadPool.close()
    threadPool.join()
    print("done\n")

if __name__ == "__main__":
    main()