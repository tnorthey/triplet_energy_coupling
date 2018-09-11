#!/bin/bash

head -n 37 residue1.xyz | tail -n 35 | awk '{print $1}' > atoms.column

for i in *.coords
do
  j=${i##*/}
  k=${j%.*}
  cat fed.template1 > "fed/${k}.inp"
  paste atoms.column $i >> "fed/${k}.inp"
  cat fed.template2 >> "fed/${k}.inp"
done

rm *.coords atoms.column
