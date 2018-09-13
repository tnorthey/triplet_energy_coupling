#!/bin/bash

head -n 37 residue1.xyz | tail -n 35 | awk '{print $1}' > atoms.column

for i in $1/*.coords
do
  j=${i##*/}
  k=${j%.*}
  cat fed.template1 > "$1/${k}.inp"
  paste atoms.column $i >> "$1/${k}.inp"
  cat fed.template2 >> "$1/${k}.inp"
done

rm atoms.column
