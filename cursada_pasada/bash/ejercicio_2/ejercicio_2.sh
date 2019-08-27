#! /bin/bash
########### ENCABEZADO ###########
#
#   Nombre del script: ejercicio_2.sh
#   Trabajo práctico: N°1
#   Ejercicio: N°2
#   Integrantes:
#       Matias Ángel Jimenénez Vitale   34.799.834
#       Maximiliano Federico Manso      37.792.709
#       Germán Alejandro                34.412.028
#       Jonathan Aranguri               40.672.991
#       Fernando Ezequiel Saldaña       38.346.178
#   Correspondiente a: Entrega
#
#################################

########### INICIO SCRIPT ###########

RUTA=$(dirname $0)

usage="-- Este programa filtra los datos de un contribuyente por cuit | dni | nombre

$(basename "$0") [-h] [-c|d|n val] [archivo(s)] 

Donde:
    -h  Muestra la ayuda
    -c  Indica que el filtro sera por cuit
    -d  Indica que el filtro sera por DNI
    -n  Indica que el filtro sera por nombre
"

ayuda="AYUDA -- Este programa filtra los datos de un contribuyente por cuit | dni | nombre

$(basename "$0") [-h] [-c|d|n val] [archivo(s)] 

Donde:
    -h  Muestra la ayuda
    -c  Indica que el filtro sera por cuit
    -d  Indica que el filtro sera por DNI
    -n  Indica que el filtro sera por nombre

Ejemplo:
    ./ejercicio_2.sh -n \"JOSE\" SELE-SAL-CONSTA.p20out1.20190413.tmp
"

while getopts 'c:d:n:help:?h' OPCION; do
  case "$OPCION" in
    d | c | n) VAL=$OPTARG
       OP="$OPCION" 
       ;;
    help) echo "$ayuda"
       exit
       ;;
    :) printf "Falta valor para el parametro -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
    h | ?) echo "$ayuda"
       exit
       ;;
   \?) printf "Opcion invalida: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))



if [ $# -lt 1 ]; then
    printf "La cantidad de parametros es erronea\n" >&2
    echo "$usage" >&2
    exit 1
fi

for file in "${@:1}"
do
    if ! [ -f "$file" ]; then
        printf "'%s' no es un archivo\n" "$file" >&2
        echo "$usage" >&2
        exit 1
    fi
done

# Ejecuto el script de awk
cat "${@:1}" | awk  -f "$RUTA/ejercicio_2.awk" -v OP="$OP"  -v VAL="$VAL" 

########### FIN SCRIPT ###########