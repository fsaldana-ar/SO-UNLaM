#!/bin/bash

# cd Escritorio/SISOP019
# chmod +x ejercicio6.sh
# ./ejercicio5.sh "Ejercicio5/Archivos"
# ./ejercicio5.sh "Ejercicio5/Archivos" -t
# ./ejercicio5.sh "Ejercicio5/Archivos" -x log

generar_log () {
    echo "4 parametros $1 $2 $3"
    echo "Usuario: $USER" > "$1".log
    echo "Fecha: $(date +%d-%m-%Y_%H:%M:%S)" >> "$1".log
    echo "Listado de archivos comprimidos:" >> "$1".log

    CANT_FILES=($2/*.$3)
    
    if [ ${#CANT_FILES[@]} -gt 1 ]; then
        ls $2/*.$3 >> "$1".log
    else
        echo "NO hay archivos con extension .$3" >> "$1".log
    fi
}

if [ "$1" == "-h" ] || [ "$1" == "-?" ] || [ "$1" == "-help" ];
then
    echo "Este script permite generar un backup comprimido de un ruta especifica"
    echo "El script podra recibir los sig. parametros"
    echo "      -t para backupear todos los archivo"
    echo "      -x [extension] para backupear todos los archivos con dicha extension"
    echo "Por ejemplo: "
    echo "              ./ejercicio5.sh Ejercicio5/Archivos -t"
    echo "              ./ejercicio5.sh Ejercicio5/Archivos -x log"
    exit
fi

if [[ $# -lt 1 ]]; then
    echo "La cantidad de parametros es incorrecta. Por favor debe ingresar 2 o 3 parametros."
    exit
fi

DIRECTORIO=$(pwd)
if [[ -d $1 ]]; then
    DIRECTORIO=$(realpath $1)
else
    echo "El primer parametro NO es un directorio"
    exit
fi

NOMBRE_ZIP=$(date +%Y%m%d%H%M%S)
CARPETA_DESTINO="./backup"

if [[ "$2" == "-t" ]]; then
    mkdir -p "$CARPETA_DESTINO"
    zip -rj "$CARPETA_DESTINO/$NOMBRE_ZIP.zip" "$DIRECTORIO"/*
    generar_log "$CARPETA_DESTINO/$NOMBRE_ZIP" "$DIRECTORIO" "*"
elif [[ "$2" == "-x" ]] && [[ "$3" != "" ]]; then
    mkdir -p "$CARPETA_DESTINO"
    EXTENSION=$3
    CANT_FILES=("$DIRECTORIO"/*.$EXTENSION)
    if [ ${#CANT_FILES[@]} -gt 1 ]; then
       zip -rj "$CARPETA_DESTINO/$NOMBRE_ZIP-$EXTENSION.zip" "$DIRECTORIO"/*.$EXTENSION
    fi
    generar_log "$CARPETA_DESTINO/$NOMBRE_ZIP-$EXTENSION" "$DIRECTORIO" "$EXTENSION"
else
    echo "Error en los parametros ingresados. Consulte la ayuda para ejecutar correctamente el script"
    exit
fi

cd "$CARPETA_DESTINO"
rm `ls -t | grep "\.zip" | awk 'NR>5'` > /dev/null 2>&1
rm `ls -t | grep "\.log" | awk 'NR>5'` > /dev/null 2>&1