#!/bin/bash

########################################################################
## 		   Trabajo Practico Nro 1			      ##
##								      ##
##   			Ejercicio 04				      ##
########################################################################

_AYUDA()
{
	echo "El script permite controlar la similitud de un archivo base contra los archivos contenidos en un directorio."
	echo "Comparara un archivo pasado por par�metro contra cada uno de los archivos encontrados en una rama de directorios tambi�n pasado por par�metro, informando los archivos que tienen cierto porcentaje de igualdad."
        echo "Se recibe por par�metro el archivo base, la ruta de directorio (opcional) y un porcentaje m�nimo de igualdad."
	echo "Ejemplo 1: ./Ejercicio4.sh archivo directorio 80"
	echo "Ejemplo 2: ./Ejercicio4.sh archivo 75"
	exit 0  
}

#Validamos que la cantidad de parametros sea correcta
if [ $# -lt 1 ] || [ $# -gt 3 ]
then
    _AYUDA
fi

#Filtramos las distintas opciones
if [ $# -eq 1 ] 
then
  if [ "$1" = "-h" ] || [ "$1" = "-?" ] || [ "$1" = "-help" ]  #verificamos si se pide ayuda
  then
    _AYUDA
  else
    echo "Opcion incorrecta o mal ingresada."  
    _AYUDA
  fi

# Si pasan el directorio como par�metro
elif  [ $# -ge 2 ]
  then
		if [ $# -eq 3 ]
		then 
	#	echo $2
			cd $2
		fi
		tamarch=$(stat -c%s $1)
	#echo $tamarch
	lista_archivos=*.*
	for entry in $lista_archivos
	do
	
	comm --nocheck-order $1 $entry > auxiliar
	
		tamarch2=$(stat -c %s $entry)
		porcentaje=$(((tamarch2*100)/tamarch))
		if [ $porcentaje -ge $3 ]
		then
			echo $entry
		fi

	done
	wait



fi