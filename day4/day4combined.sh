#!/bin/bash
#===========================================================================
# It is a six-digit number.
# The value is within the range given in your puzzle input.
# Two adjacent digits are the same (like 22 in 122345).
# Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
#
# Huge thanks to my colleague MB for code refinement and decreasing runtime.
# 
#===========================================================================
#
# Variables
#
#===========================================================================

start=136760
end=595730
#part1 outfile
outfile=/tmp/outfile
#part2 outfile
part2file=/tmp/part2file

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

#

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
#
# Part 1
#
#===========================================================================

# create outfile
touch $outfile

# loop through input range

for i in $(seq $start $end);
do
    # run tests
    identifydigits
    if [[ $increasecheck == "true" ]]; then
        adjacentcheck=`echo $i | grep -E '(.)\1{1}' 2>/dev/null`
        if [[ ! -z $adjacentcheck ]]; then
            echo $i >> $outfile
        fi
    fi
done

#===========================================================================
#
# Part 2
#
#===========================================================================

# create outfile
touch $part2file

#set variables
groupof2="notfound"
groupof3="notfound"
groupof4="notfound"
groupof5="notfound"
groupof6="notfound"

# loop through outfile from part 1
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




echo "Part 1 Result = `wc -l $outfile | awk '{ print $1 }'`"
echo "Part 2 Result = `wc -l $part2file | awk '{ print $1 }'`"