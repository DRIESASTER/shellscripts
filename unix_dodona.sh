### part 1 ###
%s#\(.*\)\t[^\t]*\t[^\t]*#\1#g

### part 2 ###
%s#\t#;#g

### part 3 ###
g#\([^;]*\);Proprietary;\(.*\)#d

### part 4 ###
2,$!sort -t";" -k2,2 -k3,3nr

### part 5 ###
%s/\(^[^;]*;[^;]*;[0-9]\?[0-9]\)\([0-9][0-9][0-9]\)\(;[0-9]\?[0-9]\)\([0-9][0-9][0-9]\)/\1,\2\3,\4/

### part 6 ###
%s#\([^;]\+;[^;]\+;[^;]\+;\)\([^;]\+\) (\([1234567890-]\+\))\(;[^;]\+\) (\([^;]\+\));\(.*\)#\1\2;\3\4;\5;\6#g
%s#Font;License;Chars;Glyphs;Version (date);Filename (size);Font family;Font weight, style;Font type;Serif style#Font;License;Chars;Glyphs;Version;date;Filename;size;Font family;Font weight, style;Font type;Serif style#g

### part 7 ###
%s#\(^\|;\|$\)#"\1"#g
%s#^"\(.*\)"$#\1#g
