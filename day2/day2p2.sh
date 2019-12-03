#!/bin/bash
#
# position 0 = defines + or *
# position 1 = defines location of first integer
# position 2 = defines location of second integer
# position 3 = defines where to save the output of calculation
#
#=============================================================================================
#create array

fuelcalc=1,82,98,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,5,19,23,1,23,5,27,1,27,13,31,1,31,5,35,1,9,35,39,2,13,39,43,1,43,10,47,1,47,13,51,2,10,51,55,1,55,5,59,1,59,5,63,1,63,13,67,1,13,67,71,1,71,10,75,1,6,75,79,1,6,79,83,2,10,83,87,1,87,5,91,1,5,91,95,2,95,10,99,1,9,99,103,1,103,13,107,2,10,107,111,2,13,111,115,1,6,115,119,1,119,10,123,2,9,123,127,2,127,9,131,1,131,10,135,1,135,2,139,1,10,139,0,99,2,0,14,0
IFS=',' read -r -a array <<< "$fuelcalc"

#variables
startingindex=0
indexsectionincrement=4
startingindexvalue=$(echo "${array["$startingindex"]}")

# set starting noun and verb in array
setnoun=`array[1]=1`
setverb=`array[2]=1`
startingnoun=$(echo "${array[1]}")
startingverb=$(echo "${array[2]}")
found="notfound"
#=============================================================================================

while [[ $found != "found" ]]
do
    setstartingnoun=$setnoun
    setstartingverb=$setverb
    startingnoun=$(echo "${array[1]}")
    startingverb=$(echo "${array[2]}")
    

    while [[ $startingindexvalue != "99" ]]
    do
        if [[ $startingindexvalue == "1" ]]; then
            mathfunction=+
        elif [[ $startingindexvalue == "2" ]]; then
            mathfunction=*
        fi

        # Index 1
        position1=`expr $startingindex + 1` 
        pos1value=$(echo "${array["$position1"]}")
        pos1final=$(echo "${array["$pos1value"]}")

        # Index 2
        position2=`expr $startingindex + 2`
        pos2value=$(echo "${array["$position2"]}")
        pos2final=$(echo "${array["$pos2value"]}")

        # Index 3
        position3=`expr $startingindex + 3`
        pos3value=$(echo "${array["$position3"]}")
        pos3final=$(echo "${array["$pos3value"]}")

        calculated=`expr $pos1final "$mathfunction" $pos2final`

        #update position 3
        array[$pos3value]=$calculated

        #set new starting position
        startingindex=`expr $startingindex + 4`
        startingindexvalue=$(echo "${array[$startingindex]}")

        # output current noun and verb
        noun=$(echo "${array[1]}")
        verb=$(echo "${array[2]}")
    done

    #array checks
    arraycheck=$(echo "${array[0]}")
    #echo $arraycheck
    # nouncheck=$(echo "${array[1]}")
    # verbcheck=$(echo "${array[2]}")

    if [[ "$arraycheck" == "19690720" ]]; then
        found="found"
    else
        if [[ $startingverb == "99" ]]; then
            incrementnoun=`expr $startingnoun + 1`
            setnoun=`array[1]=$incrementnoun`
            setverb=`array[2]=1`
        else
            incrementverb=`expr $startingverb + 1`
            setverb=`array[2]=$incrementverb`
            startingverb=$(echo "${array[2]}")
        fi
    fi
done

echo "Output = ""${array[0]}"
echo "Noun = $noun"
echo "Verb = $verb"
echo "Result = $noun$verb"