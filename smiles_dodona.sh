### P1 ###
egrep -v ".*\([^)]*\(" smiles.txt

### P2 ###
egrep "([0-9][^a-zA-Z]*){8,}" smiles.txt

### P3 ###
egrep "(^[^0-9]*([0-9]).*\2[^0-9]*$)|(^[^0-9]*[0-9][^0-9]*$)" smiles.txt

### P4 ###
egrep -i "((([ab]|[d-z])[a-z][a-z]).*\2.*\2)|(([a-z]([ab]|[d-z])[a-z]).*\5.*\5)|(([a-z][a-z]([ab]|[d-z])).*\8.*\8)" smiles.txt

### w1 ###
egrep -v ".*\([^)]*\(" smiles.txt |egrep "([0-9][^a-zA-Z]*){8,}"| cut -d " " -f2

### w2 ###
egrep "([0-9][^a-zA-Z]*){8,}" smiles.txt|egrep "(^[^0-9]*([0-9]).*\2[^0-9]*$)|(^[^0-9]*[0-9][^0-9]*$)"| cut -d " " -f2 

### w3 ###
#mijn p4 regex klopt niet volledig maar ik wil wel nog aantonen dat ik weet hoe het moet moest ik deze correct hebben, idem voor w4
egrep "(^[^0-9]*([0-9]).*\2[^0-9]*$)|(^[^0-9]*[0-9][^0-9]*$)" smiles.txt ||egrep -i "((([ab]|[d-z])[a-z][a-z]).*\2.*\2)|(([a-z]([ab]|[d-z])[a-z]).*\5.*\5)|(([a-z][a-z]([ab]|[d-z])).*\8.*\8)" |cut -d " " -f2 

### w4 ###
egrep -v ".*\([^)]*\(" smiles.txt |egrep -i "((([ab]|[d-z])[a-z][a-z]).*\2.*\2)|(([a-z]([ab]|[d-z])[a-z]).*\5.*\5)|(([a-z][a-z]([ab]|[d-z])).*\8.*\8)" |cut -d " " -f2 