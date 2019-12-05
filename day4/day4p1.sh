#!/bin/bash
#===========================================================================
# It is a six-digit number.
# The value is within the range given in your puzzle input.
# Two adjacent digits are the same (like 22 in 122345).
# Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
# 
#===========================================================================
#
# Variables
#
#===========================================================================

start=136760
end=595730
outfile=/tmp/outfile

#===========================================================================
#
# Functions
#
#===========================================================================

function identifydigits() {
    first_char="${i:0:1}"
    second_char="${i:1:1}"
    third_char="${i:2:1}"
    fourth_char="${i:3:1}"
    fifth_char="${i:4:1}"
    sixth_char="${i:5:1}"

    if [[ $second_char -ne $first_char && $second_char -le $first_char ]] || [[ $third_char -ne $second_char && $third_char -le $second_char ]] || [[ $fourth_char -ne $third_char && $fourth_char -le $third_char ]] || [[ $fifth_char -ne $fourth_char && $fifth_char -le $fourth_char ]] || [[ $sixth_char -ne $fifth_char && $sixth_char -le $fifth_char ]]
    then
        increasecheck=false
    else 
        increasecheck=true
    fi
}


#===========================================================================
#
# Script
#
#===========================================================================
# create outfile
touch $outfile

for i in $(seq $start $end); 
do 
    # confirm amounts of numbers
    lengthcheck=`echo "${#i}"`
    # run tests
    if [[ $lengthcheck == "6" ]]; then
        adjacentcheck=`echo $i | grep -E '(.)\1{1}' 2>/dev/null`
        if [[ ! -z $adjacentcheck ]]; then
            identifydigits
            if [[ $increasecheck == "true" ]]; then
                echo $i >> $outfile
            fi
        fi
    fi
          
done

echo "Result = `wc -l $outfile | awk '{ print $1 }'`"