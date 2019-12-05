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

#outfile from previous puzzle
outfile=/tmp/outfilealternate
#new outfile
part2file=/tmp/part2file

#===========================================================================
#
# Functions
#
#===========================================================================

function identifylargesmallgroups() {
    first_char="${line:0:1}"
    second_char="${line:1:1}"
    third_char="${line:2:1}"
    fourth_char="${line:3:1}"
    fifth_char="${line:4:1}"
    sixth_char="${line:5:1}"

    #group of six
    sixtogether=`echo $line | grep -E '(.)\1{5}' 2>/dev/null`
        if [[ ! -z $sixtogether ]]; then
            groupofsix="found"
        else
            groupofsix="notfound"
        fi
    
    #group of five
    if [[ $second_char -eq $first_char && $third_char -eq $second_char && $fourth_char -eq $third_char && $fifth_char -eq $fourth_char && $sixth_char -ne $fifth_char ]] || [[ $second_char -ne $first_char && $third_char -eq $second_char && $fourth_char -eq $third_char && $fifth_char -eq $fourth_char && $sixth_char -eq $fifth_char ]];
    then
        groupof5="found"
    else
        groupof5="notfound"
    fi

    #group of four
    if [[ "$second_char" == "$first_char" && "$third_char" == "$second_char" && "$fourth_char" == "$third_char" ]] || [[ $third_char -eq $second_char && $fourth_char -eq $third_char && $fifth_char -eq $fourth_char ]] || [[ $fourth_char -eq $third_char && $fifth_char -eq $fourth_char && $sixth_char -eq $fifth_char ]];
    then
        groupof4="found" 
    else
        groupof4="notfound"
    fi
    
    #group of three
    if [[ $second_char -eq $first_char && $third_char -eq $second_char && $fourth_char -ne $third_char ]] || [[ $third_char -eq $second_char && $fourth_char -eq $third_char ]] || [[ $fourth_char -eq $third_char && $fifth_char -eq $fourth_char ]] || [[ $fifth_char -eq $fourth_char && $sixth_char -eq $fifth_char ]]
    then
        groupof3="found"
    else
        groupof3="notfound"
    fi

    # group of two
    if [[ $second_char -eq $first_char && $third_char -ne $second_char ]] || [[ $second_char -ne $first_char && $third_char -eq $second_char && $fourth_char -ne $third_char ]] || [[ $third_char -ne $second_char && $fourth_char -eq $third_char && $fifth_char -ne $fourth_char ]] || [[ $fourth_char -ne $third_char && $fifth_char -eq $fourth_char && $sixth_char -ne $fifth_char ]] || [[ $fifth_char -ne $fourth_char && $sixth_char -eq $fifth_char ]];
    then
        groupof2="found"
    else
        groupof2="notfound"
    fi    
}

#===========================================================================
#
# Script
#
#===========================================================================

touch $part2file
groupof2="notfound"
groupof3="notfound"
groupof4="notfound"
groupof5="notfound"
groupof6="notfound"

for line in $(cat $outfile)
do
    # check for digits part of larger group
    identifylargesmallgroups
    if [[ $groupof6 == "notfound" ]]; then
        if [[ $groupof5 == "notfound" ]]; then
            if [[ $groupof4 == "found" && $groupof2 == "found" ]] || [[ $groupof3 == "found" && $groupof2 == "found" ]] || [[ $groupof2 == "found" ]]; then
                echo $line >> $part2file
            fi
        fi
    fi
done

echo "Result = `wc -l $part2file | awk '{ print $1 }'`"
