#!/bin/bash
#
# number divide by 3
# round it down
# subtract 2
#
####################################

for i in $(cat /tmp/fuelinput)
do
    echo $i
    divided=$(($i/3))
    subracted=$(($divided-2))
    echo $subracted >> /tmp/newfuelinput
done

paste -sd+ /tmp/newfuelinput | bc