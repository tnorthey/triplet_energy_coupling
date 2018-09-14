#!/bin/bash
# Read relevant information from FED output file

Na=23
Nb=12

Nat=$(echo $Na+$Nb | bc)
x=$(echo $Nat+2 | bc)

grep -A $x 'Standard Nuclear Orientation' $1 | tail -n +4 > coords.txt
head -n $Na coords.txt > coordsa.txt
tail -n $Nb coords.txt > coordsb.txt
grep ' Excited state' $1 > excitation_energies.txt
grep -A 10 'Fragment Excitations of Triplet Excited State' $1 | grep -A 4 ' 1 ' > triplet_states.txt
grep -A 15 'FED Couplings' $1 | grep -A 9 ' 1    2 ' | awk '{print $1 " " $2 " " $6}' > fed_couplings.txt

