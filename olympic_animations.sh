round() {
  echo $(printf %.0f $(echo "($1 + 0.5)/1" | bc))
}

syntax(){
    echo "Syntax: track [-b <int>] [-h <char>] [-n] FILE FRAME" >&2
}

repeat(){
for ((i=1 ; i <= $2 ; i++)); do
    echo -n "$1" >> veld.txt
done
}

touch veld.txt
b=20
h=$(echo '@')
n=0
while getopts ":b:nh:" opt; do
    case $opt in
        b  ) # verwerk optie b
            if [[ $OPTARG =~ ^[+-]?[1-9][0-9]*$ ]];then
                b=$((OPTARG+2))
            else
                syntax
                exit 2
            fi
            ;;
        h  ) # verwerk optie h
            if [[ $OPTARG =~ ^[^124567890]$ ]]; then
                h=$(echo "$OPTARG")
            else
                syntax
                exit 3
            fi
            ;;
        n  ) # verwerk optie n
            n=1
            ;;
        \?  ) 
            syntax
            exit 1
            ;;
    esac
done

shift $((OPTIND-1)) 

if [[ ! -f $1 || ! -r $1 ]];then
    syntax
    exit 4

elif [[ ! $2 =~ ^[+-]?[0-9][1-9]*$ ]] && [[ $2 -gt $(cat $1|wc -l) ]]; then
    syntax
    exit 5

fi

#bepaal aantal runners
firstline=$(head -n 1 $1) 
echo "$firstline" > runners.txt
sed -i "s%\t%\+%g" runners.txt
sed -i "s%[0-9]%1%g" runners.txt
runners=$(cat runners.txt | sed "s%^1+%%g" | bc)

#bepaal lengte + b2kleiner
lastline=$(tail -n 1 $1) 
echo "$lastline" > runners.txt
sed -i "s%^[^\t]*\t\([^\t]*\)\t.*$%\1%g" runners.txt
lengte=$(cat runners.txt)
lengte1=$(echo "$lengte - 1" | bc)
b2kleiner=$(echo "$b" -2 |bc)



#bepaalposition
nline=$(echo "$2 + 1"|bc)
currentline=$(head -$nline $1 | tail -1)
echo "$currentline" > afstand.txt
sed -i "s%\t%,%g" afstand.txt

beweging(){
    frame=$(cat afstand.txt | cut -d ',' -f1)
    bwg=$(echo "$frame % 3" | bc)

    if [ $1 -eq 1 ]; then
        if [ $bwg -eq 0 ]; then
            echo -n "| $h/|" >> veld.txt

        elif [ $bwg -eq 1 ]; then
            echo -n "| $h |" >> veld.txt

        else
            echo -n '|\' >> veld.txt
            echo -n "$h |" >> veld.txt
        fi
    elif [ $1 -eq 2 ]; then
        if [ $bwg -eq 0 ]; then
            echo -n "|/| |" >> veld.txt

        elif [ $bwg -eq 1 ]; then 
            echo -n "|-|-|" >> veld.txt

        else
            echo -n "| |\|" >> veld.txt
        fi
    else 
        if [ $bwg -eq 0 ]; then
            echo -n "|/ \|" >> veld.txt
        elif [ $bwg -eq 1 ]; then
            echo -n "| | |" >> veld.txt
        else
            echo -n "|/ \|" >> veld.txt  
        fi
    fi
}


#print veld
echo "Runners: $runners, Length: $lengte, Frame: $2"

hashtags(){
    if [[ $n -eq 1 && $k -eq 2 ]]; then
        echo -n "|#$c#|" >> veld.txt
    else
     echo -n "|###|" >> veld.txt
    fi
}

for((c=1 ; c<=$runners ; c++)); do
    repeat +---+ $b
    echo "" >> veld.txt

    #bepaalposition-1
    field=$(echo "$c + 1"|bc)
    afstand=$(cat afstand.txt | cut -d ','  -f"$field")
    pos=$(echo "(($b - 1) * $afstand / $lengte)" | bc -l)
    pos2=$(round $pos)
    positie=$(echo $pos2)
    posklein=$(echo "$positie - 1" | bc)
    bpos=$(echo "$b2kleiner - $positie"|bc)

    for((k=1 ; k<= 3 ; k++)); do
        if [[ $positie -eq 0 || $positie -eq 19 ]]; then
        
            if [ $positie -eq 0 ]; then
                
                    beweging $k
                    repeat '|   |' $b2kleiner
                    hashtags
                    echo "" >> veld.txt
                
            else
                    hashtags
                    repeat '|   '  $b2kleiner
                    beweging $k
                    echo "" >> veld.txt
            fi
              
        else
        hashtags
        repeat '|   |'  $posklein 
        beweging $k 
        repeat '|   |' $bpos
        hashtags
        echo "" >> veld.txt
        
        fi



    done
done 
repeat +---+ $b >> veld.txt
sed -i "s%++%+%g" veld.txt
sed -i "s%||%|%g" veld.txt



cat veld.txt
rm veld.txt