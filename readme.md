# 3D-printable Cable Tag Generator

## input file formatting

* Empty lines and lines starting with `\\` will be ignored.

* The format of a line in tags.txt is
  * `"line 1","line 2"`
  * line1 and line2 are the texts that will be printed on the respective lines of the tag.

## make_tags.py command line options

    -i --inputfile [file]:
        The file from where the labels will be read.
        The default is "tags.txt"
    
    -o --outputdir [directory]:
        the directory where the stl files will be written to.
        The default is "outdir"
    
    -l --line ["line1","line2"]:
        Directly pass the two lines that will be put on a label. This will disable -i.

    -fs --font_size [size]:
        The font size of the tag. Currently the following values are valid:
        2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16
        The default is 5.

    -q --quiet [true|false]:
        Do not show OpenScad output.
        The default is true.

    -tc --thread_count:
        The number of simultaneous instances of OpenScad that this script is allowed to start.
        The default is max(1, [cpu thread count]-1)
