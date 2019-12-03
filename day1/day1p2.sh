#!/bin/bash
#
# number divide by 3
# round it down
# subtract 2
# result then the same until 0 or negative
#
####################################
zero=0

#check for tmp files
if [[ -f /tmp/newfuelinput ]]; then
    rm -rf /tmp/newfuelinput
    touch /tmp/newfuelinput
else
    touch /tmp/newfuelinput
fi


for line in $(cat /tmp/fuelinput)
do
    while [[ $line -gt $zero ]]
    do
        echo $line >> /tmp/newfuelinput
        divided=$(($line/3))
        subracted=$(($divided-2))
        line=$subracted
    done
done
newfueloutputtotal=$(paste -sd+ /tmp/newfuelinput | bc)
fueloutputtotal=$(paste -sd+ /tmp/fuelinput | bc)

finaloutput=`expr $newfueloutputtotal - $fueloutputtotal`
echo $finaloutput