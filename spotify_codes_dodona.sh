
syntax () {
    echo "Syntax: spotify-code [-b <color>] [-f <color>] [-l] ID" >&2
}
l=0
headerWidth=360
b=$(echo "black")
f=$(echo "white")

while getopts ":b:f:l" opt; do
    case $opt in
        b  ) # verwerk optie b
            b=$(echo "$OPTARG")
            ;;
        f  ) # verwerk optie f
            f=$(echo "$OPTARG")
            ;;
        l  ) # verwerk optie l
            l=1
            headerWidth=420
            ;;
        \?  ) 
            syntax
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

if [[ $# -ne 1 ]]; then
    syntax
    exit 2
fi


if ! [[ $1 =~ ^0[0-7]{10}7[0-7]{10}0$ ]]; then
    syntax
    exit 3
fi

#header instellen
echo "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"$headerWidth\" height=\"110\" version=\"1.1\">" >> svg.txt
echo "<rect width=\"$headerWidth\" height=\"110\" fill=\"$b\" rx=\"10\" />" >> svg.txt

#elk streepje bepalen
for ((i=0;i<23;i++)); do
i2=$(($i + 1))
codeValue=$(echo "$1"| cut -b $i2)
height=$((20 + $codeValue * 10))
x=$((10 + 15 * $i))
y=$(echo "(110 - $height)/2"|bc)

echo "<rect width=\"10\" height=\"$height\" x=\"$x\" y=\"$y\" fill=\"$f\" rx=\"5\" />" >> svg.txt
done
#logo bepalen
if [[ $l -ne 0 ]]; then
    echo "<circle cx=\"385\" cy=\"55\" r=\"25\" fill=\"$f\" />" >> svg.txt
    echo "<polygon points=\"375,70 400,55 375,40\" fill=\"$b\" />" >> svg.txt
fi

echo "</svg>" >> svg.txt

cat svg.txt
rm svg.txt