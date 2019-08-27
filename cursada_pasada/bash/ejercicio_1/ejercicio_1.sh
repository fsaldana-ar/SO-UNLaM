#! /bin/bash
########### ENCABEZADO ###########
#
#   Nombre del script: ejercicio_1.sh
#   Trabajo práctico: N°1
#   Ejercicio: N°1
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

#if [ $# -lt 2 ]; then
#    echo "La cantidad de parametros ingresados es erronea.\nPor favor ingrese 2 o mas paramentros. Ej: ./ejercicio_1.sh 23123456789 archivo_1.tmp archivo_2.tmp archivo_3.tmp"
if [ $# != 2 ]; then
    echo "La cantidad de parametros ingresados es erronea.\nPor favor ingrese 2 paramentros. Ej: ./ejercicio_1.sh 23123456789 archivo_1.tmp"
    exit
fi

if ! [ -f "$2" ]; then
    echo "$2 no es archivo."
    exit
fi


CUIT_A_BUSCAR=$1
#cat "${@:2}" | awk 'BEGIN {
awk 'BEGIN {
    FIELDWIDTHS = "11 30"
}

$1 == "'$CUIT_A_BUSCAR'" {
    print "Nombre                         CUIT"
    print "------------------------------ ------------"
    print $2" "$1
exit
}' $2 
#}'

########### FIN SCRIPT ###########

########### PREGUNTAS Y RESPUESTAS ###########
# a) ¿Qué significa la línea “#!/bin/bash”?
#       Indica con que interprete de comandos se ejecutara el script, independientemente de que sea llamado con otro.
# b) ¿Con qué comando y de qué manera otorgó los permisos de ejecución al script?
#       El comando utilizado es chmod y lo usamos de la siguiente manera 
#           chmod +x ejercicio_1.sh 
# c) Explique el objetivo general del script.
#       El objectivo general del script es buscar un contribuyente a treavés de su cuit en una lista de contribuyenres guardada en un archivo.
#           ./ejercicio_1.sh 23123456789 archivo_de_contribuyenes
# d) Complete los echo "..." con mensajes acordes a cada situación según lo que se valida y
# renombre la variable X con un nombre acorde a su utilidad.
#       Hecho en el script
# e) Explique de manera general la utilidad de AWK.
#       AWK sirve para procesar flujo o archivos de texto. Por lo generarl recibe 2 archivos/flujo de texto (Uno de ordenes y otro de entrada).
#       El primero posee las ordenes/acciones con las que va a trabajar en cada linea y el segundo posee los datos que se van a procesar.
# f) ¿Es posible ejecutar este script para procesar varios archivos a la vez en una única llamada?
#       Si, es posible. Se pasaria como parametro al awk la concatenacion de los carchivos. 
#           Ej: cat "${@:2}" | awk ...
# Ejemplifique.

# NOTA, para que el codigo funcione en el punto F hay que descomentar los comentarios de la parte de codigo.