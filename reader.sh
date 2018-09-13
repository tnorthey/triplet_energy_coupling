#!/bin/bash

grep ' Excited state' $1 > excitation_energies.txt
grep -A 10 'Fragment Excitations of Triplet Excited State' $1 | grep -A 4 ' 1 ' > triplet_states.txt
grep -A 15 'FED Couplings' $1 | grep -A 9 ' 1    2 ' | awk '{print $1 " " $2 " " $6}' > fed_couplings.txt

