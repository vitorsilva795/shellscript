#!/bin/bash
clear;
echo "-------- TABUADA ---------------";
echo "";
echo -n "digite o valor da tabuada: ";
read tabuada;
for i in $(seq 1 10)
do 
echo "$tabuada x $i = $[tabuada*i]";
done
exit;
