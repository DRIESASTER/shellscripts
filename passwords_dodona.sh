### P1 ###
egrep '^[^secrt]*s[^secrt]*e[^secrt]*c[^secrt]*r[^secrt]*e[^secrt]*t[^secrt]*$' passwords.txt

### P2 ###
egrep '^[^ ]*[01OL]+[^ ]*[ ]+([^ ]*[01OL]+[^ ]*[ ]+){6}[^ ]*[01OL]+[^ ]*' passwords.txt

### P3 ###
egrep -i '(^|[ ])([a-z])[^ ]*\2([ ]|$)' passwords.txt

### P4 ###
egrep -v '(^|[ ])[^ ]*([^ ])[^ ]*[ ][^ ]*\2[^ ]*' passwords.txt

### w1 ###
egrep '^[^secrt]*s[^secrt]*e[^secrt]*c[^secrt]*r[^secrt]*e[^secrt]*t[^secrt]*$' passwords.txt |egrep '^[^ ]*[01OL]+[^ ]*[ ]+([^ ]*[01OL]+[^ ]*[ ]+){6}[^ ]*[01OL]+[^ ]*' | cut -d " " -f 1

### w2 ###
egrep '^[^ ]*[01OL]+[^ ]*[ ]+([^ ]*[01OL]+[^ ]*[ ]+){6}[^ ]*[01OL]+[^ ]*' passwords.txt|egrep -i '(^|[ ])([a-z])[^ ]*\2([ ]|$)'|cut -d " " -f 2

### w3 ###
egrep -i '(^|[ ])([a-z])[^ ]*\2([ ]|$)' passwords.txt|egrep -v '(^|[ ])[^ ]*([^ ])[^ ]*[ ][^ ]*\2[^ ]*'|cut -d " " -f 3

### w4 ###
egrep -v '(^|[ ])[^ ]*([^ ])[^ ]*[ ][^ ]*\2[^ ]*' passwords.txt|egrep '^[^secrt]*s[^secrt]*e[^secrt]*c[^secrt]*r[^secrt]*e[^secrt]*t[^secrt]*$'|cut -d " " -f 4