$fa = 25;

// keep this even if you are using the python script!
//line_1="{YOU SHOULD NOT SEE THIS 1!}";
//line_2="{YOU SHOULD NOT SEE THIS 2!}";

// use the two sets of lines below to adjust for different font sozes
line_1="{T}";
line_2="{y}";
//line_1="{TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT}";
//line_2="{TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT}";


// size settings for different font sizes [x letter size dimension, y letter size  dimension, font left offset, edge]
fontSettings_2  =   [1.041,  2.80,   0,     0.7];
fontSettings_3  =   [1.560,  4.00,   0,     1.2];
fontSettings_4  =   [2.090,  5.30,   0,     1.5];
fontSettings_5  =   [2.610,  6.60,   0,     1.7];
fontSettings_6  =   [3.135,  8.00,   0,     1.8];
fontSettings_7  =   [3.645,  9.00,   0,     2.0];
fontSettings_8  =   [4.180,  10.6,   0,     2.0];
fontSettings_9  =   [4.695,  12.0,   0,     2.3];
fontSettings_10 =   [5.220,  13.5,   0,     2.5];
fontSettings_12 =   [6.250,  16.0,   0,     2.8];
fontSettings_14 =   [7.295,  18.7,   0,     3.0];
fontSettings_16 =   [8.335,  21.0,   0,     4.0];

// Font size. Make sure there is a valid set of settings for your chosen size. If there is none, create one or use a different font size.
fontSize = 4;

fontSettings =
    fontSize == 2   ?   fontSettings_2  :
    fontSize == 3   ?   fontSettings_3  :
    fontSize == 4   ?   fontSettings_4  :
    fontSize == 5   ?   fontSettings_5  : 
    fontSize == 6   ?   fontSettings_6  :
    fontSize == 7   ?   fontSettings_7  :
    fontSize == 8   ?   fontSettings_8  :
    fontSize == 9   ?   fontSettings_9  :
    fontSize == 10  ?   fontSettings_10 :
    fontSize == 12  ?   fontSettings_12 :
    fontSize == 14  ?   fontSettings_14 :
    fontSize == 16  ?   fontSettings_16 :
    undef;

//adjust accoring to zip tie properties
zipTieThickness = 3;
zipTieWidth = 10;

//self explanatory
baseThickness = 1.5;
fontThickness = 0.3;

//margins
edge = fontSettings[3];
leftEdge = 3;

//don't touch this
textXOffset = leftEdge + edge + zipTieThickness - fontSettings[2];

module base(ARGS) {
    xLength = max(len(line_1), len(line_2)) * fontSettings[0] + edge + textXOffset;
    ySize = 2*fontSettings[1] + 3*edge;

    difference() {
        cube(size = [xLength, ySize, baseThickness]);
        translate(v = [edge, (ySize-zipTieWidth)/2, 0])
            cube(size = [zipTieThickness, zipTieWidth, baseThickness]);
    }
}

module line(string, offset) {
    translate(v = [textXOffset, offset , baseThickness])
        linear_extrude(height = fontThickness)
            text(string, font="Quinze", size=fontSize, halign="left", valign="bottom");

}

union() {
    base();
    color(c = "Red") line(line_1, fontSettings[1]+2*edge);
    color(c = "Red") line(line_2, edge);
} 