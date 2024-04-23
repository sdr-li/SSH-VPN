#!/bin/sh

x=1
while [ $x -lt 5 ]
do
  echo "Welcome $x times"
  x=$(( $x + 1 ))
done
