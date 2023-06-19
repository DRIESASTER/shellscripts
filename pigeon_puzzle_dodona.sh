### P1 ###
egrep '(^|[ ])[A-Z]*G[A-Z]*[ ]+[A-Z]*C[A-Z]*[ ]+[A-Z]*H[A-Z]*[ ]+[A-Z]*Q[A-Z].*$' pigeon.txt

### P2 ###
egrep '(^|[ ])([AOEIU][QWRTYPSDFGHJKLZXCVBNM]){1,}[AOEIU]?([ ]|$)|(^|[ ])([QWRTYPSDFGHJKLZXCVBNM][AIOEU]){1,}[QWRTYPSDFGHJKLZXCVBNM]?([ ]|$)' pigeon.txt

### P3 ###
egrep -v '(^|[ ])([A-Z])[^ ]*[ ][^ ]\2' pigeon.txt

### P4 ###
egrep '^[^ ]*([A-Z])[^ ]*\1[^ ]*([ ]+[^ ]*([A-Z])[^ ]*\3[^ ]*){1,}[ ]*[^ABCDEFGHIJKLMNOPQRSTUVWXYZ]*$' pigeon.txt


### w1 ###
egrep '(^|[ ])[A-Z]*G[A-Z]*[ ]+[A-Z]*C[A-Z]*[ ]+[A-Z]*H[A-Z]*[ ]+[A-Z]*Q[A-Z].*$' pigeon.txt|egrep '(^|[ ])([AOEIU][QWRTYPSDFGHJKLZXCVBNM]){1,}[AOEIU]?([ ]|$)|(^|[ ])([QWRTYPSDFGHJKLZXCVBNM][AIOEU]){1,}[QWRTYPSDFGHJKLZXCVBNM]?([ ]|$)' | sed 's/ /\n/g'|rev|cut -c 1|tr '\n' ' '| tr -d ' '

### w2 ###
egrep '(^|[ ])([AOEIU][QWRTYPSDFGHJKLZXCVBNM]){1,}[AOEIU]?([ ]|$)|(^|[ ])([QWRTYPSDFGHJKLZXCVBNM][AIOEU]){1,}[QWRTYPSDFGHJKLZXCVBNM]?([ ]|$)' pigeon.txt | egrep -v '(^|[ ])([A-Z])[^ ]*[ ][^ ]\2' | sed 's/ /\n/g'|rev|cut -c 1|tr '\n' ' ' | tr -d ' '

### w3 ###
egrep -v '(^|[ ])([A-Z])[^ ]*[ ][^ ]\2' pigeon.txt|egrep '^[^ ]*([A-Z])[^ ]*\1[^ ]*([ ]+[^ ]*([A-Z])[^ ]*\3[^ ]*){1,}[ ]*[^ABCDEFGHIJKLMNOPQRSTUVWXYZ]*$'| sed 's/ /\n/g'|rev|cut -c 1|tr '\n' ' '| tr -d ' '

### w4 ###
egrep '(^|[ ])[A-Z]*G[A-Z]*[ ]+[A-Z]*C[A-Z]*[ ]+[A-Z]*H[A-Z]*[ ]+[A-Z]*Q[A-Z].*$' pigeon.txt | egrep '^[^ ]*([A-Z])[^ ]*\1[^ ]*([ ]+[^ ]*([A-Z])[^ ]*\3[^ ]*){1,}[ ]*[^ABCDEFGHIJKLMNOPQRSTUVWXYZ]*$'| sed 's/ /\n/g'|rev|cut -c 1|tr '\n' ' '|tr -d ' '