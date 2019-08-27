#!/bin/bash

# cd Escritorio/SISOP019
# chmod +x ejercicio6.sh
# ./ejercicio6.sh Ejercicio6/Archivos xx 20190418
# ./ejercicio6.sh ~/Escritorio/Archivos xx 20190418

if [ "$1" == "-h" ] || [ "$1" == "-?" ] || [ "$1" == "-help" ];
then
    echo "Este script permite renombrar masivamente los archivo de un directorio utilizando un patron de busqueda en el nombre de los archivos"
    echo "Por ejemplo: ./ejercicio6.sh Ejercicio6/Archivos xx 20190418"
    exit
fi

if [ $# != 3 ]; then
    echo "La cantidad de parametros es incorrecta. Por favor ingrese 3 parametros."
    exit
fi

DIRECTORIO=$(pwd)

if [[ -d $1 ]]; then
    DIRECTORIO=$(realpath $1)
else
    echo "EL primer parametro NO es un directorio"
    exit
fi

BUSCAR=$2
REEMPLAZAR=$3

for ARCHIVO in "$DIRECTORIO"/*
do
    CARPETA=$(dirname "$ARCHIVO")
    NOMBRE_ARCHIVO=$(basename "$ARCHIVO")
    if [[ $NOMBRE_ARCHIVO == *$BUSCAR* ]]; then
        mv "$ARCHIVO" "$CARPETA"/"${NOMBRE_ARCHIVO//$BUSCAR/$REEMPLAZAR}"
    fi
done