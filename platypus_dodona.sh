if [[ $# -gt 1 ]]; then
    echo "Syntax: platypus [file]" >&2
    exit 1
fi

file=${1:-/dev/stdin}

if [[ ! -e $file || ! -r $file ]];then
    echo "platypus: could not read file \"$file\"" >&2
    exit 2
fi

lines=$(cat $1 | wc -l)
for ((i=1 ; i<=$lines ; i++)); do

    negative_test=$(sed "${i}q;d" $file | cut -b 1)
    if [[ $negative_test = '-' ]]; then
        teller=$(sed "${i}q;d" $file | cut -b 2)
        noemer=$(sed "${i}q;d" $file | cut -d "/" -f2 | cut -d " " -f1)
        word=$(sed "${i}q;d" $file | sed "s%^[^ ]* \(.*\)$%\1%g" | rev)
        lengte_temp=$(sed "${i}q;d" $file | sed "s%^[^ ]* \(.*\)$%\1%g" | wc -c)
        lengte=$(echo "$lengte_temp -1" | bc)
        multiplicatie=$(echo "$lengte / $noemer" | bc)
        char=$(echo "$multiplicatie * $teller" | bc)
        echo -n $word | cut -b 1-$char| rev >> temp.txt

    else

    teller=$(sed "${i}q;d" $file | cut -b 1)
    noemer=$(sed "${i}q;d" $file | cut -b 3)
    word=$(sed "${i}q;d" $file | sed "s%^[^ ]* \(.*\)$%\1%g")
    lengte_temp=$(sed "${i}q;d" $file | sed "s%^[^ ]* \(.*\)$%\1%g" | wc -c)
    lengte=$(echo "$lengte_temp -1" | bc)
    multiplicatie=$(echo "$lengte / $noemer" | bc)
    char=$(echo "$multiplicatie * $teller" | bc)

    echo -n $word | cut -b 1-$char >> temp.txt

    fi
done
cat temp.txt |tr -d "\n" > final.txt
cat final.txt
rm final.txt
rm temp.txt