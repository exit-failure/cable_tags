# 3D-printable Cable Tag Generator

## Installation

### Download and install software:

* Install font [Quinze Narrow](https://www.ffonts.net/Quinze-Narrow.font).
* Install [Python](https://www.python.org/). This script has been tested with Python 3.11.
  * Under Windows, make sure that you select the option to add Python to PATH during the installation.
* Install [OpenScad](https://openscad.org/)

### Set up Windows evironment (should not be necessary for Linux and MacOS):

1. go to Start -> Settings -> Control Panel -> System -> Advanced tab -> Environment Variables -> System Variables
2. select Path
3. click Edit
4. click New
5. enter the path to the OpenScad main executable
6. press ENTER
7. click on OK and on OK again
8. You need to close all related windows. If that does not help, restart Windows

## Input file formatting

* Empty lines and lines starting with `\\` will be ignored.

* The format of a line in tags.txt is
  * `"line 1","line 2"`
  * line1 and line2 are the texts that will be printed on the respective lines of the tag.

## make_tags.py command line options (NOT YET IMPLEMENTED)

    -i --inputfile [file]:
        The file from where the labels will be read.
        The default is "tags.txt"
    
    -o --outputdir [directory]:
        the directory where the stl files will be written to.
        The default is "outdir"
    
    -l --line ["line1","line2"]:
        Directly pass the two lines that will be put on a label. This will disable -i.

    -f --font_size [size]:
        The font size of the tag. Currently the following values are valid:
        2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16
        The default is 5.
    
    -hx --hole_size_x [size in mm]:
        Horizontal size of the tag's hole.
        The default is 3;
    
    -hy --hole_size_y [size in mm]:
        Vertical size of the tag's hole.
        The default is 5;

    -q --quiet [true|false]:
        Do not show OpenScad output.
        The default is true.

    -t --thread_count [number]:
        The number of simultaneous instances of OpenScad that this script is allowed to start.
        The default is max(1, [cpu thread count]-1) meaning that you will have one thread less than the maximum of your CPU working simultaneously or one if your CPU is single threaded.
    
    -h --help:
        Show this help.
