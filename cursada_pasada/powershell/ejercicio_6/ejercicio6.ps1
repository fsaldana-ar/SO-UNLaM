########### ENCABEZADO ###########

#

#   Nombre del script: ejercicio6.ps1

#   Trabajo práctico: N°2
#   Ejercicio: N°6
#   Integrantes:

#       Matias Ángel Jimenénez Vitale   34.799.834

#       Maximiliano Federico Manso      37.792.709

#       Germán Alejandro                34.412.028

#       Jonathan Aranguri               40.672.991

#       Fernando Ezequiel Saldaña       38.346.178

#   Correspondiente a: Entrega

#

#################################

<#
    .SYNOPSIS

    Dado un archivo de entrada correspondiente a una matriz se realiza una de las siguientes acciones:
	- Producto escalar.
	- Trasponer la matriz.
    Y se guarda el resultado en un archivo de salida.

    .DESCRIPTION
    Se informa la cantidad de archivos que se encuentran en la direci�n que se recibe por par�metro, o se informa
    la cantidad de procesos que se encuetran corriendo en ese momento; seg�n se reciba por parametro, cada cierto
    intervalo de tiempo. 
    Para detener el proceso, ejecutar la siguiente linea:
    Unregister-Event TimerEvent

    .PARAMETER Entrada
    Indica el path del archivo de entrada, el cual contiene la matriz sobre la cual se va a realizar los procesos.

    .PARAMETER Producto 
    Indica el numero con el que se realizara producto escalar a la matriz que viene en la entrada.

    .PARAMETER Trasponer
    Indica el que se debe trasponer la matriz.No se puede usar junto con Producto.

    .EXAMPLE
        .\ejercicio6.ps1 -Entrada -Producto
	    .\ejercicio6.ps1 -Trasponer
        
#>
function transpose($a) {
    $arr = @()
    if($a) { 
        $n = $a.count - 1 
        if(0 -lt $n) { 
            $m = ($a | foreach {$_.count} | measure-object -Minimum).Minimum - 1
            if( 0 -le $m) {
                if (0 -lt $m) {
                    $arr =@(0)*($m+1)
                    foreach($i in 0..$m) {
                        $arr[$i] = foreach($j in 0..$n) {@($a[$j][$i])}    
                    }
                } else {$arr = foreach($row in $a) {$row[0]}}
            }
        } else {$arr = $a}
    }
    $arr
} 
function show($a) {
    if($a) { 
        0..($a.Count - 1) | foreach{ if($a[$_]){"$($a[$_])"}else{""} }
    }
}
function scalar_product($a,$scalar){

    $arr= @()
    foreach($i=0;i -lt $a.Length; $i++){
        $arr[$i]= $a[i]*$scalar
    }
    $arr 
} 


<#
$a = @(@(2, 0, 7, 8),@(3, 5, 9, 1),@(4, 1, 6, 3))
"`$a ="
show $a
""
"transpose `$a ="
show (transpose $a)
#>
