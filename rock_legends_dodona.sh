
i1=$(echo $1)
lengtei1=$(printf $1 | wc -c)

i2=$(echo $2)
lengtei2=$(printf $2 | wc -c)

#regex bouwen voor de te zoeken namen die voldoen aan de gegeven initialen
regex () {
    for ((n=1 ; n <= $1 ; n++)); do
    iVar=$(echo $2 | cut -b $n)
    if [[ $n -ne $1 ]]; then
        echo "$iVar[[:alpha:]]*( |-)" >> $3.txt
    else
        echo "$iVar[[[:alpha:]]*;" >> $3.txt
    fi
    done
}
regex $lengtei1 $i1 pattern
regex $lengtei2 $i2 pattern2

#de hierboven samengestelde regexen invullen en zorgen dat ik enkel de komeet codes overhoud

patterni1=$(cat pattern.txt | tr -d "\n")
pat=$(cat pattern2.txt | tr -d "\n")
patterni2=$(echo $pat)
cat $3 | egrep "^[^;]*;[^;]*;$patterni1" | sed "s#^\([^;]*\);.*\$#\1#g" > comets1.txt
cat $3 | egrep "^[^;]*;[^;]*;$patterni2" | sed "s#^\([^;]*\);.*\$#\1#g" > comets2.txt

lengteCom1=$(cat comets1.txt | wc -l)
lengteCom2=$(cat comets2.txt | wc -l)

#voor elke mogelijke optelling van de komeetcodes van de 2 geven initialen de namen van de personen zoeken die hier aan voldoen

for ((g=1; g<=$lengteCom1; g++)); do
    value1=$(sed "${g}q;d" comets1.txt)
    for ((b=1 ; b<=$lengteCom2 ; b++)); do
        value2=$(sed "${b}q;d" comets2.txt)
        totalValue=$(($value1 + $value2))
        cat $3 | egrep "^$totalValue;" | sed "s#[^;]*;[^;]*;\([^;]*\);.*\$#\1#g">> other.txt
    done
done
#opmaak van de gevraagde output
cometsi1=$(cat comets1.txt|sort -n| tr "\n" ","| sed "s#,\$##g")
cometsi2=$(cat comets2.txt|sort -n| tr "\n" ","| sed "s#,\$##g")
otheri=$(cat other.txt|sort | tr "\n" ","| sed "s#,\$##g")

echo "$i1=$cometsi1"
echo "$i2=$cometsi2"
echo "$i1+$i2=$otheri"
rm pattern.txt
rm pattern2.txt
rm other.txt