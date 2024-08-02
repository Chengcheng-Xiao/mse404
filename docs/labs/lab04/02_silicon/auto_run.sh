#!/bin/bash

template="Si_base.in"
repstr="xxxx"

for val in {02..10..2}
do
  inp="Si_${val}.in"
  # We add the g here to replace every entry on the line.
  sed "s/$repstr/$val/g" $template > $inp
  pw.x < $inp &> ${inp%.*}.out
done

awk '/number of k points/{nkpt=$5}
     /^!.*total/{print nkpt, $5}' *out > etot_v_nkpt.dat
