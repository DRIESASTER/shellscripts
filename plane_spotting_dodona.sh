
syntax(){
    echo "Syntaxis: airplanes [-n <integer>] [-d <integer>] [-c] longitude latitude [file]" >&2
}

invalidcoordinates(){
    echo 'airplanes: invalid coordinates' >&2
    exit 2
}
n=0
d=0
c=0
while getopts ":n:d:c" opt; do
    case $opt in
        n  ) # verwerk optie n
            n=$(echo "$OPTARG")
            ;;
        d  ) # verwerk optie d
            d=$(echo "$OPTARG")
            ;;
        c  ) # verwerk optie c
            c=1
            ;;
        \?  ) 
            syntax
            exit 1
            ;;
    esac
done

# verdere error handling

shift $((OPTIND-1))


if [[ $# -ne 2 && $# -ne 3 ]]; then
    syntax
    exit 1
fi

lengtecheck=$(echo "$1 < 180" | bc)
lengtecheck2=$(echo "-180 < $1" | bc)
breedtecheck=$(echo "$2 < 90" | bc)
breedtecheck2=$(echo "-90 < $2" | bc)

re='^[+-]?[0-9]+([.][0-9]+)?$'
if ! [[ $1 =~ $re || $2 =~ $re ]]; then
    invalidcoordinates
elif [[ $lengtecheck -ne 1 || $breedtecheck -ne 1 || $lengtecheck2 -ne 1 || $breedtecheck2 -ne 1 ]]; then
    invalidcoordinates
fi

if [[ $# -eq 3 ]]; then
    if [[ ! -f $3 || ! -r $3 ]]; then
    echo "airplanes: cannot access '$3'" >&2
    exit 3
    fi
fi


    # error handling finished, start formulas

file=${3:-/dev/stdin}
linecount=$(wc -l $file|cut -b 1,2)
linecount1=$(echo "$linecount + 1" | bc)


for (( i=1 ; i<=$linecount ; i++ )); do
    if [[ $d -ne 0 ]]; then
    distance=$(sed -n "$i"p $file | python3 distance $1 $2 | cut -d ";" -f18)
        if [[ $distance -le $d ]]; then
            if [[ $c -eq 0 ]]; then
            sed -n "$i"p $file | python3 distance $1 $2 | cut -d ";" -f2,18 >> distance.txt
             else
            sed -n "$i"p $file | python3 distance $1 $2 | cut -d ";" -f2,3,18 >> distance.txt 
            fi
        
        fi

    else
        if [[ $c -eq 0 ]]; then
            sed -n "$i"p $file | python3 distance $1 $2 | cut -d ";" -f2,18 >> distance.txt
            
        else
        sed -n "$i"p $file | python3 distance $1 $2 | cut -d ";" -f2,3,18 >> distance.txt 
        fi
    fi
    
done


if [[ c -eq 0 ]]; then
    sed -i "s%^\([^;]*\);\([^;]*\)$%\1: \2 km%g" distance.txt
else
    sed -i "s%^\([^;]*\);\([^;]*\);\([^;]*\)$%\1 (\2): \3 km%g" distance.txt
fi


if [[ $n -ne 0 ]]; then
    cat distance.txt | sort -t ':' -k2n > distance2.txt
    head -n$n distance2.txt > distance.txt
else
    cat distance.txt | sort -t ':' -k2n  > distance2.txt
    cat distance2.txt > distance.txt
fi

cat distance.txt
rm distance.txt
rm distance2.txt