#!/bin/bash

########### ENCABEZADO ###########
#
#   Nombre del script: ejercicio3.sh
#   Trabajo práctico: N°1
#   Ejercicio: N°3
#   Integrantes:
#       Matias Ángel Jimenénez Vitale   34.799.834
#       Maximiliano Federico Manso      37.792.709
#       Germán Alejandro                34.412.028
#       Jonathan Aranguri               40.672.991
#       Fernando Ezequiel Saldaña       38.346.178
#   Correspondiente a: Entrega
#
#################################




function ctrl_c {
    sleep 1
}

function tirarBolilla {

    if [ "$BOLILLAS_OBTENIDAS" == "-" ] # Para la primera pasada
    then
        bolillaObtenida=$(seq 0 99 | shuf -n 1) # Secuencia de 0 a 99 al "azar"
        BOLILLAS_OBTENIDAS="$bolillaObtenida" # ej. 4
        echo $bolillaObtenida
    else
        bolillaObtenida=$(seq 0 99 | grep -vwE  "($BOLILLAS_OBTENIDAS)" | shuf -n 1);  # Secuencia de 0 a 99 al "azar" SIN las bolillas que ya salieron
        BOLILLAS_OBTENIDAS="$BOLILLAS_OBTENIDAS|$bolillaObtenida" # ej. 4|67|99|0|23
        echo $bolillaObtenida
    fi
    cantBolillasObtenidas=$((cantBolillasObtenidas+1))

    #reemplazo las bolillas que salieron por una X en la tabla
    contenidoArchivo=$(printf '%s' "$contenidoArchivo" | awk -f "$RUTA/reemplazarValores.awk" -v bolilla=$bolillaObtenida)
    
    # obtenerResultados.awk devuelve un string con la siguiente estructura: 
    #
    #    l5555
    #    l9999
    #    b9999
    #    l1234
    #    b1234
    #
    # donde l siginifica si hizo linea y b si hizo bingo, lo que sigue es el numero de carton
    resultados=$(printf '%s' "$contenidoArchivo" | awk -f "$RUTA/obtenerResultados.awk")

    for linea in $resultados # itero por cada linea
    do
        
        if [ $PROCESAR_LINEA -eq 1 ] # Si no hubo lina(s) en las tiradas anteriores me fijo si la linea del texto es una linea
        then
            if [ "${linea:0:1}" == "l" ] # Me fijo si corresponde a una linea
            then
                
                if [ "$LINEA_CARTON" == "vacio" ]  # Me fijo no hay otros cartones que sean linea al mismo tiempo con esta bolilla
                then
                    LINEA_CARTON="${linea:1}" # Si no hay otros, pongo el primer carton de la linea
                   # echo $LINEA1_CARTON
                else
                    LINEA_CARTON="$LINEA_CARTON ${linea:1}" #Si da la casualidad que hay mas de un carton que saque linea, va a agregarlos aca
                   # echo $LINEA1_CARTON
                fi
            fi
        fi
        
        if [ $PROCESAR_BINGO -eq 1 ] # Me fijo si ya no salio bingo antes
        then
            if [ "${linea:0:1}" == "b" ] # Me fijo que si es bingo la actual linea del archivo
            then
                if [ "$BINGO_CARTON" == "vacio" ] # Me fijo si es bingo el primero
                then
                    BINGO_CARTON="${linea:1}" # Pongo como primer carton de bingo
                else
                    BINGO_CARTON="$BINGO_CARTON ${linea:1}" # Si justo da la casualidad de que varios son bingo con esta bollia los agrego aca
                fi
            fi
        fi
    done

    if [ "$LINEA_CARTON" != "vacio" ] # Si ya hubo una linea paso a deshabilitar la parte donde se verifican si hay lineas, porque gana solo la primer(as) linea
    then
        PROCESAR_LINEA=0
    fi

    if [ "$BINGO_CARTON" != "vacio" ] # Si ya hubo un bingo, muestro el resumen de los detalles y salgo del programa
    then
        echo "Cantidad de bolillas sorteadas: $cantBolillasObtenidas"
        echo "Cartones ganadores de linea: $LINEA_CARTON"
        echo "Cartones ganadores de bingo: $BINGO_CARTON"
        PROCESAR_BINGO=0
        exit
    fi
    
}



ayuda="--- Se le envia una archivo con una lista de numeros de cartones seguidos de sus correspondientes numeros. Se le envia una 
señal al script y esta señal genera una bolilla automaticamente  y se procede a revisar todos los cartones que poseen dicha bolilla, 
y revisa si un carton realizo linea o Bingo.

$(basename "$0") [-h] [archivo(s)]

    -h muestra la ayuda

Ejemplo:
    ./ejercicio3.sh Cartones.txt
"


########### VALIDACIONES ###########


if [ "$1" == "-h" ] || [ "$1" == "-?" ] || [ "$1" == "-help" ]
then
    echo "$ayuda"
fi


if [ $# -ne 1 ]
then
    echo "Cantidad de parametros invalidos."
    exit
fi

if [ ! -f "$1" ] 
then
    echo "$1 no es un archivo valido"
    exit
fi

contenido=$(cat $1)
if [ "$contenido" = "" ]
then
    echo "El archivo ingresado se encuentra vacio"
    exit
fi



########### INCIALIZACION DE VARIABLES ###########

cantBolillasObtenidas=0
LINEA_CARTON="vacio"
PROCESAR_LINEA=1
BINGO_CARTON="vacio"
PROCESAR_BINGO=1
contenidoArchivo=$(cat $1)
BOLILLAS_OBTENIDAS="-"
RUTA=$(dirname $0)

########### LOOP A LA ESPERA DE SEÑALES ###########
while [ 1 -eq 1 ]
do
    trap tirarBolilla SIGUSR1
    trap ctrl_c INT
done
########### FIN SCRIPT ###########