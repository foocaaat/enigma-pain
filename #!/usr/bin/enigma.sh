#!/usr/bin/bash
R5="QWERTZUIOASDFGHJKPYXCVBNML"
R2="ZOUESYDKFWPCIQXHMVBLGNJRAT"
R4="IMETCGFRAYSQBZXWLHKDVUPOJN"

R44="JWMBVSIARCXHGPFODTZEUYKQNL"
R22="DZWUSKOFJPVQNRAHTMXGIBLECY"
R55="RYUIPAHNBECWFDSJVTKZMXOGQL"

Re="VKWRGIETFZBUSPQNODMHLACYXJ"
bet=(Q W E R T Y U I O P A S D F G H J K L Z X C V B N M)


Plug="ABPVNGFQUJOTREKCHMYLIDWXSZ"

Rot=1
Root=6
Rooot=16

runthrough(){
    if [ $1 == 4 ];then
        list=(8 12 4 19 2 6 5 17 0 24 18 16 1 25 23 22 11 7 10 3 21 20 15 14 9 13)
    elif [ $1 == 5 ];then
        list=(16 22 4 17 19 25 20 8 14 0 18 3 5 6 7 9 10 15 24 23 2 21 1 13 12 11)
    elif [ $1 == 2 ];then
        list=(25 14 20 4 18 24 3 10 5 22 15 2 8 16 23 7 12 21 1 11 6 13 9 17 0 19)
    elif [ $1 == 0 ];then
        list=(21 10 22 17 6 8 4 19 5 25 1 20 18 15 16 13 14 3 12 7 11 0 2 24 23 9)
        echo ${list[$2]}
        return
    fi

    if [ $4 ];then
        input=$(($(($2+$3)) % 26 ))
        echo ${list[$input]}
    else
        for ((i=0; i<26; i++)); do
            if [ "$2" == ${list[i]} ]; then
                output=$(( i - $3 ))
                while (( output < 0 )); do
                    output=$(( 26 + output ))
                done
                output=$(( output % 26 ))
                echo $output
            fi
        done
    fi
}


Rot=1
Root=1
Rooot=1

function shift_string() {
    string=$1
    shift=$(($2 - 1))
    echo "${string:$shift}${string:0:$shift}"
}
function plug() {
    echo $1 | tr "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "ABPVNGFQUJOTREKCHMYLIDWXSZ"
}
function back() {
    rot=$(shift_string $1 $2)
    echo $3 | tr $rot "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
}

function tran() { 
    for i in "${!bet[@]}"; do
      if [ ${bet[i]} == $1 ]; then
         echo $((i))
      fi
      done
}

mes=$1

Rooot=16
Root=6
Rot=1

for (( i=0; i<${#mes}; i++ )); do
  test="${mes:$i:1}"
test=$(plug $test)
test=$(tran $test)
test=$(echo $(runthrough 5 $test $Rooot ye))
test=$(echo $(runthrough 2 $test $Root ye))
test=$(echo $(runthrough 4 $test $Rot ye))
test=$(echo $(runthrough 0 $test 1 ye))
test=$(echo $(runthrough 4 $test $Rot ))
test=$(echo $(runthrough 2 $test $Root ))
test=$(echo $(runthrough 5 $test $Rooot ))
test=${bet[test]}
test=$(plug $test)
dec=$dec$test

if [ $Rooot -lt 26 ];then
    Rooot=$((Rooot + 1))
else
    Rooot=1
    if [ $Root -lt 26 ];then
        Root=$((Root + 1))
    else
        Root=1
        if [ $Rot -lt 26 ];then
            Rot=$((Rot + 1))
        else
            Rot=1
        fi
    fi
fi
echo $Rot $Root $Rooot
done

echo $dec
