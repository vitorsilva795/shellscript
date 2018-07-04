#!/bin/bash
clear;
echo -n "DIGITE A SUA IDADE: ";
read idade;
if [ $idade -lt 16 ]; then
echo "Proibido votar!!!";
elif [ $idade -ge 18 ] && [ $idade -le 70 ]; then
echo "Obrigatório votar!!!";
elif [ $idade -eq 16 ] || [ $idade -eq 17 ] || [ $idade -gt 70 ]; then
echo "Voto Facultativo. ";
fi
exit;
